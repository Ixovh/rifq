// هذا الانتيتي معلومات الفندق نفسه \ اسمه , صورته , موقع , وصف...الخ
//Todo:  المساحه هنا لازم اضيف متغير لها

import 'package:rifq/features/owner_flow/hotel/domain/entity/service_item_entity.dart';

class ProviderEntity {
  final String id;
  final String name;
  final String location;
  final String image;
  final String description;
  final List<ServiceItemEntity> services;

  ProviderEntity({required this.id, required this.name, required this.location, required this.image, required this.description, required this.services});
}