import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProviderDashboard extends StatelessWidget {
  ProviderDashboard({required this.providerData, super.key});

  Map<String, dynamic>? providerData;

  Widget buildStatCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Dashboard",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // 🔧 Booking Stats + Rating
            Row(
              children: [
                buildStatCard(
                  "Pending",
                  providerData?['pendingBookingsCount'].toString() ?? '0',
                  Colors.orange,
                ),
                const SizedBox(width: 16),
                buildStatCard(
                  "Confirmed",
                  providerData?['confirmedBookingsCount'].toString() ?? '0',
                  Colors.blue,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                buildStatCard(
                  "Completed",
                  providerData?['completedBookingsCount'].toString() ?? '0',
                  Colors.green,
                ),
                const SizedBox(width: 16),
                buildStatCard(
                  "Services",
                  providerData?['servicesCount'].toString() ?? '0',
                  Colors.purple,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // 🔧 Rating and Earnings
            Row(
              children: [
                buildStatCard(
                  "Ratinng",
                  '⭐${providerData?['rating'] ?? 0.0}',
                  Colors.amber,
                ),
                const SizedBox(width: 16),
                buildStatCard(
                  "Earnings",
                  '₹${(providerData?['totalEarnings'] ?? 0.0).toStringAsFixed(2)}',
                  Colors.teal,
                ),
              ],
            ),

            const SizedBox(height: 24),
            Text(
              textAlign: TextAlign.center,
              "Latest Reviews",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            if ((providerData?['latestReviews'] as List?)?.isNotEmpty ?? false)
              ...List.generate(
                (providerData!['latestReviews'] as List).length,
                (index) {
                  final review = providerData!['latestReviews'][index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading: const Icon(Icons.reviews),
                      title: Text(review['comment'] ?? 'No comment'),
                      subtitle: Text('By: ${review['userName'] ?? 'User'}'),
                    ),
                  );
                },
              )
            else
              const Text("No reviews available."),

            const SizedBox(height: 24),

            // Dummy Booking Box
          ],
        ),
      ),
    );
  }
}
