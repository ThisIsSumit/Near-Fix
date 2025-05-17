import 'package:flutter/material.dart';
import 'package:near_fix/models/user_model.dart';
import 'package:near_fix/provider/dummydata.dart';
import 'package:near_fix/screens/service_provider/add_new_service.dart';

class ProviderDashboard extends StatelessWidget {
  ProviderDashboard({required this.providerData, super.key});

  final Map<String, dynamic>? providerData;
  UserModel provider = Dummydata.provider1;

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
    final String providerName = providerData?['providerName'] ?? 'Provider';

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddServiceScreen(providerId: provider.id),
            ),
          );
        },
        backgroundColor: Colors.indigo,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text('Add New Service', style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome, $providerName 👋",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Here’s a quick summary of your activity:",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 24),
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
                      "Earnings",
                      '₹${(providerData?['totalEarnings'] ?? 0.0).toStringAsFixed(2)}',
                      Colors.teal,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: const [
                      Text(
                        "Keep up the great work! 🎉",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.indigo,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Track your progress regularly and provide excellent service to boost your reputation.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black87),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80),
                Center(
                  child: Text(
                    "Powered by $providerName",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
