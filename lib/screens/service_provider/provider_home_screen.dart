import 'package:flutter/material.dart';
import 'package:near_fix/models/booking_model.dart';
import 'package:near_fix/models/user_model.dart';
import 'package:near_fix/provider/dummydata.dart';
import 'package:near_fix/screens/service_provider/pages/booking_request.dart';
import 'package:near_fix/screens/service_provider/pages/provider_dashboard.dart';
import 'package:near_fix/screens/shared/profile_screen.dart';
import 'package:near_fix/services/auth__service.dart';
import 'package:near_fix/services/firestore_service.dart';

class ProviderHomeScreen extends StatefulWidget {
  const ProviderHomeScreen({Key? key}) : super(key: key);

  @override
  State<ProviderHomeScreen> createState() => _ProviderHomeScreenState();
}

class _ProviderHomeScreenState extends State<ProviderHomeScreen> {
  int _selectedIndex = 0;
  UserModel? provider = Dummydata.provider1;
  List<BookingModel> pendingRequests = [];

  List<BookingModel> confirmedRequests = [];
  Map<String, dynamic>? providerDashboardData;
  bool isLoading = false;
  //get user
  Future<void> fetchUser() async {
    try {
      String userId = AuthService().getUserId()!;
      provider = await FirestoreService().getUser(userId);
      if (provider == null) {
        throw Exception("Provider not found");
      }
    } catch (e) {
      print("Error in fetching the user $e");
    }
  }

  //fetch bookings
  Future<void> fetchRequests() async {
    setState(() => isLoading = true);
    String providerId = AuthService().getUserId()!;
    pendingRequests = await FirestoreService().getBookings(
      providerId: providerId,
      status: "Pending",
    );
    confirmedRequests = await FirestoreService().getBookings(
      providerId: providerId,
      status: "Confirmed",
    );
    setState(() => isLoading = false);
  }

  // fetch provider dash board data
  Future<void> getproviderDashBoardData() async {
    try {
      setState(() => isLoading = true);
      String providerId = await AuthService().getUserId()!;
      providerDashboardData = await FirestoreService().getProviderDashboardData(
        providerId,
      );
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    fetchUser().then((_) {
      setState(() {
        _pages = [
          ProviderDashboard(providerData: providerDashboardData),
          BookingRequestsScreen(
            confirmedRequests: confirmedRequests,
            pendingRequests: pendingRequests,
          ),
          ProfileScreen(user: provider),
        ];
      });
    });
    fetchRequests();
    super.initState();
  }

  late List<Widget> _pages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF4A80F0),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            activeIcon: Icon(Icons.list_alt),
            label: "Requests",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
