import 'package:flutter/material.dart';
import 'package:near_fix/models/booking_model.dart';

// ignore: must_be_immutable
class BookingRequestsScreen extends StatelessWidget {
  BookingRequestsScreen({
    required this.pendingRequests,
    required this.confirmedRequests,
    super.key,
  });

  List<BookingModel>? pendingRequests;

  List<BookingModel>? confirmedRequests;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Booking Requests"),
            bottom: TabBar(
              labelPadding: EdgeInsets.symmetric(horizontal: 10),
              
              indicator: BoxDecoration(color: const Color(0xFF4A80F0)),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[600],
              tabs: const [Tab(text: "Pending"), Tab(text: "Confirmed")],
            ),
          ),
          body: TabBarView(
            children: [
              _buildRequestList(context, confirmedRequests, isConfirmed: false),
              _buildRequestList(context, pendingRequests, isConfirmed: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequestList(
    context,
    List<BookingModel>? requests, {
    required bool isConfirmed,
  }) {
    if (requests == null || requests.isEmpty) {
      return const Center(
        child: Text("No bookings found", style: TextStyle(fontSize: 16)),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: List.generate(requests.length, (index) {
          final request = requests[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildRequestCard(context, request, isConfirmed),
          );
        }),
      ),
    );
  }

  Widget _buildRequestCard(
    BuildContext context,
    BookingModel request,
    bool isConfirmed,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Service and Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                request.serviceName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color:
                      isConfirmed
                          ? Colors.green.withOpacity(0.1)
                          : const Color(0xFF4A80F0).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  request.status,
                  style: TextStyle(
                    color: isConfirmed ? Colors.green : const Color(0xFF4A80F0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Customer and Date
          Row(
            children: [
              const Icon(Icons.person_outline, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                request.customerName,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(width: 16),
              const Icon(
                Icons.access_time_outlined,
                size: 16,
                color: Colors.grey,
              ),
              const SizedBox(width: 4),
              Text(
                "${request.bookingDate.toLocal()}".split(' ')[0],
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),

          const SizedBox(height: 12),

          if (request.notes != null && request.notes!.isNotEmpty)
            Text(request.notes!, style: const TextStyle(fontSize: 14)),

          const SizedBox(height: 16),

          if (!isConfirmed)
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Booking request declined"),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text("Decline"),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Booking request accepted"),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A80F0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text("Accept"),
                  ),
                ),
              ],
            ),
          if (isConfirmed)
            ElevatedButton(
              onPressed: () {
                if (request.status == "Confirmed") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Marked as completed")),
                  );
                } else {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text("View details")));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    request.status == "Confirmed"
                        ? const Color(0xFF4A80F0)
                        : Colors.grey,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                request.status == "Confirmed"
                    ? "Mark as Completed"
                    : "View Details",
                style: const TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
