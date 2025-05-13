import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:near_fix/models/booking_model.dart';
import 'package:near_fix/models/service_model.dart';
import 'package:near_fix/models/user_model.dart';

class Dummydata {
  static List<BookingModel> dummyBookings = [
    BookingModel(
      id: 'booking1',
      customerId: 'cust001',
      providerId: 'prov001',
      serviceId: 'serv001',
      serviceName: 'Home Cleaning',
      customerName: 'John Doe',
      providerName: 'Sparkle Cleaners',
      bookingDate: DateTime(2025, 5, 20),
      status: 'completed',
      notes: 'Very professional',
      amount: 99.99,
      createdAt: DateTime(2025, 5, 15),
    ),
    BookingModel(
      id: 'booking2',
      customerId: 'cust002',
      providerId: 'prov002',
      serviceId: 'serv002',
      serviceName: 'AC Repair',
      customerName: 'Alice Smith',
      providerName: 'CoolAir Services',
      bookingDate: DateTime(2025, 5, 22),
      status: 'pending',
      notes: null,
      amount: 149.50,
      createdAt: DateTime(2025, 5, 18),
    ),
    BookingModel(
      id: 'booking3',
      customerId: 'cust003',
      providerId: 'prov003',
      serviceId: 'serv003',
      serviceName: 'Plumbing',
      customerName: 'Bob Brown',
      providerName: 'FlowFixers',
      bookingDate: DateTime(2025, 5, 25),
      status: 'confirmed',
      notes: 'Needs urgent repair',
      amount: 200.0,
      createdAt: DateTime(2025, 5, 19),
    ),
  ];

  static List<ServiceModel> dummyServices = [
    ServiceModel(
      id: 'service1',
      providerId: 'provider001',
      title: 'Deep Home Cleaning',
      category: 'Cleaning',
      description:
          'Full deep-cleaning of home including floor, windows, kitchen, and bathrooms.',
      price: 90.0,
      priceType: 'hourly',
      location: GeoPoint(28.6139, 77.2090), // Delhi
      address: 'A-123, Rajpath Marg, New Delhi',
     
      createdAt: DateTime(2025, 5, 12),
    ),
    ServiceModel(
      id: 'service2',
      providerId: 'provider002',
      title: 'Bathroom Plumbing Fix',
      category: 'Plumbing',
      description:
          'Fix leakages, pipe replacements, tap installations, and more.',
      price: 120.0,
      priceType: 'fixed',
      location: GeoPoint(19.0760, 72.8777), // Mumbai
      address: 'Flat 501, Ocean Heights, Mumbai',
    
      createdAt: DateTime(2025, 5, 13),
    ),
    ServiceModel(
      id: 'service3',
      providerId: 'provider003',
      title: 'Home Electrical Wiring',
      category: 'Electrical',
      description:
          'Complete wiring and electrical maintenance service for homes.',
      price: 150.0,
      priceType: 'hourly',
      location: GeoPoint(12.9716, 77.5946), // Bangalore
      address: '221B, MG Road, Bangalore',
     
      createdAt: DateTime(2025, 5, 14),
    ),
  ];

  UserModel customer = UserModel(
    id: 'customer_1',
    fullName: 'John Doe',
    email: 'johndoe@example.com',
    phoneNumber: '+1234567890',
    location: '123 Main Street, Cityville',
    userType: 'customer', // Customer type
    profileImageUrl: 'https://example.com/profile_images/johndoe.jpg',
    createdAt: DateTime.now(),
    coordinates: GeoPoint(
      40.7128,
      -74.0060,
    ), // Example coordinates for New York
  );

  // Dummy Provider Data
  UserModel provider = UserModel(
    id: 'provider_1',
    fullName: 'Alice Smith',
    email: 'alice.smith@example.com',
    phoneNumber: '+1987654321',
    location: '456 Elm Street, Tech City',
    userType: 'provider', // Provider type
    profileImageUrl: 'https://example.com/profile_images/alicesmith.jpg',
    createdAt: DateTime.now(),
    coordinates: GeoPoint(
      37.7749,
      -122.4194,
    ), // Example coordinates for San Francisco
  );
}
