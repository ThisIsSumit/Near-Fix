import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String id;
  final String customerId;
  final String providerId;
  final String serviceId;

  final String serviceName;
  final String customerName;
  final String providerName;
  final DateTime bookingDate;
  final String status; 
  final String? notes;
  final double amount;
  final DateTime createdAt;
  
  BookingModel({
    required this.id,
    required this.customerId,
    required this.providerId,
    required this.serviceId,
    required this.serviceName,
    required this.customerName,
    required this.providerName,
    required this.bookingDate,
    required this.status,
    this.notes,
    required this.amount,
    required this.createdAt,
  });
  
  factory BookingModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return BookingModel(
      id: doc.id,
      customerId: data['customerId'] ?? '',
      providerId: data['providerId'] ?? '',
      serviceId: data['serviceId'] ?? '',
      serviceName: data['serviceName'] ?? '',
      customerName: data['customerName'] ?? '',
      providerName: data['providerName'] ?? '',
      bookingDate: (data['bookingDate'] as Timestamp).toDate(),
      status: data['status'] ?? 'pending',
      notes: data['notes'],
      amount: (data['amount'] ?? 0).toDouble(),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
  
  Map<String, dynamic> toFirestore() {
    return {
      'customerId': customerId,
      'providerId': providerId,
      'serviceId': serviceId,
      'serviceName': serviceName,
      'customerName': customerName,
      'providerName': providerName,
      'bookingDate': bookingDate,
      'status': status,
      'notes': notes,
      'amount': amount,
      'createdAt': createdAt,
    };
  }
  
  BookingModel copyWith({
    String? status,
    String? notes,
  }) {
    return BookingModel(
      id: id,
      customerId: customerId,
      providerId: providerId,
      serviceId: serviceId,
      serviceName: serviceName,
      customerName: customerName,
      providerName: providerName,
      bookingDate: bookingDate,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      amount: amount,
      createdAt: createdAt,
    );
  }
}
