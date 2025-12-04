import 'package:flutter/material.dart';
import 'package:rifq/core/common/widgets/appbar/custom_app_bar.dart';

class HealthScreen extends StatelessWidget {
  const HealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      //================ APP BAR ==================
       appBar: CustomAppBar(title: "Pet Health"),
      // AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   title: Text(
      //     "Pet Health",
      //     style: TextStyle(
      //       color: Colors.teal,
      //       fontWeight: FontWeight.w600,
      //       fontSize: 20,
      //     ),
      //   ),
      //   centerTitle: true,
      //   leading: Icon(Icons.settings, color: Colors.teal),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 12),
      //       child: Icon(Icons.notifications_none, color: Colors.teal),
      //     ),
      //   ],
      // ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            // Padding(
            //   padding: const EdgeInsets.all(16),
            //   child: Container(
            //     padding: const EdgeInsets.all(16),
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //       color: Colors.teal.shade50,
            //       borderRadius: BorderRadius.circular(20),
            //     ),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           "Enjoy the Full Experience!",
            //           style: TextStyle(
            //             fontSize: 18,
            //             fontWeight: FontWeight.w600,
            //             color: Colors.black87,
            //           ),
            //         ),
            //         SizedBox(height: 6),
            //         Text(
            //           "Sign in to add your pets and access all features.",
            //           style: TextStyle(color: Colors.black54),
            //         ),
            //         SizedBox(height: 12),
            //         Text(
            //           "Get Started Now",
            //           style: TextStyle(
            //             color: Colors.teal,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),

            

            //======== Search Bar ========
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey.shade100,
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.black45),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Search for nearby clinics",
                        style: TextStyle(color: Colors.black45),
                      ),
                    ),
                    Icon(Icons.tune, color: Colors.black45),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            //======== Clinics Title ========
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Veterinary Clinics",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 10),

            //======== Clinic Card ========
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _clinicCard(),
                  SizedBox(height: 16),
                  _clinicCard(),
                  SizedBox(height: 16),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //=============== CLINIC CARD UI ===============
  Widget _clinicCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              "assets/images/photo1.png",
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Animal Pulse hospital",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),

                SizedBox(height: 4),
                Text(
                  "Pet care + supplies",
                  style: TextStyle(color: Colors.black54),
                ),

                SizedBox(height: 10),

                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    SizedBox(width: 4),
                    Text("4.4 (544)"),

                    Spacer(),

                    Icon(Icons.location_on, color: Colors.teal, size: 20),
                    SizedBox(width: 4),
                    Text("5.9 km"),
                  ],
                ),

                SizedBox(height: 10),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.teal.shade50,
                  ),
                  child: Text(
                    "Featured",
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
