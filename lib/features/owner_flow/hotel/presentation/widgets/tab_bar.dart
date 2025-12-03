import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
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
