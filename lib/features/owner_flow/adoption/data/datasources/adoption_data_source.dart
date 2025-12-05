import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/core/utils/Exception/custom_exception.dart';
import 'package:rifq/features/owner_flow/add_pet/data/models/pet_model.dart';
import 'package:rifq/features/owner_flow/adoption/data/models/adoption_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AdoptionDataSource {
  /// Pet owner can get all their pets (to choose which one to offer for adoption)
  /// Uses the currently logged-in user's ID
  Future<Result<List<PetModel>, Object>> getMyPets();

  /// Pet owner can add his/her pet for adoption
  Future<Result<PetModel, Object>> addPetForAdoption({required PetModel pet});

  /// Pet owner can see the number of requests on his/her offered pet
  Future<Result<int, Object>> getAdoptionRequestCountForPet({
    required String petId,
    required String ownerId,
  });

  /// Pet owner can see all adoption requests for a specific pet
  Future<Result<List<AdoptionModel>, Object>> getAdoptionRequestsForPet({
    required String petId,
    required String ownerId, // to verify ownership
  });

  /// Pet owner can remove his/her own pet from being adopted
  Future<Result<Null, Object>> removePetFromAdoption({
    required String petId,
    required String ownerId,
  });

  /// Pet owner can get all their pets that are currently offered for adoption
  /// Uses the currently logged-in user's ID
  Future<Result<List<PetModel>, Object>> getOfferedPetsForAdoption();

  /// Pet owner can accept or reject a request coming from a user
  /// [status] should be: 'adopted' (accepted) or 'reserved' (rejected)
  Future<Result<AdoptionModel, Object>> updateAdoptionRequestStatus({
    required String requestId,
    required String ownerId, // to ensure only the pet owner can decide
    required String status, // 'adopted' | 'reserved'
  });

  /// Regular user can see all the pets that are available to be adopted
  Future<Result<List<PetModel>, Object>> getAvailablePetsForAdoption();

  /// Regular user can send a request to pet owner to adopt their pet
  Future<Result<AdoptionModel, Object>> sendAdoptionRequest({
    required String petId,
    required String userId, // adopter's user id
    required String title,
    required String description,
  });

  /// Regular user can see details of a pet available to be adopted
  Future<Result<PetModel, Object>> getPetDetails({required String petId});

  /// Regular user can see all their own adoption requests
  Future<Result<List<AdoptionModel>, Object>> getUserAdoptionRequests({
    required String userId,
  });

  /// Regular user can cancel their own adoption request
  Future<Result<AdoptionModel, Object>> cancelAdoptionRequest({
    required String requestId,
    required String userId,
  });
}

@LazySingleton(as: AdoptionDataSource)
class AdoptionDataBaseSoruce implements AdoptionDataSource {
  final SupabaseClient supabase;

  AdoptionDataBaseSoruce(this.supabase);

