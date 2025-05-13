import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String location;
  final String userType;
  final String? profileImageUrl;
  final DateTime createdAt;
  final GeoPoint? coordinates;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.location,
    required this.userType,
    this.profileImageUrl,
    required this.createdAt,
    this.coordinates,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      fullName: data['fullName'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      location: data['location'] ?? '',
      userType: data['userType'] ?? 'customer',
      profileImageUrl: data['profileImageUrl'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      coordinates: data['coordinates'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'location': location,
      'userType': userType,
      'profileImageUrl': profileImageUrl,
      'createdAt': createdAt,
      'coordinates': coordinates,
    };
  }

  UserModel copyWith({
    String? fullName,
    String? phoneNumber,
    String? location,
    String? profileImageUrl,
    GeoPoint? coordinates,
  }) {
    return UserModel(
      id: this.id,
      fullName: fullName ?? this.fullName,
      email: this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      location: location ?? this.location,
      userType: this.userType,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdAt: this.createdAt,
      coordinates: coordinates ?? this.coordinates,
    );
  }
}
