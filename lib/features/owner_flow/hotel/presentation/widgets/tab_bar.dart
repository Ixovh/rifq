import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelColor: Colors.teal,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.teal,
      tabs: const [
        Tab(text: "Rooms"),
        Tab(text: "Hotel Info"),
      ],
    );
  }
}
