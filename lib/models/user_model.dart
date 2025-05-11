import 'package:near_fix/models/booking_model.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String? address;
  final String? profilePictureUrl;
  final bool isCustomer;
  final List<BookingModel> bookings;
  //coordinates for map
  final double? latitude;
  final double? longitude;
  final double? rating;
  String? serviceProvided;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.address,
    this.profilePictureUrl,
    required this.isCustomer,
    required this.bookings,
    this.latitude,
    this.longitude,
    this.rating,
    this.serviceProvided,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      phoneNumber: map['phoneNumber'],
      address: map['address'] as String?,
      profilePictureUrl: map['profilePictureUrl'] as String?,
      isCustomer: map['isCustomer'] as bool? ?? false,
      bookings:
          (map['bookings'] as List<dynamic>?)
              ?.map((booking) => BookingModel.fromMap(booking))
              .toList() ??
          [],
      latitude: map['latitude'] as double?,
      longitude: map['longitude'] as double?,
      rating: map['rating'] as double?,
      serviceProvided: map['serviceProvided'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'profilePictureUrl': profilePictureUrl,
      'isCustomer': isCustomer,
      'bookings': bookings.map((booking) => booking.toMap()).toList(),
      'latitude': latitude,
      'longitude': longitude,
      'rating': rating,
      'serviceProvided': serviceProvided,
    };
  }
}
