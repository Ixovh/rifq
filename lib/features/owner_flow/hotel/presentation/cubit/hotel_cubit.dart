import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/shared/shared_in_owner_flow/shared/entities/provider_entity.dart';
import '../../../../../core/shared/shared_in_owner_flow/shared/entities/provider_items_view_entity.dart';
import '../../domain/usecase/hotel_usecase.dart';

part 'hotel_state.dart';

class HotelCubit extends Cubit<HotelState> {
  final HotelUsecase usecase;
  String? selectedRoomId; // للغرف يختار
  List<ProviderEntity>? cachedHotels;

  ProviderItemsViewEntity? selectedRoomDetails;
  HotelCubit(this.usecase) : super(HotelInitial());



  void fetchAllHotels() async {
    // لو البيانات موجودة، نرسلها للعرض
    if (cachedHotels != null) {
      emit(HotelLoaded(cachedHotels!));
    }
    // بعدين نجيب آخر بيانات من الداتابيس
    final result = await usecase.getAllHotel();
    result.when((hotels) {
      cachedHotels = hotels; // تحديث الكاش
      emit(HotelLoaded(hotels));
    }, (error) => emit(HotelError(error)));
  }

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

  void selectRoom(String roomId, ProviderItemsViewEntity roomDetails) {
    selectedRoomId = roomId;
    selectedRoomDetails = roomDetails;

    if (state is HotelDetailLoaded) {
      emit(HotelDetailLoaded((state as HotelDetailLoaded).hotelItems));
    }
  }

  void clearSelectedRoom() {
    selectedRoomId = null;
    emit(state);
  }

  //
 //
 //
  //!!-------------SEARCH Hotels ----------------
  Future<void> searchHotels(String query) async {
    emit(HotelLoading());

    final result = await usecase.searchHotels(query);

    result.when(
          (hotels) => emit(HotelLoaded(hotels)),
          (error) => emit(HotelError(error)),
    );
  }



}


