import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:near_fix/models/user_model.dart';

class FirestoreService {
 final  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;


  //save user as customer
  Future<void> saveUser(UserModel user) async {
    try {
      user.serviceProvided = null;
      await _firebaseFirestore
          .collection(user.isCustomer ? 'customers' : 'providers')
          .doc(user.id)
          .set(user.toMap());
    } catch (e) {
      print('Error saving customer: $e');
    }
  }
 // get user by id 
  Future<UserModel> getUser(String userId) async {
    try {
      DocumentSnapshot doc = await _firebaseFirestore
          .collection('customers')
          .doc(userId)
          .get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        doc = await _firebaseFirestore
            .collection('providers')
            .doc(userId)
            .get();
        if (doc.exists) {
          return UserModel.fromMap(doc.data() as Map<String, dynamic>);
        }
      }
    } catch (e) {
      print('Error getting user: $e');
    }
    throw Exception('User not found');
  }



  //add booking cutid , provider



  //get all bookings for a user

}
