//login screen

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jewellery/HelperFunctions/Toast.dart';
import 'package:jewellery/Login_Screens/userDetailsScreen.dart';
import 'package:jewellery/Screens/tabs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneNumberCtrl = TextEditingController();
  final TextEditingController _otpCtrl = TextEditingController();
  bool showOTPField = false; // Initially hide OTP field
  String _verificationId = '';
  bool isLoading = false;
  bool otpSent = false;
  //checking wether the user exist or not
  Future<void> checkUserExistOrNot(String userPhoneNumber) async {
    print('phoneNumber inside existing user check $userPhoneNumber');
    try {
      final CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');

      // Query the 'users' collection for the provided phone number
      QuerySnapshot querySnapshot = await usersCollection
          .where('userPhoneNumber', isEqualTo: userPhoneNumber)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // If a document with the provided phone number exists, fetch its data
        DocumentSnapshot document = querySnapshot.docs.first;
        print('Document data: ${document.data()}');

        String userPhoneNumber = document['userPhoneNumber'];
        String userName = document['userName'];
        String userCity = document['userCity'];
        String userEmail = document['userEmail'];
        String Admin = document['Admin'];

        // Save user data to SharedPreferences

        // Save user data to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userPhoneNumber', userPhoneNumber);
        await prefs.setString('userEmail', userEmail);
        await prefs.setString('userName', userName);
        await prefs.setString('userCity', userCity);
        await prefs.setString('Admin', Admin);

        print('User data saved to SharedPreferences');
        Get.offAll(const TabsScreen());
        setState(() {
          isLoading = false;
        });
      } else {
        // If the phone number does not exist in the 'users' collection, return null
        print('User not found in Firestore');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => userDetailsScreen(
              userPhoneNumber_: userPhoneNumber,
            ),
          ),
        );
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching user data: $e');
      ToastMessage.toast_("Error : ${e.toString()}");
    }
  }

  Future<void> loginWithPhone() async {
    String PhoneNumber = formatPhoneNumber(_phoneNumberCtrl.text);
    print(PhoneNumber);
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: PhoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
          // This callback will be called when the verification is completed automatically
          // using the auto-retrieval method.
        },
        verificationFailed: (FirebaseAuthException authException) {
          setState(() {
            isLoading = false;
          });
          print('Phone verification failed. Code: ${authException.code}');
          // Handle the error, e.g., show an error message to the user.
          ToastMessage.toast_(
              "Phone verification failed. Code: ${authException.code}");
        },
        codeSent: (String verificationId, [int? forceResendingToken]) {
          // verifyOTP(verificationId);
          _verificationId = verificationId;
          if (_verificationId.isNotEmpty) {
            setState(() {
              otpSent = true;
              isLoading = false;
            });
          }
          print('verificationId : $verificationId');
          print('_verificationId : $_verificationId');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto retrieval timeout, handle the situation here
        },
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error sending OTP: $e');
      ToastMessage.toast_(e.toString());
    }
  }

  Future<void> verifyOTP(String otp) async {
    String PhoneNumber = formatPhoneNumber(_phoneNumberCtrl.text);

    try {
      if (_verificationId.isNotEmpty) {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId,
          smsCode: otp,
        );

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        if (userCredential.user != null) {
          // If OTP is verified successfully, navigate to the next screen
          // ignore: use_build_context_synchronously
          await checkUserExistOrNot(PhoneNumber);
        } else {
          setState(() {
            isLoading = false;
          });
          print('Error verifying OTP');
          ToastMessage.toast_("InCorrect OTP!");
        }
      } else {
        setState(() {
          isLoading = false;
        });
        print("Sending OTP failed");
        ToastMessage.toast_(
            "Oops!. Sending the OTP failed. Please try after some time.");
      }
    } catch (e) {
      print('Error verifying OTP: $e');
      ToastMessage.toast_("Error verifying OTP: ${e.toString()}");
      setState(() {
        isLoading = false;
      });
    }
  }

  String formatPhoneNumber(String phoneNumber) {
    // Remove any non-numeric characters
    phoneNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');

    if (!phoneNumber.startsWith('91')) {
      phoneNumber = '91$phoneNumber';
    }

    if (phoneNumber.length == 10 && phoneNumber.startsWith('91')) {
      phoneNumber = '91$phoneNumber';
    }

    // Check if the number starts with a leading plus (+)
    if (!phoneNumber.startsWith('+')) {
      // Add the leading plus for international format
      phoneNumber = '+$phoneNumber';
    }
    print('phoneNumber : $phoneNumber');
    return phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
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
                          "Verification",
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
                        if (!showOTPField) ...[
                          const Text(
                            "We'll send you a one-time code to your phone number",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                        if (showOTPField) ...[
                          const Text(
                            "Enter OTP to register or Login",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                        const SizedBox(height: 25),
                        _buildTextFormField(
                          labelText: "Enter Phone Number",
                          prefixIcon: Icons.phone,
                          keyboardType: TextInputType.phone,
                          controller: _phoneNumberCtrl,
                        ),

                        // Phone number input end

                        if (otpSent) ...[
                          Column(
                            children: [
                              const SizedBox(height: 15),
                              _buildTextFormField(
                                labelText: "OTP",
                                prefixIcon: Icons.security,
                                keyboardType: TextInputType.number,
                                controller: _otpCtrl,
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orangeAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 15),
                                ),
                                child: isLoading // Check the loading variable
                                    ? const CircularProgressIndicator() // Show loading indicator
                                    : const Text(
                                        "Verify OTP",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                onPressed: () {
                                  if (_otpCtrl.text.length == 6) {
                                    setState(() {
                                      isLoading = true; // Set loading to true
                                    });
                                    verifyOTP(_otpCtrl.text);
                                    FocusScope.of(context).unfocus();
                                  } else {
                                    Fluttertoast.showToast(
                                      msg:
                                          "You entered ${_otpCtrl.text.length} digits of OTP only; please enter 6 digits of OTP.",
                                      toastLength: Toast
                                          .LENGTH_SHORT, // Duration for the toast message
                                      gravity: ToastGravity
                                          .BOTTOM, // Position of the toast message
                                      backgroundColor: Colors
                                          .red, // Background color of the toast
                                      textColor: Colors
                                          .white, // Text color of the toast
                                      fontSize:
                                          16.0, // Font size of the toast text
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ] else ...[
                          Column(
                            // Wrap the else block in a Column
                            children: [
                              const SizedBox(height: 20),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orangeAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 15),
                                ),
                                child: isLoading // Check the loading variable
                                    ? const CircularProgressIndicator() // Show loading indicator
                                    : const Text(
                                        "Send OTP",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                onPressed: () {
                                  setState(() {
                                    isLoading = true; // Set loading to true
                                  });
                                  loginWithPhone();
                                  setState(() {
                                    showOTPField = true;
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
