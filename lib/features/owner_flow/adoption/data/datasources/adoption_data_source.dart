import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/core/utils/Exception/custom_exception.dart';
import 'package:rifq/features/owner_flow/add_pet/data/models/pet_model.dart';
import 'package:rifq/features/owner_flow/adoption/data/models/adoption_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AdoptionDataSource {
 
  Future<Result<List<PetModel>, Object>> getMyPets();

  Future<Result<PetModel, Object>> addPetForAdoption({required PetModel pet});

  Future<Result<int, Object>> getAdoptionRequestCountForPet({
    required String petId,
    required String ownerId,
  });

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
    required String userId, 
    required String title,
    required String description,
  });

  Future<Result<PetModel, Object>> getPetDetails({required String petId});

  Future<Result<List<AdoptionModel>, Object>> getUserAdoptionRequests({
    required String userId,
  });

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
  Future<Result<int, Object>> getAdoptionRequestCountForPet({
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
          .select('id')
          .eq('pet_id', petId)
          .neq('owner_id', ownerId) 
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

      final adoption = await supabase
          .from('adoptions')
          .select('pet_id')
          .eq('id', requestId)
          .maybeSingle();

      if (adoption == null) {
        return Result.error('Adoption request not found');
      }

      final petId = adoption['pet_id'] as String;

      final pet = await supabase
          .from('pets')
          .select('owner_id')
          .eq('id', petId)
          .eq('owner_id', ownerId)
          .maybeSingle();

      if (pet == null) {
        return Result.error('You are not the owner of this pet');
      }


      final response = await supabase
          .from('adoptions')
          .update({'status': dbStatus})
          .eq('id', requestId)
          .select()
          .single();

      final updatedAdoption = AdoptionModelMapper.fromMap(response);


      if (isAccepted) {

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
  Future<Result<List<PetModel>, Object>> getAvailablePetsForAdoption() async {
    try {
      final response = await supabase
          .from('adoptions')
          .select('''
            pets!inner(*)
          ''')
          .eq('status', 'active');

      final List<PetModel> pets = [];
      final Set<String> seenPetIds = {};

      for (var item in response as List) {
        final petData = item['pets'];
        if (petData != null && petData['id'] != null) {
          final petId = petData['id'] as String;
          final adoptionOwnerId = item['owner_id'] as String?;
          final petOwnerId = petData['owner_id'] as String?;

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
      final response = await supabase
          .from('adoptions')
          .select()
          .eq('owner_id', userId) 
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


      final adoptionRecord = await supabase
          .from('adoptions')
          .select()
          .eq('id', requestId)
          .single();


      await supabase.from('adoptions').delete().eq('id', requestId);

      final cancelledAdoption = AdoptionModelMapper.fromMap(adoptionRecord);
      return Result.success(cancelledAdoption);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }
}
