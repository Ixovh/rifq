
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rifq/features/owner_flow/hotel/domain/entity/provider_service_entity.dart';
import 'package:rifq/features/owner_flow/hotel/domain/usecase/hotel_usecase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

part 'hotel_state.dart';

class HotelCubit extends Cubit<HotelState> {
  final HotelUsecase usecase;
  String? selectedRoomId; // للغرف يختار
  HotelCubit(this.usecase) : super(HotelInitial());


  void fetchAllHotels() async {
    emit(HotelLoading());
    final result = await usecase.getAllHotel();
    result.when(
          (hotels) => emit(HotelLoaded(hotels)),
          (error) => emit(HotelError(error)),
    );
  }

  //
  //

  void fetchHotelById(String id) async {
    if (id.isEmpty) {
      emit(HotelError("Hotel ID cannot be empty"));
      return;
    }
    emit(HotelLoading());
    final result = await usecase.getHotelById(id);
    result.when(
          (hotel) => emit(HotelDetailLoaded(hotel)),
          (error) => emit(HotelError(error)),
    );
  }

  //
  //
  //

  Future<void> openLocation(String? url) async {
    if (url == null || url.isEmpty) {
      emit(HotelError("Location URL not available"));
      return;
    }

    emit(HotelLoading());
    try {
      final uri = Uri.parse(url);
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      emit(HotelLocationOpened());
    } catch (e) {
      emit(HotelError("Failed to open location: $e"));
    }
  }


//
//
//

  void selectRoom(String roomId) {
    selectedRoomId = roomId;
    emit(RoomSelectionChanged(roomId));
  }

}

