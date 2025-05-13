import 'package:flutter/material.dart';
import 'package:near_fix/models/booking_model.dart';
import 'package:near_fix/models/service_model.dart';
import 'package:near_fix/screens/customer/booking_screen.dart';

class ServiceDetailScreen extends StatelessWidget {
  final ServiceModel service;
  const ServiceDetailScreen({required this.service, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _navigateToBookingScreen(ServiceModel service) async {
      final BookingModel? newBooking = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingScreen(service: service),
        ),
      );

      if (newBooking != null) {
        // Do something with the newBooking
        print('Booking received: ${newBooking.id}');
      } else {
        print('Booking was cancelled or not completed.');
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(service.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              width: double.infinity,
              color: Colors.blue.shade600,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.cleaning_services,
                    size: 50,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    service.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),

                  const SizedBox(height: 10),
                  Text(
                    "${service.priceType == 'hourly' ? '\$${service.price}/hr' : '\$${service.price}'}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Info Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "About",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    service.description,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    "Category",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(service.category),

                  const SizedBox(height: 24),
                  const Text(
                    "Address",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(service.address),

                  const SizedBox(height: 32),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _navigateToBookingScreen(service);
                      },
                      icon: const Icon(Icons.calendar_month),
                      label: const Text("Book Now"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: Color(0xFF4A80F0),
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}
