// UserDetailsScreen

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jewellery/Screens/tabs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class userDetailsScreen extends StatefulWidget {
  String userPhoneNumber_;

  userDetailsScreen({super.key, required this.userPhoneNumber_});

  @override
  State<userDetailsScreen> createState() => _userDetailsScreenState();
}

class _userDetailsScreenState extends State<userDetailsScreen> {
  final TextEditingController _userNameCtrl = TextEditingController();
  final TextEditingController _userEmailCtrl = TextEditingController();
  final TextEditingController _userCityCtrl = TextEditingController();
  bool isLoading = false;
  String tempName = '';
  bool isCity = false;
  bool isfullName = false;

  //checking wether the user exist or not
  Future<void> saveUserDataToFirestoreAndSharedPreferences() async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      String? pushNotificationToken =
          await FirebaseMessaging.instance.getToken();
      print(pushNotificationToken);

      await firestore.collection('users').add({
        'userPhoneNumber': widget.userPhoneNumber_,
        'userName': _userNameCtrl.text,
        'userEmail': _userEmailCtrl.text,
        'userCity': _userCityCtrl.text,
        'Admin': '',
        'notificationtoken': pushNotificationToken,
        'TimeStamp': Timestamp.now(),
      });

      // Save user data to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString('userPhoneNumber', _userPhoneCtrl.text);
      await prefs.setString('userName', _userNameCtrl.text);
      await prefs.setString('userEmail', _userEmailCtrl.text);
      await prefs.setString('userCity', _userCityCtrl.text);
      await prefs.setString('userPhoneNumber', widget.userPhoneNumber_);

      print('User data saved to Firestore and SharedPreferences');
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error saving user data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 70),
              Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/images/logo.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Register",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Tell us more about yourself !",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      const SizedBox(height: 25),
                      _buildTextFormField(
                        labelText: "Full Name",
                        prefixIcon: Icons.account_circle,
                        keyboardType: TextInputType.name,
                        controller: _userNameCtrl,
                      ),
                      //fill name field end

                      const SizedBox(height: 25),
                      _buildTextFormField(
                        labelText: "Email",
                        prefixIcon: Icons.mail_rounded,
                        keyboardType: TextInputType.emailAddress,
                        controller: _userEmailCtrl,
                      ),
                      //email field end

                      const SizedBox(height: 25),
                      _buildTextFormField(
                        labelText: "City",
                        prefixIcon: Icons.location_city_rounded,
                        keyboardType: TextInputType.name,
                        controller: _userCityCtrl,
                      ),
                      //city field end
                      const SizedBox(
                        height: 20,
                      ),
                      //save new user details to firestore button start
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator() // Show loading indicator
                            : const Text(
                                "Getting Started",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                        onPressed: () async {
                          setState(() {
                            isLoading = true; // Set loading to true
                          });
                          if (_userNameCtrl.text.isNotEmpty &&
                              _userCityCtrl.text.isNotEmpty) {
                            await saveUserDataToFirestoreAndSharedPreferences();
                            Get.offAll(const TabsScreen());
                          } else if (_userNameCtrl.text.isNotEmpty &&
                              _userCityCtrl.text.isEmpty) {
                            setState(() {
                              isLoading = false;
                            });
                            Fluttertoast.showToast(
                              msg: "Please enter City name!",
                              toastLength: Toast
                                  .LENGTH_SHORT, // Duration for the toast message
                              gravity: ToastGravity
                                  .BOTTOM, // Position of the toast message
                              backgroundColor:
                                  Colors.red, // Background color of the toast
                              textColor:
                                  Colors.white, // Text color of the toast
                              fontSize: 16.0, // Font size of the toast text
                            );
                          } else if (_userNameCtrl.text.isEmpty &&
                              _userCityCtrl.text.isNotEmpty) {
                            setState(() {
                              isLoading = false;
                            });
                            Fluttertoast.showToast(
                              msg: "Please enter Full Name!",
                              toastLength: Toast
                                  .LENGTH_SHORT, // Duration for the toast message
                              gravity: ToastGravity
                                  .BOTTOM, // Position of the toast message
                              backgroundColor:
                                  Colors.red, // Background color of the toast
                              textColor:
                                  Colors.white, // Text color of the toast
                              fontSize: 16.0, // Font size of the toast text
                            );
                          } else if (_userNameCtrl.text.isEmpty &&
                              _userCityCtrl.text.isEmpty) {
                            setState(() {
                              isLoading = false;
                            });
                            Fluttertoast.showToast(
                              msg: "Please enter Full name and City name!",
                              toastLength: Toast
                                  .LENGTH_SHORT, // Duration for the toast message
                              gravity: ToastGravity
                                  .BOTTOM, // Position of the toast message
                              backgroundColor:
                                  Colors.red, // Background color of the toast
                              textColor:
                                  Colors.white, // Text color of the toast
                              fontSize: 16.0, // Font size of the toast text
                            );
                          }
                        },
                      ),

                      //save new user details to firestore button end

                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String labelText,
    required IconData prefixIcon,
    bool obscureText = false,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      style: TextStyle(color: Colors.grey[800]),
      obscureText: obscureText,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.orangeAccent, width: 2.0),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[400]!, width: 2.0),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: labelText,
        prefixIcon: Icon(prefixIcon, color: Colors.grey[800]),
      ),
    );
  }
}
