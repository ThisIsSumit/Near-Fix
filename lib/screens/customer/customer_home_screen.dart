import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:near_fix/models/booking_model.dart';
import 'package:near_fix/models/service_model.dart';
import 'package:near_fix/models/user_model.dart';
import 'package:near_fix/provider/dummydata.dart';
import 'package:near_fix/screens/customer/pages/explore_service_page.dart';
import 'package:near_fix/screens/customer/pages/customer_home_page.dart';
import 'package:near_fix/screens/customer/pages/bookings_page.dart';
import 'package:near_fix/screens/shared/profile_screen.dart';
import 'package:near_fix/services/auth__service.dart';
import 'package:near_fix/services/firestore_service.dart';
import 'package:geolocator/geolocator.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _selectedIndex = 0;
  UserModel user = Dummydata.customer1;
  List<BookingModel> bookings = [];
  List<ServiceModel>? services;
  LatLng? _latLng;
  Future<void> fetchUser() async {
    try {
      //  String userId = AuthService().getUserId()!;
      // user = await FirestoreService().getCustomer(userId);
    } catch (e) {
      print("Error in fetching the user $e");
    }
  }

  Future<void> fetchServices() async {
    try {
      services = await FirestoreService().getServices();
    } catch (e) {
      print("Error in fetching services");
    }
  }

  @override
  void initState() {
    super.initState();

    Future.wait([getCurrentLatLag(), fetchUser(), fetchBookings()]).then((_) {
      setState(() {
        _pages = [
          HomePage(),
          ExploreServicesPage(userLatLng: _latLng ?? LatLng(0, 0)),
          BookingsPage(bookings: bookings),
          ProfileScreen(user: user),
        ];
      });
    });
  }

  late List<Widget> _pages;
  // bookings
  Future<void> fetchBookings() async {
    try {
      String userId = user.id;
      var fetchedbookings = await FirestoreService().getBookings(
        customerId: userId,
      );

      setState(() {
        bookings = fetchedbookings;
        print(" bookings  ${bookings.length} ");
      });
    } catch (e) {
      print("Error in fetching bookings $e");
    }
  }

  // fetch geopoint
  Future<void> getCurrentLatLag() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Location services are disabled.');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print('Location permissions are permanently denied.');
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _latLng = LatLng(position.latitude, position.longitude);

        print(" coordinates  ${_latLng} ");
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          (_pages == null)
              ? CircularProgressIndicator()
              : _pages[_selectedIndex],
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