  @override
  Future<Result<List<PetModel>, Object>> getMyPets() async {
    try {
      // Get current logged-in user's auth ID
      final authUser = supabase.auth.currentUser;
      if (authUser == null) {
        return Result.error('User not logged in');
      }

      // Get user ID from users table
      final userResponse = await supabase
          .from('users')
          .select('id')
          .eq('auth_id', authUser.id)
          .maybeSingle();

      if (userResponse == null) {
        return Result.error('User profile not found');
      }

      final ownerId = userResponse['id'] as String;

      // Get pets owned by the current user
      final response = await supabase
          .from('pets')
          .select()
          .eq('owner_id', ownerId)
          .order('created_at', ascending: false);

      final List<PetModel> pets = (response as List).map((item) {
        // Provide default photo if missing
        final dataWithPhoto = Map<String, dynamic>.from(item);
        if (dataWithPhoto['photo'] == null || dataWithPhoto['photo'] == '') {
          dataWithPhoto['photo'] = '';
        }
        return PetModelMapper.fromMap(dataWithPhoto);
      }).toList();

      return Result.success(pets);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<PetModel, Object>> addPetForAdoption({
    required PetModel pet,
  }) async {
    try {
      // Verify pet exists and belongs to the owner
      final petCheck = await supabase
          .from('pets')
          .select('owner_id')
          .eq('id', pet.id)
          .eq('owner_id', pet.ownerId)
          .maybeSingle();

      if (petCheck == null) {
        return Result.error('Pet not found or you are not the owner');
      }

      // Check if pet already exists in Adoption table with 'adopted' status
      // If pet has been adopted, it should not be available for adoption again
      final adoptedCheck = await supabase
          .from('adoptions')
          .select('id, status')
          .eq('pet_id', pet.id)
          .eq('status', 'adopted')
          .maybeSingle();

      if (adoptedCheck != null) {
        return Result.error(
          'This pet has already been adopted and cannot be offered for adoption again',
        );
      }

      // Check if pet is already available for adoption (status = 'active')
      final existing = await supabase
          .from('adoptions')
          .select('id')
          .eq('pet_id', pet.id)
          .eq('owner_id', pet.ownerId) // Availability marker
          .eq('status', 'active')
          .maybeSingle();

      if (existing != null) {
        return Result.error('Pet is already available for adoption');
      }

      // Create availability marker (adoption record with pet owner as owner_id)
      await supabase.from('adoptions').insert({
        'pet_id': pet.id,
        'owner_id': pet.ownerId, // Pet owner (availability marker)
        'title': 'Available for Adoption',
        'description': 'This pet is available for adoption',
        'status': 'active',
      });

      return Result.success(pet);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<int, Object>> getAdoptionRequestCountForPet({
    required String petId,
    required String ownerId,
  }) async {
    try {
      // Verify pet ownership
      final pet = await supabase
          .from('pets')
          .select('owner_id')
          .eq('id', petId)
          .eq('owner_id', ownerId)
          .maybeSingle();

      if (pet == null) {
        return Result.error('Pet not found or you are not the owner');
      }

      // Count adoption requests (exclude availability marker)
      final response = await supabase
          .from('adoptions')
          .select('id')
          .eq('pet_id', petId)
          .neq('owner_id', ownerId) // Exclude availability marker
          .eq('status', 'active');

      final count = (response as List).length;
      return Result.success(count);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<List<AdoptionModel>, Object>> getAdoptionRequestsForPet({
    required String petId,
    required String ownerId,
  }) async {
    try {
      // Verify pet ownership
      final pet = await supabase
          .from('pets')
          .select('owner_id')
          .eq('id', petId)
          .eq('owner_id', ownerId)
          .maybeSingle();

      if (pet == null) {
        return Result.error('Pet not found or you are not the owner');
      }

      // Get adoption requests (exclude availability marker)
      final response = await supabase
          .from('adoptions')
          .select()
          .eq('pet_id', petId)
          .neq('owner_id', ownerId) // Exclude availability marker
          .eq('status', 'active')
          .order('created_at', ascending: false);

      final List<AdoptionModel> requests = (response as List)
          .map((item) => AdoptionModelMapper.fromMap(item))
          .toList();

      return Result.success(requests);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<Null, Object>> removePetFromAdoption({
    required String petId,
    required String ownerId,
  }) async {
    try {
      // Verify pet ownership
      final pet = await supabase
          .from('pets')
          .select('owner_id')
          .eq('id', petId)
          .eq('owner_id', ownerId)
          .maybeSingle();

      if (pet == null) {
        return Result.error('Pet not found or you are not the owner');
      }

      // Delete availability marker (no 'cancelled' status, so we delete the record)
      await supabase
          .from('adoptions')
          .delete()
          .eq('pet_id', petId)
          .eq('owner_id', ownerId) // Availability marker
          .eq('status', 'active');

      // Delete all active adoption requests for this pet
      await supabase
          .from('adoptions')
          .delete()
          .eq('pet_id', petId)
          .neq('owner_id', ownerId) // Exclude availability marker
          .eq('status', 'active');

      return Result.success(null);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<List<PetModel>, Object>> getOfferedPetsForAdoption() async {
    try {
      // Get current logged-in user's auth ID
      final authUser = supabase.auth.currentUser;
      if (authUser == null) {
        return Result.error('User not logged in');
      }

      // Get user ID from users table
      final userResponse = await supabase
          .from('users')
          .select('id')
          .eq('auth_id', authUser.id)
          .maybeSingle();

      if (userResponse == null) {
        return Result.error('User profile not found');
      }

      final ownerId = userResponse['id'] as String;

      // Get adoption records where owner_id matches pet owner_id and status is 'active'
      // These are the availability markers for pets offered for adoption
      final adoptionsResponse = await supabase
          .from('adoptions')
          .select('pet_id, owner_id')
          .eq('owner_id', ownerId) // Pet owner (availability marker)
          .eq('status', 'active');

      if (adoptionsResponse.isEmpty) {
        return Result.success([]);
      }

      // Extract pet_ids from adoption records
      final Set<String> petIds = (adoptionsResponse as List)
          .map((item) => item['pet_id'] as String)
          .toSet();

      if (petIds.isEmpty) {
        return Result.success([]);
      }

      // Fetch all pets for the owner
      final allPetsResponse = await supabase
          .from('pets')
          .select()
          .eq('owner_id', ownerId);

      // Filter pets that are in the petIds set (pets with active adoption records)
      final List<PetModel> pets = (allPetsResponse as List)
          .where((item) => petIds.contains(item['id'] as String))
          .map((item) {
            final dataWithPhoto = Map<String, dynamic>.from(item);
            if (dataWithPhoto['photo'] == null ||
                dataWithPhoto['photo'] == '') {
              dataWithPhoto['photo'] = '';
            }
            return PetModelMapper.fromMap(dataWithPhoto);
          })
          .toList();

      return Result.success(pets);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<AdoptionModel, Object>> updateAdoptionRequestStatus({
    required String requestId,
    required String ownerId,
    required String status,
  }) async {
    try {
      // Map old status values to new database values for backward compatibility
      String dbStatus;
      bool isAccepted;

      if (status == 'adopted' || status == 'accepted') {
        dbStatus = 'adopted';
        isAccepted = true;
      } else if (status == 'reserved' || status == 'rejected') {
        dbStatus = 'reserved';
        isAccepted = false;
      } else {
        return Result.error(
          'Status must be either "adopted"/"accepted" or "reserved"/"rejected"',
        );
      }

      // Get the adoption request
      final adoption = await supabase
          .from('adoptions')
          .select('pet_id')
          .eq('id', requestId)
          .maybeSingle();

      if (adoption == null) {
        return Result.error('Adoption request not found');
      }

      final petId = adoption['pet_id'] as String;

      // Verify pet ownership
      final pet = await supabase
          .from('pets')
          .select('owner_id')
          .eq('id', petId)
          .eq('owner_id', ownerId)
          .maybeSingle();

      if (pet == null) {
        return Result.error('You are not the owner of this pet');
      }

      // Update the adoption request status
      final response = await supabase
          .from('adoptions')
          .update({'status': dbStatus})
          .eq('id', requestId)
          .select()
          .single();

      final updatedAdoption = AdoptionModelMapper.fromMap(response);

      // If adopted, delete availability marker and other active requests
      if (isAccepted) {
        // Delete availability marker
        await supabase
            .from('adoptions')
            .delete()
            .eq('pet_id', petId)
            .eq('owner_id', ownerId)
            .eq('status', 'active');

        // Delete other active requests for the same pet
        await supabase
            .from('adoptions')
            .delete()
            .eq('pet_id', petId)
            .neq('owner_id', ownerId)
            .eq('status', 'active')
            .neq('id', requestId);
      }

      return Result.success(updatedAdoption);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<List<PetModel>, Object>> getAvailablePetsForAdoption() async {
    try {
      // Get pets that have availability markers (adoption records where owner_id = pet owner)
      final response = await supabase
          .from('adoptions')
          .select('''
            pets!inner(*)
          ''')
          .eq('status', 'active');

      // Extract unique pets where adoption owner_id matches pet owner_id (availability markers)
      final List<PetModel> pets = [];
      final Set<String> seenPetIds = {};

      for (var item in response as List) {
        final petData = item['pets'];
        if (petData != null && petData['id'] != null) {
          final petId = petData['id'] as String;
          final adoptionOwnerId = item['owner_id'] as String?;
          final petOwnerId = petData['owner_id'] as String?;

          // Only include pets where adoption owner_id matches pet owner_id (availability marker)
          if (adoptionOwnerId == petOwnerId && !seenPetIds.contains(petId)) {
            seenPetIds.add(petId);
            final dataWithPhoto = Map<String, dynamic>.from(petData);
            if (dataWithPhoto['photo'] == null ||
                dataWithPhoto['photo'] == '') {
              dataWithPhoto['photo'] = '';
            }
            pets.add(PetModelMapper.fromMap(dataWithPhoto));
          }
        }
      }

      return Result.success(pets);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<AdoptionModel, Object>> sendAdoptionRequest({
    required String petId,
    required String userId,
    required String title,
    required String description,
  }) async {
    try {
      // Check if pet exists
      final pet = await supabase
          .from('pets')
          .select('owner_id')
          .eq('id', petId)
          .maybeSingle();

      if (pet == null) {
        return Result.error('Pet not found');
      }

      final petOwnerId = pet['owner_id'] as String;

      // Check if user is trying to adopt their own pet
      if (userId == petOwnerId) {
        return Result.error(
          'You cannot send an adoption request for your own pet',
        );
      }

      // Check if pet is available for adoption (has availability marker)
      final availableCheck = await supabase
          .from('adoptions')
          .select('id')
          .eq('pet_id', petId)
          .eq('owner_id', petOwnerId) // Availability marker
          .eq('status', 'active')
          .maybeSingle();

      if (availableCheck == null) {
        return Result.error('This pet is not available for adoption');
      }

      // Check if user already sent a request for this pet
      final existingRequest = await supabase
          .from('adoptions')
          .select('id')
          .eq('pet_id', petId)
          .eq('owner_id', userId) // Requester
          .eq('status', 'active')
          .maybeSingle();

      if (existingRequest != null) {
        return Result.error(
          'You have already sent an adoption request for this pet',
        );
      }

      // Create adoption request (owner_id is the requester)
      final response = await supabase
          .from('adoptions')
          .insert({
            'pet_id': petId,
            'owner_id': userId, // Requester ID
            'title': title,
            'description': description,
            'status': 'active',
          })
          .select()
          .single();

      final adoption = AdoptionModelMapper.fromMap(response);
      return Result.success(adoption);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<PetModel, Object>> getPetDetails({
    required String petId,
  }) async {
    try {
      final response = await supabase
          .from('pets')
          .select()
          .eq('id', petId)
          .maybeSingle();

      if (response == null) {
        return Result.error('Pet not found');
      }

      final dataWithPhoto = Map<String, dynamic>.from(response);
      if (dataWithPhoto['photo'] == null || dataWithPhoto['photo'] == '') {
        dataWithPhoto['photo'] = '';
      }

      final pet = PetModelMapper.fromMap(dataWithPhoto);
      return Result.success(pet);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<List<AdoptionModel>, Object>> getUserAdoptionRequests({
    required String userId,
  }) async {
    try {
      // Get all adoption requests made by this user
      final response = await supabase
          .from('adoptions')
          .select()
          .eq('owner_id', userId) // Requester
          .order('created_at', ascending: false);

      final List<AdoptionModel> requests = (response as List)
          .map((item) => AdoptionModelMapper.fromMap(item))
          .toList();

      return Result.success(requests);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<AdoptionModel, Object>> cancelAdoptionRequest({
    required String requestId,
    required String userId,
  }) async {
    try {
      // Verify the request belongs to the user
      final adoption = await supabase
          .from('adoptions')
          .select('owner_id')
          .eq('id', requestId)
          .maybeSingle();

      if (adoption == null) {
        return Result.error('Adoption request not found');
      }

      final requestOwnerId = adoption['owner_id'] as String;
      if (requestOwnerId != userId) {
        return Result.error('You can only cancel your own adoption requests');
      }

      // Get the full adoption record before deleting
      final adoptionRecord = await supabase
          .from('adoptions')
          .select()
          .eq('id', requestId)
          .single();

      // Delete the adoption request (no 'cancelled' status)
      await supabase.from('adoptions').delete().eq('id', requestId);

      final cancelledAdoption = AdoptionModelMapper.fromMap(adoptionRecord);
      return Result.success(cancelledAdoption);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }
}
