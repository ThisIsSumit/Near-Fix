import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';

class ServiceModel {
  final String id;
  final String providerId;
  final String title;
  final String category;
  final String description;
  final double price;
  final String priceType;
  final LatLng location;
  final String address;
  final DateTime createdAt;

  ServiceModel({
    required this.id,
    required this.providerId,
    required this.title,
    required this.category,
    required this.description,
    required this.price,
    required this.priceType,
    required this.location,
    required this.address,
    required this.createdAt,
  });

  factory ServiceModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ServiceModel(
      id: doc.id,
      providerId: data['providerId'] ?? '',
      title: data['title'] ?? '',
      category: data['category'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      priceType: data['priceType'] ?? 'hourly',
      location: data['location'] ?? const LatLng(0, 0),
      address: data['address'] ?? '',
    
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'providerId': providerId,
      'title': title,
      'category': category,
      'description': description,
      'price': price,
      'priceType': priceType,
      'location': location,
      'address': address,
     
      'createdAt': createdAt,
    };
  }
}
