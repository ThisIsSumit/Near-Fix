import 'package:flutter/material.dart';
import 'package:near_fix/models/booking_model.dart';
import 'package:near_fix/models/user_model.dart';
import 'package:near_fix/provider/dummydata.dart';
import 'package:near_fix/screens/customer/pages/explore_service_page.dart';
import 'package:near_fix/screens/customer/pages/customer_home_page.dart';
import 'package:near_fix/screens/customer/pages/bookings_page.dart';
import 'package:near_fix/screens/shared/profile_screen.dart';
import 'package:near_fix/services/auth__service.dart';
import 'package:near_fix/services/firestore_service.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _selectedIndex = 0;
  UserModel? user = Dummydata.customer1;
  List<BookingModel> bookings = [];
  Future<void> fetchUser() async {
    try {
      String userId = AuthService().getUserId()!;
      user = await FirestoreService().getUser(userId);
    } catch (e) {
      print("Error in fetching the user $e");
    }
  }

  @override
  void initState() {
    fetchUser().then((_) {
      setState(() {
        _pages = [
          HomePage(),
          ExploreServicesPage(),
          BookingsPage(bookings: bookings),
          ProfileScreen(user: user),
        ];
      });
    });
    super.initState();
  }

  late List<Widget> _pages;
  // fetch user

  // bookings
  Future<void> fetchBookings() async {
    try {
      String userId = user!.id;
      bookings = await FirestoreService().getBookings(customerId: userId);
      if (bookings == null || bookings.isEmpty) {
        bookings = [];
      }
      setState(() {});
    } catch (e) {
      print("Error in fetching bookings $e");
    }
  }

  // fetch geopoint

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
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_today),
            label: "Bookings",
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
