import 'package:flutter/material.dart';

class HealthRecord {
  final String title;
  final String description;
  final DateTime date;

  HealthRecord({required this.title, required this.description, required this.date});
}

class HealthRecordTab extends StatelessWidget {
  final List<HealthRecord> records;

  const HealthRecordTab({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    // 1. التعامل مع حالة عدم وجود سجلات
    if (records.isEmpty) {
      return const Center(child: Text("No health records found"));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: records.length,
      itemBuilder: (context, index) {
        final record = records[index];
        return Card(
          // Card Design
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: ListTile(
            title: Text(
                record.title,
                style: const TextStyle(fontWeight: FontWeight.bold)
            ),
            subtitle: Text(record.description),
            trailing: Text(
              "${record.date.year}/${record.date.month}/${record.date.day}",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            onTap: () {
              // TODO: Navigate to Health Record Detail Screen
            },
          ),
        );
      },
    );
  }
}