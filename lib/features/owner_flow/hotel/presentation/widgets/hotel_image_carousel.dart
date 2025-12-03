import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HotelImagesCarousel extends StatelessWidget {
  final List<String> images;
  final ValueNotifier<int> currentIndex = ValueNotifier(0);

  HotelImagesCarousel({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 250,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            onPageChanged: (index, _) {
              currentIndex.value = index;
            },
          ),
          items: images.map((img) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                img,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 12),

        ValueListenableBuilder(
          valueListenable: currentIndex,
          builder: (_, value, __) {
            return AnimatedSmoothIndicator(
              activeIndex: value,
              count: images.length,
              effect: ExpandingDotsEffect(
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: Colors.blueGrey,
              ),
            );
          },
        ),
      ],
    );
  }
}
