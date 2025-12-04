import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/core/utils/Exception/custom_exception.dart';
import 'package:rifq/features/owner_flow/add_pet/data/models/pet_model.dart';
import 'package:rifq/features/owner_flow/adoption/data/models/adoption_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AdoptionDataSource {
  // ========== For Adoption Tab (Other Users) ==========
  Future<Result<List<PetModel>, Object>> getPetsForAdoption();
  Future<Result<PetModel, Object>> getPetDetails(String petId);
  Future<Result<AdoptionModel, Object>> sendAdoptionRequest({
    required String petId,
    required String ownerId,
    required String title,
    required String description,
  });

  // ========== My Pets Tab (Pet Owner) ==========
  Future<Result<List<PetModel>, Object>> getMyPets(String ownerId);
  Future<Result<Null, Object>> addPetForAdoption(String petId);
  Future<Result<Null, Object>> removePetFromAdoption(String petId);
  Future<Result<List<AdoptionModel>, Object>> getAdoptionRequests(
    String ownerId,
  );
  Future<Result<List<AdoptionModel>, Object>> getAdoptionRequestsByPet(
    String petId,
  );
  Future<Result<Null, Object>> acceptAdoptionRequest(String requestId);
  Future<Result<Null, Object>> rejectAdoptionRequest(String requestId);
  Future<Result<Null, Object>> cancelAdoption(String petId);
  Future<Result<List<PetModel>, Object>> getAdoptedPets(String ownerId);
  Future<Result<List<AdoptionModel>, Object>> getCancelledAdoptions(
    String ownerId,
  );

  /// Get owner names for multiple owner IDs
  Future<Result<Map<String, String?>, Object>> getOwnerNamesForPets(
    List<String> ownerIds,
  );

  /// Get adoption request counts for multiple pet IDs
  Future<Result<Map<String, int>, Object>> getAdoptionRequestCountsForPets(
    List<String> petIds,
  );
}

@LazySingleton(as: AdoptionDataSource)
class AdoptionDataBaseSoruce implements AdoptionDataSource {
  final SupabaseClient supabase;

  AdoptionDataBaseSoruce(this.supabase);

