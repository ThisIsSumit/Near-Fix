import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:near_fix/models/user_model.dart';
import 'package:near_fix/models/service_model.dart';
import 'package:near_fix/models/booking_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  static const String _usersPath = 'users';
  static const String _servicesPath = 'services';
  static const String _bookingsPath = 'bookings';

  Future<void> saveUser(UserModel user) async {
    try {
      await _db.collection(_usersPath).doc(user.id).set(user.toFirestore());
    } catch (e) {
      _logError('saveUser', e);
      rethrow;
    }
  }

  Future<UserModel> getUser(String userId) async {
    try {
      final doc = await _db.collection(_usersPath).doc(userId).get();
      if (doc.exists == false) {
        throw Exception('User not found');
      }
      return UserModel.fromFirestore(doc);
    } catch (e) {
      _logError('getUser', e);
      rethrow;
    }
  }

  Future<List<UserModel>> getUsersByType(String userType) async {
    try {
      final snapshot =
          await _db
              .collection(_usersPath)
              .where('userType', isEqualTo: userType)
              .get();

      return snapshot.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
    } catch (e) {
      _logError('getUsersByType', e);
      rethrow;
    }
  }

  Future<List<UserModel>> getNearbyProviders(
    GeoPoint location,
    double radiusInKm,
  ) async {
    try {
      final providers = await getUsersByType('provider');

      final degreePerKm = 0.01;
      final latRange = radiusInKm * degreePerKm;
      final lngRange = radiusInKm * degreePerKm;

      return providers
          .where(
            (p) =>
                p.coordinates != null &&
                _isInRange(p.coordinates!, location, latRange, lngRange),
          )
          .toList();
    } catch (e) {
      _logError('getNearbyProviders', e);
      rethrow;
    }
  }

  bool _isInRange(
    GeoPoint point,
    GeoPoint center,
    double latRange,
    double lngRange,
  ) {
    return (point.latitude >= center.latitude - latRange &&
        point.latitude <= center.latitude + latRange &&
        point.longitude >= center.longitude - lngRange &&
        point.longitude <= center.longitude + lngRange);
  }

  Future<String> createService(ServiceModel service) async {
    try {
      final docRef = await _db
          .collection(_servicesPath)
          .add(service.toFirestore());
      return docRef.id;
    } catch (e) {
      _logError('createService', e);
      rethrow;
    }
  }

  Future<List<ServiceModel>> getServices() async {
    try {
      var snapshot = await _db.collection(_servicesPath).get();
      if (snapshot == null) {
        throw Exception("no services found");
      }
      return snapshot.docs
          .map((doc) => ServiceModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      _logError('getServices', e);
      throw Exception("Failed to fetch services");
    }
  }

  Future<void> updateService(ServiceModel service) async {
    try {
      await _db
          .collection(_servicesPath)
          .doc(service.id)
          .update(service.toFirestore());
    } catch (e) {
      _logError('updateService', e);
      rethrow;
    }
  }

  Future<ServiceModel?> getService(String serviceId) async {
    try {
      final doc = await _db.collection(_servicesPath).doc(serviceId).get();
      return doc.exists ? ServiceModel.fromFirestore(doc) : null;
    } catch (e) {
      _logError('getService', e);
      rethrow;
    }
  }

  Future<void> deleteService(String serviceId) async {
    try {
      final activeBookings =
          await _db
              .collection(_bookingsPath)
              .where('serviceId', isEqualTo: serviceId)
              .where('status', whereIn: ['pending', 'confirmed'])
              .get();

      if (activeBookings.docs.isNotEmpty) {
        throw Exception('Cannot delete service with active bookings');
      }

      final batch = _db.batch();

      batch.delete(_db.collection(_servicesPath).doc(serviceId));

      await batch.commit();
    } catch (e) {
      _logError('deleteService', e);
      rethrow;
    }
  }

  Future<List<ServiceModel>> getProviderServices(String providerId) async {
    try {
      final snapshot =
          await _db
              .collection(_servicesPath)
              .where('providerId', isEqualTo: providerId)
              .orderBy('createdAt', descending: true)
              .get();

      return snapshot.docs
          .map((doc) => ServiceModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      _logError('getProviderServices', e);
      rethrow;
    }
  }

  Future<List<ServiceModel>> getServicesByCategory(String category) async {
    try {
      final snapshot =
          await _db
              .collection(_servicesPath)
              .where('category', isEqualTo: category)
              .orderBy('rating', descending: true)
              .get();

      return snapshot.docs
          .map((doc) => ServiceModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      _logError('getServicesByCategory', e);
      rethrow;
    }
  }

  Future<List<ServiceModel>> searchServices(String query) async {
    try {
      final snapshot = await _db.collection(_servicesPath).get();
      final services =
          snapshot.docs.map((doc) => ServiceModel.fromFirestore(doc)).toList();

      final lowercaseQuery = query.toLowerCase();
      return services
          .where(
            (service) =>
                service.title.toLowerCase().contains(lowercaseQuery) ||
                service.description.toLowerCase().contains(lowercaseQuery),
          )
          .toList();
    } catch (e) {
      _logError('searchServices', e);
      rethrow;
    }
  }

  Future<List<ServiceModel>> getNearbyServices(GeoPoint location) async {
    try {
      final snapshot = await _db.collection(_servicesPath).get();
      final services =
          snapshot.docs.map((doc) => ServiceModel.fromFirestore(doc)).toList();
      final radiusInKm = 20;

      final degreePerKm = 0.01;
      final latRange = radiusInKm * degreePerKm;
      final lngRange = radiusInKm * degreePerKm;

      return services
          .where(
            (service) =>
                _isInRange(service.location, location, latRange, lngRange),
          )
          .toList();
    } catch (e) {
      _logError('getNearbyServices', e);
      rethrow;
    }
  }

  Future<String> createBooking(BookingModel booking) async {
    try {
      final docRef = await _db
          .collection(_bookingsPath)
          .add(booking.toFirestore());
      return docRef.id;
    } catch (e) {
      _logError('createBooking', e);
      rethrow;
    }
  }

  Future<void> updateBookingStatus(
    String bookingId,
    String status, {
    String? notes,
  }) async {
    try {
      final updates = <String, dynamic>{'status': status};
      if (notes != null) updates['notes'] = notes;

      await _db.collection(_bookingsPath).doc(bookingId).update(updates);
    } catch (e) {
      _logError('updateBookingStatus', e);
      rethrow;
    }
  }

  Future<BookingModel?> getBooking(String bookingId) async {
    try {
      final doc = await _db.collection(_bookingsPath).doc(bookingId).get();
      return doc.exists ? BookingModel.fromFirestore(doc) : null;
    } catch (e) {
      _logError('getBooking', e);
      rethrow;
    }
  }

  Future<List<BookingModel>> getBookings({
    String? customerId,
    String? providerId,
    String? serviceId,
    String? status,
  }) async {
    try {
      Query query = _db.collection(_bookingsPath);

      if (customerId != null) {
        query = query.where('customerId', isEqualTo: customerId);
      }

      if (providerId != null) {
        query = query.where('providerId', isEqualTo: providerId);
      }

      if (serviceId != null) {
        query = query.where('serviceId', isEqualTo: serviceId);
      }

      if (status != null) {
        query = query.where('status', isEqualTo: status);
      }

      query = query.orderBy('bookingDate', descending: true);

      final snapshot = await query.get();
      return snapshot.docs
          .map((doc) => BookingModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      _logError('getBookings', e);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getDetailedBooking(String bookingId) async {
    try {
      final booking = await getBooking(bookingId);
      if (booking == null) throw Exception('Booking not found');

      final service = await getService(booking.serviceId);
      if (service == null) throw Exception('Service not found');

      final provider = await getUser(booking.providerId);
      if (provider == null) throw Exception('Provider not found');

      final customer = await getUser(booking.customerId);
      if (customer == null) throw Exception('Customer not found');

      return {
        'booking': booking,
        'service': service,
        'provider': provider,
        'customer': customer,
      };
    } catch (e) {
      _logError('getDetailedBooking', e);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getServiceDetails(String serviceId) async {
    try {
      final service = await getService(serviceId);
      if (service == null) throw Exception('Service not found');

      final provider = await getUser(service.providerId);
      if (provider == null) throw Exception('Provider not found');

      return {'service': service, 'provider': provider};
    } catch (e) {
      _logError('getServiceDetails', e);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getProviderDashboardData(
    String providerId,
  ) async {
    try {
      final pendingBookings = await getBookings(
        providerId: providerId,
        status: 'pending',
      );
      final confirmedBookings = await getBookings(
        providerId: providerId,
        status: 'confirmed',
      );
      final completedBookings = await getBookings(
        providerId: providerId,
        status: 'completed',
      );

      final totalEarnings = completedBookings.fold(
        0.0,
        (sum, booking) => sum + booking.amount,
      );

      final services = await getProviderServices(providerId);

      return {
        'pendingBookingsCount': pendingBookings.length,
        'confirmedBookingsCount': confirmedBookings.length,
        'completedBookingsCount': completedBookings.length,
        'totalEarnings': totalEarnings,
        'servicesCount': services.length,
      };
    } catch (e) {
      _logError('getProviderDashboardData', e);
      rethrow;
    }
  }

  void _logError(String method, dynamic error) {
    if (kDebugMode) {
      print('FirestoreService.$method error: $error');
    }
  }
}
