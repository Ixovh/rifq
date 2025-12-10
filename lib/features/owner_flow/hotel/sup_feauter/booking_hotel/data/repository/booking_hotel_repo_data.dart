import 'package:injectable/injectable.dart';
import 'package:multiple_result/src/result.dart';
import 'package:rifq/features/owner_flow/hotel/sup_feauter/booking_hotel/data/model/booking_hotel_model.dart';

import 'package:rifq/features/owner_flow/hotel/sup_feauter/booking_hotel/domain/entity/booking_hotel_entity.dart';


import '../../../../../pet_profile/sup_features/pet_info_card/domain/entity/pet_entity.dart';
import '../../domain/repository/booking_hotel_repo_domain.dart';
import '../datasource/booking_hotel_datasource.dart';
@LazySingleton(as: BookingHotelRepoDomain)
class BookingHotelRepoData implements BookingHotelRepoDomain {
  final BaseBookingHotelDataSource hoteldata;
  BookingHotelRepoData(this.hoteldata);

  @override
  Future<Result<BookingHotelEntity, String>> createBooking(BookingHotelEntity booking) async {
    // Entity -> Model
    final model = BookingHotelModel(
      id: booking.id,
      userId: booking.userId,
      providerId: booking.providerId,
      serviceTypeId: booking.serviceTypeId,
      serviceItemId: booking.serviceItemId,
      petId: booking.petId,
      startDate: booking.startDate,
      endDate: booking.endDate,
      status: booking.status,
      notes: booking.notes,
      createdAt: booking.createdAt,
    );

    final result = await hoteldata.createBooking(model);
    return result.when((success) => Result.success(success), // BookingHotelModel extends BookingHotelEntity
          (error) => Result.error(error),
    );
  }


  @override
  Future<Result<BookingHotelEntity, String>> getBookingById(String id) async {
    final result = await hoteldata.getBookingById(id);
    return result.when(
          (success) => Result.success(success), // BookingHotelModel extends BookingHotelEntity بالفعل
          (error) => Result.error(error),
    );
  }


  @override
  Future<Result<List<PetProfileEntity>, String>> getPetForUser(String userId) async {
    final result = await hoteldata.getPetForUser(userId);

    return result.when(
          (success) {
        // هنا نحول كل PetProfileModel → PetEntity
        final List<PetProfileEntity> pets = success
            .map<PetProfileEntity>((petModel) => petModel.toEntity())
            .toList();
        return Result.success(pets);
      },
          (error) => Result.error(error),
    );
  }




}