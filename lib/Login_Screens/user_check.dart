import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:jewellery/Login_Screens/signin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static String userNumber = '';

  // Check if the user's phone number exists in Firestore
  Future<bool> doesUserPhoneNumberExist(String userPhoneNumber) async {
    try {
      final QuerySnapshot userSnapshot = await _firestore
          .collection('users')
          .where('userPhoneNumber', isEqualTo: userPhoneNumber)
          .get();

      userNumber = userPhoneNumber;
      return userSnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking user phone number: $e');
      return false;
    }
  }

  // Sign the user out
  Future<void> signOut() async {
    await _auth.signOut().then((res) {
      Get.offAll(LoginScreen());
    }).catchError((e) {
      print(e);
    });
  }
}
