import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/core/utils/Exception/custom_exception.dart';
import 'package:rifq/features/owner_flow/add_pet/data/models/pet_model.dart';
import 'package:rifq/features/owner_flow/adoption/data/models/adoption_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AdoptionDataSource {
  Future<Result<List<PetModel>, Object>> getMyPets();

  Future<Result<PetModel, Object>> addPetForAdoption({required PetModel pet});

  Future<Result<List<AdoptionModel>, Object>> getAdoptionRequestsForPet({
    required String petId,
    required String ownerId,
  });

  Future<Result<Null, Object>> removePetFromAdoption({
    required String petId,
    required String ownerId,
  });

  Future<Result<List<PetModel>, Object>> getOfferedPetsForAdoption();

  Future<Result<AdoptionModel, Object>> updateAdoptionRequestStatus({
    required String requestId,
    required String ownerId,
    required String status,
  });

  Future<Result<List<PetModel>, Object>> getAvailablePetsForAdoption();

  Future<Result<AdoptionModel, Object>> sendAdoptionRequest({
    required String petId,

    required String title,
    required String description,
  });

  Future<Result<PetModel, Object>> getPetDetails({required String petId});

  Future<Result<String, Object>> getUserName({required String userId});
}

@LazySingleton(as: AdoptionDataSource)
class AdoptionDataBaseSoruce implements AdoptionDataSource {
  final SupabaseClient supabase;

  AdoptionDataBaseSoruce(this.supabase);

