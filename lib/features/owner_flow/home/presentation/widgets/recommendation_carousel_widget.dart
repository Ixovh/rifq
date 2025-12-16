import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rifq/features/owner_flow/clinic/clinic_sub_features/booking_details/presentation/widgets/recommendation_card_widget.dart';

class RecommendationCarousel extends StatelessWidget {
  const RecommendationCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final adsImages = [
      'assets/images/ad1.png',
      'assets/images/ad1.png',
      'assets/images/ad1.png',
    ];

    return CarouselSlider(
      items: adsImages.map((image) {
        return RecommendationCard(imagePath: image);
      }).toList(),

      options: CarouselOptions(
        height: 170,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        enlargeCenterPage: true,
        viewportFraction: 0.85,
      ),
    );
  }
}
