import 'package:dart_mappable/dart_mappable.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/reservation_opt_entity.dart';


part 'reservation_model.mapper.dart';

@MappableClass()
class ReservationModel extends ReservationOptEntity
    with ReservationModelMappable {

   ReservationModel({
    @MappableField(key: 'id')         required super.id,
    @MappableField(key: 'user_id')    required super.userId,
    @MappableField(key: 'provider_id') required super.providerId,
    @MappableField(key: 'service_item_id') required super.serviceItemId,
    @MappableField(key: 'pet_id')     required super.petId,

    @MappableField(key: 'start_date') required super.startDate,
    @MappableField(key: 'end_date')   super.endDate,

    @MappableField(key: 'status')     super.status,
    @MappableField(key: 'notes')      super.notes,

    @MappableField(key: 'created_at') required super.createdAt,

    @MappableField(key: 'time')       super.time,
  });

}