  @override
  Future<Result<List<PetModel>, Object>> getMyPets() async {
    try {
      final authUser = supabase.auth.currentUser;
      if (authUser == null) {
        return Result.error('User not logged in');
      }

      final userResponse = await supabase
          .from('users')
          .select('id')
          .eq('auth_id', authUser.id)
          .maybeSingle();

      if (userResponse == null) {
        return Result.error('User profile not found');
      }

      final ownerId = userResponse['id'] as String;

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
      final petCheck = await supabase
          .from('pets')
          .select('owner_id')
          .eq('id', pet.id)
          .eq('owner_id', pet.ownerId)
          .maybeSingle();

      if (petCheck == null) {
        return Result.error('Pet not found or you are not the owner');
      }
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

      final existing = await supabase
          .from('adoptions')
          .select('id')
          .eq('pet_id', pet.id)
          .eq('owner_id', pet.ownerId)
          .eq('status', 'active')
          .maybeSingle();

      if (existing != null) {
        return Result.error('Pet is already available for adoption');
      }

      await supabase.from('adoptions').insert({
        'pet_id': pet.id,
        'owner_id': pet.ownerId,
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
  Future<Result<List<AdoptionModel>, Object>> getAdoptionRequestsForPet({
    required String petId,
    required String ownerId,
  }) async {
    try {
      final pet = await supabase
          .from('pets')
          .select('owner_id')
          .eq('id', petId)
          .eq('owner_id', ownerId)
          .maybeSingle();

      if (pet == null) {
        return Result.error('Pet not found or you are not the owner');
      }

      final response = await supabase
          .from('adoptions')
          .select()
          .eq('pet_id', petId)
          .neq('owner_id', ownerId)
          .eq('status', 'active')
          .order('created_at', ascending: false);

      final List<AdoptionModel> requests = (response as List).map((item) {
        // Ensure created_at is present
        final itemWithCreatedAt = Map<String, dynamic>.from(item);
        if (!itemWithCreatedAt.containsKey('created_at') ||
            itemWithCreatedAt['created_at'] == null) {
          itemWithCreatedAt['created_at'] = DateTime.now().toIso8601String();
        }
        return AdoptionModelMapper.fromMap(itemWithCreatedAt);
      }).toList();

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
      final pet = await supabase
          .from('pets')
          .select('owner_id')
          .eq('id', petId)
          .eq('owner_id', ownerId)
          .maybeSingle();

      if (pet == null) {
        return Result.error('Pet not found or you are not the owner');
      }
      await supabase
          .from('adoptions')
          .delete()
          .eq('pet_id', petId)
          .eq('owner_id', ownerId)
          .eq('status', 'active');

      await supabase
          .from('adoptions')
          .delete()
          .eq('pet_id', petId)
          .neq('owner_id', ownerId)
          .eq('status', 'active');

      return Result.success(null);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<List<PetModel>, Object>> getOfferedPetsForAdoption() async {
    try {
      final authUser = supabase.auth.currentUser;
      if (authUser == null) {
        return Result.error('User not logged in');
      }
      final userResponse = await supabase
          .from('users')
          .select('id')
          .eq('auth_id', authUser.id)
          .maybeSingle();

      if (userResponse == null) {
        return Result.error('User profile not found');
      }

      final ownerId = userResponse['id'] as String;

      final adoptionsResponse = await supabase
          .from('adoptions')
          .select('pet_id, owner_id')
          .eq('owner_id', ownerId)
          .eq('status', 'active');

      if (adoptionsResponse.isEmpty) {
        return Result.success([]);
      }

      final Set<String> petIds = (adoptionsResponse as List)
          .map((item) => item['pet_id'] as String)
          .toSet();

      if (petIds.isEmpty) {
        return Result.success([]);
      }
      final allPetsResponse = await supabase
          .from('pets')
          .select()
          .eq('owner_id', ownerId);

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

      // Get the adoption request to find pet_id and requester_id (owner_id in adoptions table is the requester)
      final adoption = await supabase
          .from('adoptions')
          .select('pet_id, owner_id')
          .eq('id', requestId)
          .maybeSingle();

      if (adoption == null) {
        return Result.error('Adoption request not found');
      }

      final petId = adoption['pet_id'] as String;
      final requesterId =
          adoption['owner_id']
              as String; // This is the person who wants to adopt

      // Verify the current user is the pet owner
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

      // Ensure created_at is present
      final responseWithCreatedAt = Map<String, dynamic>.from(response);
      if (!responseWithCreatedAt.containsKey('created_at') ||
          responseWithCreatedAt['created_at'] == null) {
        responseWithCreatedAt['created_at'] = DateTime.now().toIso8601String();
      }

      final updatedAdoption = AdoptionModelMapper.fromMap(
        responseWithCreatedAt,
      );

      if (isAccepted) {
        // Transfer pet ownership to the requester
        await supabase
            .from('pets')
            .update({'owner_id': requesterId})
            .eq('id', petId);

        // Delete all adoption requests for this pet (since it's now adopted)
        await supabase.from('adoptions').delete().eq('pet_id', petId);
      } else {
        // If rejected, just delete other active requests for this pet from the same requester
        // and keep the rejected request
        await supabase
            .from('adoptions')
            .delete()
            .eq('pet_id', petId)
            .eq('owner_id', ownerId)
            .eq('status', 'active');

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
  /// Get all pets available for adoption, excluding the current user's own pets.
  /// This ensures users only see pets from other users in the adoption tab.
  /// When a user adds/removes their pet for adoption, it won't appear/disappear
  /// in their own adoption tab view, but will be visible to other users.
  Future<Result<List<PetModel>, Object>> getAvailablePetsForAdoption() async {
    try {
      // Get current user's ID to filter out their own pets
      final authUser = supabase.auth.currentUser;
      if (authUser == null) {
        return Result.error('User not logged in');
      }

      final userResponse = await supabase
          .from('users')
          .select('id')
          .eq('auth_id', authUser.id)
          .maybeSingle();

      if (userResponse == null) {
        return Result.error('User profile not found');
      }

      final currentUserId = userResponse['id'] as String;

      // Get all active adoptions
      final adoptionsResponse = await supabase
          .from('adoptions')
          .select('pet_id, owner_id')
          .eq('status', 'active');

      if (adoptionsResponse.isEmpty) {
        return Result.success([]);
      }

      // Group adoptions by pet_id and filter to get only pets where
      // the adoption owner_id matches the pet owner_id (owner listed their pet)
      final Map<String, String> petOwnerMap = {};
      final Set<String> availablePetIds = {};

      for (var adoption in adoptionsResponse as List) {
        final petId = adoption['pet_id'] as String;
        final adoptionOwnerId = adoption['owner_id'] as String;
        petOwnerMap[petId] = adoptionOwnerId;
        availablePetIds.add(petId);
      }

      if (availablePetIds.isEmpty) {
        return Result.success([]);
      }

      // Now fetch the pets
      final petsResponse = await supabase
          .from('pets')
          .select()
          .inFilter('id', availablePetIds.toList());

      final List<PetModel> pets = [];
      final Set<String> seenPetIds = {};

      for (var petData in petsResponse as List) {
        final petId = petData['id'] as String;
        final petOwnerId = petData['owner_id'] as String;
        final adoptionOwnerId = petOwnerMap[petId];

        // Only include pets where:
        // 1. The adoption owner matches the pet owner (owner listed their own pet)
        // 2. The pet owner is NOT the current user (exclude user's own pets)
        //    This ensures users never see their own pets in the adoption tab
        if (adoptionOwnerId == petOwnerId &&
            petOwnerId != currentUserId &&
            !seenPetIds.contains(petId)) {
          seenPetIds.add(petId);
          final dataWithPhoto = Map<String, dynamic>.from(petData);
          if (dataWithPhoto['photo'] == null || dataWithPhoto['photo'] == '') {
            dataWithPhoto['photo'] = '';
          }
          pets.add(PetModelMapper.fromMap(dataWithPhoto));
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
    required String title,
    required String description,
  }) async {
    try {
      // Get current user's ID from auth (prevents anonymous users)
      final authUser = supabase.auth.currentUser;
      if (authUser == null) {
        return Result.error(
          'User not logged in. Please login to send adoption request.',
        );
      }

      final userResponse = await supabase
          .from('users')
          .select('id')
          .eq('auth_id', authUser.id)
          .maybeSingle();

      if (userResponse == null) {
        return Result.error('User profile not found');
      }

      final userId = userResponse['id'] as String;

      final pet = await supabase
          .from('pets')
          .select('owner_id')
          .eq('id', petId)
          .maybeSingle();

      if (pet == null) {
        return Result.error('Pet not found');
      }

      final petOwnerId = pet['owner_id'] as String;

      if (userId == petOwnerId) {
        return Result.error(
          'You cannot send an adoption request for your own pet',
        );
      }

      final availableCheck = await supabase
          .from('adoptions')
          .select('id')
          .eq('pet_id', petId)
          .eq('owner_id', petOwnerId)
          .eq('status', 'active')
          .maybeSingle();

      if (availableCheck == null) {
        return Result.error('This pet is not available for adoption');
      }

      final existingRequest = await supabase
          .from('adoptions')
          .select('id')
          .eq('pet_id', petId)
          .eq('owner_id', userId)
          .eq('status', 'active')
          .maybeSingle();

      if (existingRequest != null) {
        return Result.error(
          'You have already sent an adoption request for this pet',
        );
      }

      final response = await supabase
          .from('adoptions')
          .insert({
            'pet_id': petId,
            'owner_id': userId,
            'title': title,
            'description': description,
            'status': 'active',
            'created_at': DateTime.now().toIso8601String(),
          })
          .select()
          .single();

      // Ensure created_at is present, provide default if missing
      final responseWithCreatedAt = Map<String, dynamic>.from(response);
      if (!responseWithCreatedAt.containsKey('created_at') ||
          responseWithCreatedAt['created_at'] == null) {
        responseWithCreatedAt['created_at'] = DateTime.now().toIso8601String();
      }

      final adoption = AdoptionModelMapper.fromMap(responseWithCreatedAt);
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
  Future<Result<String, Object>> getUserName({required String userId}) async {
    try {
      final response = await supabase
          .from('users')
          .select('name')
          .eq('id', userId)
          .maybeSingle();

      if (response == null) {
        return Result.error('User not found');
      }

      final name = response['name'] as String? ?? 'Unknown User';
      return Result.success(name);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }
}
