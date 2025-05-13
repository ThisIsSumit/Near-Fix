import 'package:firebase_auth/firebase_auth.dart';
import 'package:near_fix/models/user_model.dart';
import 'package:near_fix/services/firestore_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
   

  //login
  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print('Sign in error: $e');
    }
  }

  //signup
  Future<void> signUp(String email, String password, String  userType, String phoneNumber) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = _auth.currentUser;
      UserModel userModel= UserModel(
        id: user!.uid,
        fullName: '',
        email: email,
        phoneNumber: phoneNumber,
        location: '',
        userType: userType,
        profileImageUrl: null,
        createdAt: DateTime.now(),
        coordinates: null,
      );
       await FirestoreService().saveUser(userModel);

    } catch (e) {
      print('Sign up error: $e');
      throw e;
    }
  }

  //signout
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Sign out error: $e');
    }
  }  
   String? getUserId() {
    print('Getting user ID: ${_auth.currentUser?.uid}');
    return _auth.currentUser?.uid;
  }
}
