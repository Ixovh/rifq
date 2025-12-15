
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/routes/base_routes.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/provider_items_view_entity.dart';

class ConfirmationScreen extends StatelessWidget {
  final ProviderItemsViewEntity entity;
  final List<String> petIds;
  final DateTime date;
  final String time;

  const ConfirmationScreen({
    super.key,
    required this.entity,
    required this.petIds,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final dateText = "${date.day.toString().padLeft(2, '0')} "
        "${_monthName(date.month)}";

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 16),

              Text(
                "Your Appointment Is Confirmed",
                textAlign: TextAlign.center,
                style: context.h5.copyWith(color: context.primary50),
              ),

               SizedBox(height: 20),
              //TODO: IMAGE
              // Image.asset('assets/images/confirmed.png', height: 220),
              Icon(Icons.event_available, size: 140, color: context.primary50),

               SizedBox(height: 14),

              Text(
                "Your booking has been successfully scheduled.\nWe’ll send you a reminder before your visit.",
                textAlign: TextAlign.center,
                style: context.body3.copyWith(color: Colors.grey[600]),
              ),

               SizedBox(height: 26),

              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.grey[700]),
                     SizedBox(width: 10),
                    Text("Appointment Details", style: context.body1),
                  ],
                ),
              ),

               SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 78,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          Text(_weekdayName(date.weekday),
                              style: context.body3.copyWith(color: Colors.grey)),
                           SizedBox(height: 6),
                          Text(dateText, style: context.body1),
                           SizedBox(height: 6),
                          Text(time,
                              style: context.body2.copyWith(
                                color: context.primary50,
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),
                    ),

                     SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Clinic", style: context.body3.copyWith(color: Colors.grey)),
                          Text(entity.providerName, style: context.body1),
                           SizedBox(height: 10),
                          Text("Service", style: context.body3.copyWith(color: Colors.grey)),
                          Text(entity.itemName, style: context.body2),
                        ],
                      ),
                    ),

                     SizedBox(width: 10),

                    Column(
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {
                            //TODO: LOCATION URL
                          },
                          icon:  Icon(Icons.location_on_outlined, size: 18),
                          label:  Text("Get Directions"),
                        ),
                         SizedBox(height: 10),
                        OutlinedButton.icon(
                          onPressed: () {
                            //TODO: CALENDER
                          },
                          icon:  Icon(Icons.calendar_month, size: 18),
                          label:  Text("Add to calendar"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    //TODO: APPOINTMENT PROFILE TAB
                    // context.go(Routes.myAppointments);
                    // context.go(Routes.home);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.primary50,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "View Appointments",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),

               SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => context.go(Routes.navbar),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: context.primary50),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Back to Health Page",
                    style: TextStyle(fontSize: 18, color: context.primary50),
                  ),
                ),
              ),
               SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  String _monthName(int m) {
    const months = [
      'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'
    ];
    return months[m - 1];
  }

  String _weekdayName(int w) {
    const days = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
    return days[w - 1];
  }
}