  @override
  Future<Result<List<PetModel>, Object>> getPetsForAdoption() async {
    try {
      // Get pets that have adoption records with status 'pending'
      // Query adoptions and join with pets
      final response = await supabase
          .from('adoptions')
          .select('''
            pets!inner(*)
          ''')
          .eq('status', 'pending');

      // Extract unique pets from the response
      final List<PetModel> pets = [];
      final Set<String> seenPetIds = {};

      for (var item in response as List) {
        final petData = item['pets'];
        if (petData != null && petData['id'] != null) {
          final petId = petData['id'] as String;
          if (!seenPetIds.contains(petId)) {
            seenPetIds.add(petId);
            // Provide default photo if missing
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
  Future<Result<PetModel, Object>> getPetDetails(String petId) async {
    try {
      final response = await supabase
          .from('pets')
          .select()
          .eq('id', petId)
          .maybeSingle();

      if (response == null) {
        return Result.error('Pet not found');
      }

      // Provide default photo if missing
      final dataWithPhoto = Map<String, dynamic>.from(response);
      if (dataWithPhoto['photo'] == null || dataWithPhoto['photo'] == '') {
        dataWithPhoto['photo'] = ''; // Empty string as default
      }

      final pet = PetModelMapper.fromMap(dataWithPhoto);
      return Result.success(pet);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<AdoptionModel, Object>> sendAdoptionRequest({
    required String petId,
    required String ownerId,
    required String title,
    required String description,
  }) async {
    try {
      final response = await supabase
          .from('adoptions')
          .insert({
            'pet_id': petId,
            'owner_id': ownerId,
            'title': title,
            'description': description,
            'status': 'pending',
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
  Future<Result<List<PetModel>, Object>> getMyPets(String ownerId) async {
    try {
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
  Future<Result<Null, Object>> addPetForAdoption(String petId) async {
    try {
      // Check if adoption record already exists
      final existing = await supabase
          .from('adoptions')
          .select('id')
          .eq('pet_id', petId)
          .eq('status', 'pending')
          .maybeSingle();

      if (existing != null) {
        return Result.error('Pet is already available for adoption');
      }

      // Get the pet owner_id
      final pet = await supabase
          .from('pets')
          .select('owner_id')
          .eq('id', petId)
          .maybeSingle();

      if (pet == null) {
        return Result.error('Pet not found');
      }

      // Create adoption record with pet owner as the requester (for listing)
      // Note: This might need adjustment based on your business logic
      await supabase.from('adoptions').insert({
        'pet_id': petId,
        'owner_id': pet['owner_id'], // Pet owner
        'title': 'Available for Adoption',
        'description': 'This pet is available for adoption',
        'status': 'pending',
      });

      return Result.success(null);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<Null, Object>> removePetFromAdoption(String petId) async {
    try {
      // Update all adoption records for this pet to 'cancelled'
      await supabase
          .from('adoptions')
          .update({'status': 'cancelled'})
          .eq('pet_id', petId)
          .eq('status', 'pending');

      return Result.success(null);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<List<AdoptionModel>, Object>> getAdoptionRequests(
    String ownerId,
  ) async {
    try {
      // Get adoption requests for pets owned by this owner
      // Join adoptions with pets to filter by pet owner
      final response = await supabase
          .from('adoptions')
          .select('''
            *,
            pets!inner(owner_id)
          ''')
          .eq('pets.owner_id', ownerId)
          .eq('status', 'pending')
          .order('created_at', ascending: false);

      final List<AdoptionModel> adoptions = (response as List)
          .map((item) => AdoptionModelMapper.fromMap(item))
          .toList();

      return Result.success(adoptions);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<List<AdoptionModel>, Object>> getAdoptionRequestsByPet(
    String petId,
  ) async {
    try {
      final response = await supabase
          .from('adoptions')
          .select()
          .eq('pet_id', petId)
          .eq('status', 'pending')
          .order('created_at', ascending: false);

      final List<AdoptionModel> adoptions = (response as List)
          .map((item) => AdoptionModelMapper.fromMap(item))
          .toList();

      return Result.success(adoptions);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<Null, Object>> acceptAdoptionRequest(String requestId) async {
    try {
      await supabase
          .from('adoptions')
          .update({'status': 'accepted'})
          .eq('id', requestId);

      // Optionally, cancel other pending requests for the same pet
      final adoption = await supabase
          .from('adoptions')
          .select('pet_id')
          .eq('id', requestId)
          .maybeSingle();

      if (adoption != null) {
        await supabase
            .from('adoptions')
            .update({'status': 'cancelled'})
            .eq('pet_id', adoption['pet_id'])
            .eq('status', 'pending')
            .neq('id', requestId);
      }

      return Result.success(null);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<Null, Object>> rejectAdoptionRequest(String requestId) async {
    try {
      await supabase
          .from('adoptions')
          .update({'status': 'rejected'})
          .eq('id', requestId);

      return Result.success(null);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<Null, Object>> cancelAdoption(String petId) async {
    try {
      // Cancel pending adoptions
      await supabase
          .from('adoptions')
          .update({'status': 'cancelled'})
          .eq('pet_id', petId)
          .eq('status', 'pending');

      // Cancel accepted adoptions
      await supabase
          .from('adoptions')
          .update({'status': 'cancelled'})
          .eq('pet_id', petId)
          .eq('status', 'accepted');

      return Result.success(null);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<List<PetModel>, Object>> getAdoptedPets(String ownerId) async {
    try {
      // Get adopted pets for the owner
      final response = await supabase
          .from('pets')
          .select()
          .eq('owner_id', ownerId)
          .eq('status', 'adopted');
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
  Future<Result<List<AdoptionModel>, Object>> getCancelledAdoptions(
    String ownerId,
  ) async {
    try {
      // Get cancelled adoption requests for pets owned by this owner
      final response = await supabase
          .from('adoptions')
          .select('''
            *,
            pets!inner(owner_id)
          ''')
          .eq('pets.owner_id', ownerId)
          .eq('status', 'cancelled')
          .order('created_at', ascending: false);

      final List<AdoptionModel> adoptions = (response as List)
          .map((item) => AdoptionModelMapper.fromMap(item))
          .toList();

      return Result.success(adoptions);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<Map<String, String?>, Object>> getOwnerNamesForPets(
    List<String> ownerIds,
  ) async {
    try {
      if (ownerIds.isEmpty) {
        return Result.success({});
      }

      // Query each owner ID in parallel
      final futures = ownerIds.map((ownerId) async {
        try {
          final response = await supabase
              .from('users')
              .select('id, name')
              .eq('id', ownerId)
              .maybeSingle();
          return response != null
              ? MapEntry(ownerId, response['name'] as String?)
              : MapEntry<String, String?>(ownerId, null);
        } catch (e) {
          return MapEntry<String, String?>(ownerId, null);
        }
      });

      final results = await Future.wait(futures);
      final Map<String, String?> ownerNames = Map.fromEntries(results);

      return Result.success(ownerNames);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<Map<String, int>, Object>> getAdoptionRequestCountsForPets(
    List<String> petIds,
  ) async {
    try {
      if (petIds.isEmpty) {
        return Result.success({});
      }

      // Query each pet ID in parallel to get request counts
      final futures = petIds.map((petId) async {
        try {
          final response = await supabase
              .from('adoptions')
              .select('pet_id')
              .eq('pet_id', petId)
              .eq('status', 'pending');
          return MapEntry(petId, (response as List).length);
        } catch (e) {
          return MapEntry(petId, 0);
        }
      });

      final results = await Future.wait(futures);
      final Map<String, int> requestCounts = Map.fromEntries(results);

      return Result.success(requestCounts);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }
}
