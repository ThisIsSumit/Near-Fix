import 'package:latlong2/latlong.dart';
import 'package:near_fix/models/booking_model.dart';
import 'package:near_fix/models/service_model.dart';
import 'package:near_fix/models/user_model.dart';

class Dummydata {
  static UserModel customer1 = UserModel(
    id: 'customer_1',
    fullName: 'John Doe',
    email: 'johndoe@example.com',
    phoneNumber: '+1234567890',
    location: '123 Main Street, New York City',
    userType: 'customer',
    profileImageUrl: 'https://example.com/profile_images/johndoe.jpg',
    createdAt: DateTime.now(),
    coordinates: LatLng(40.7128, -74.0060), // New York
  );

  static UserModel provider1 = UserModel(
    id: 'provider_1',
    fullName: 'Alice Smith',
    email: 'alice.smith@example.com',
    phoneNumber: '+1987654321',
    location: '456 Elm Street, San Francisco',
    userType: 'provider',
    profileImageUrl: 'https://example.com/profile_images/alicesmith.jpg',
    servicesIds: ['service1', 'service3'],
    createdAt: DateTime.now(),
    coordinates: LatLng(37.7749, -122.4194), // San Francisco
  );

  static UserModel customer2 = UserModel(
    id: 'customer_2',
    fullName: 'Bob Brown',
    email: 'bobbrown@example.com',
    phoneNumber: '+1123456789',
    location: '789 Oak Avenue, Chicago',
    userType: 'customer',
    profileImageUrl: 'https://example.com/profile_images/bobbrown.jpg',
    createdAt: DateTime.now(),
    coordinates: LatLng(41.8781, -87.6298), // Chicago
  );

  static UserModel provider2 = UserModel(
    id: 'provider_2',
    fullName: 'Sparkle Cleaners',
    email: 'contact@sparklecleaners.com',
    phoneNumber: '+1478523690',
    location: '321 Maple Lane, Delhi',
    userType: 'provider',
    profileImageUrl: 'https://example.com/profile_images/sparkle.jpg',
    servicesIds: ['service1', 'service2'],
    createdAt: DateTime.now(),
    coordinates: LatLng(28.6139, 77.2090), // Delhi
  );

  static List<ServiceModel> dummyServices = [
    ServiceModel(
      id: 'service1',
      providerId: 'provider_2',
      title: 'Deep Home Cleaning',
      category: 'Cleaning',
      description:
          'Full deep-cleaning of home including floor, windows, kitchen, and bathrooms.',
      price: 90.0,
      priceType: 'hourly',
      location: LatLng(28.6139, 77.2090), // Delhi
      address: 'A-123, Rajpath Marg, New Delhi',
      createdAt: DateTime(2025, 5, 12),
    ),
    ServiceModel(
      id: 'service2',
      providerId: 'provider_1',
      title: 'Bathroom Plumbing Fix',
      category: 'Plumbing',
      description:
          'Fix leakages, pipe replacements, tap installations, and more.',
      price: 120.0,
      priceType: 'fixed',
      location: LatLng(37.7749, -122.4194), // San Francisco
      address: 'Flat 501, Ocean Heights, San Francisco',
      createdAt: DateTime(2025, 5, 13),
    ),
    ServiceModel(
      id: 'service3',
      providerId: 'provider_1',
      title: 'Home Electrical Wiring',
      category: 'Electrical',
      description:
          'Complete wiring and electrical maintenance service for homes.',
      price: 150.0,
      priceType: 'hourly',
      location: LatLng(37.7749, -122.4194), // San Francisco
      address: '221B, MG Road, San Francisco',
      createdAt: DateTime(2025, 5, 14),
    ),
  ];

  static List<BookingModel> dummyBookings = [
    BookingModel(
      id: 'booking1',
      customerId: 'customer_1',
      providerId: 'provider_2',
      serviceId: 'service1',
      serviceName: 'Deep Home Cleaning',
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
      customerId: 'customer_2',
      providerId: 'provider_1',
      serviceId: 'service2',
      serviceName: 'Bathroom Plumbing Fix',
      customerName: 'Bob Brown',
      providerName: 'Alice Smith',
      bookingDate: DateTime(2025, 5, 22),
      status: 'pending',
      notes: null,
      amount: 149.50,
      createdAt: DateTime(2025, 5, 18),
    ),
    BookingModel(
      id: 'booking3',
      customerId: 'customer_2',
      providerId: 'provider_1',
      serviceId: 'service3',
      serviceName: 'Home Electrical Wiring',
      customerName: 'Bob Brown',
      providerName: 'Alice Smith',
      bookingDate: DateTime(2025, 5, 25),
      status: 'confirmed',
      notes: 'Needs urgent repair',
      amount: 200.0,
      createdAt: DateTime(2025, 5, 19),
    ),
  ];
}
