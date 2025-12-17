import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entity/reservation_entity.dart';

class Appointment {
  final String service;
  final DateTime date;
  final String status;

  Appointment({required this.service, required this.date, required this.status});
}


class AppointmentTab extends StatelessWidget {
  final List<ReservationEntity> appointments;

  const AppointmentTab({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    if (appointments.isEmpty) {
      return Column(
        crossAxisAlignment: .center,
        children: [
          Image.asset("assets/images/Frame .png"),
          Text("No Appointments Found",style: TextStyle(fontSize: 16.sp,color: Color(0xFF939090)),),

        ],
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appt = appointments[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: ListTile(
            title: Text(appt.notes ?? 'No notes', style: const TextStyle(fontWeight: FontWeight.bold)),            subtitle: Text("Status: ${appt.status}"),
            trailing: Text(
              "${appt.startDate.year}/${appt.endDate.month}/${appt.startDate.day}",
              style: const TextStyle(fontSize: 12),
            ),
          ),
        );
      },
    );
  }
}