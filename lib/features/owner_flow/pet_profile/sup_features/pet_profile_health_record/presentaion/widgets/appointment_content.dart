import 'package:flutter/material.dart';

class Appointment {
  final String service;
  final DateTime date;
  final String status;

  Appointment({required this.service, required this.date, required this.status});
}

// في ملف AppointmentTab.dart

// ... (باقي الـ imports و Appointment Model)

class AppointmentTab extends StatelessWidget {
  final List<Appointment> appointments;

  const AppointmentTab({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    if (appointments.isEmpty) {
      return const Center(child: Text("No appointments found"));
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
            title: Text(appt.service, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("Status: ${appt.status}"),
            trailing: Text(
              "${appt.date.year}/${appt.date.month}/${appt.date.day}",
              style: const TextStyle(fontSize: 12),
            ),
          ),
        );
      },
    );
  }
}