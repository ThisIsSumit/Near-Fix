class BookingModel {
  final String id;
  final String customerId;
  final String providerId;
  final String serviceType;
  final String status;
  final String? date;

  BookingModel({
    required this.id,
    required this.customerId,
    required this.providerId,
    required this.serviceType,
    required this.status,
    this.date,
  });
  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id'] as String? ?? '',
      customerId: map['customerId'] as String? ?? '',
      providerId: map['providerId'] as String? ?? '',
      serviceType: map['serviceType'] as String? ?? '',
      status: map['status'] as String? ?? '',
      date: map['date'] as String?,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'providerId': providerId,
      'serviceType': serviceType,
      'status': status,
      'date': date,
    };
  }
}
