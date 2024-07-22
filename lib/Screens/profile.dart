//ProfileScreen

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jewellery/Screens/common_screen.dart';
import 'package:jewellery/Screens/usersEditScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userPhoneNumber;
  String? userName;
  String? userCity;
  String? userEmail;
  String? Admin_;
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    getUserDataFromSharedPreferences();
  }

  Future<void> getUserDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userPhoneNumber = prefs.getString('userPhoneNumber');
      userName = prefs.getString('userName');
      userEmail = prefs.getString('userEmail');
      userCity = prefs.getString('userCity');
      Admin_ = prefs.getString('Admin');
      print('$userPhoneNumber $userName $userCity $userEmail $Admin_');
    });
    if (Admin_ == 'Admin') {
      setState(() {
        isAdmin = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300], // Change to grey[300]
        elevation: 0,
        title: Text(
          'Profile',
          style: GoogleFonts.rowdies(
            // Use your desired Google Font, e.g., 'lobster'
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          if (isAdmin) ...[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.solidImages,
                color: Colors.red,
              ),
              onPressed: () {
                Get.to(CommonScreen(
                  title: 'Home_Slider',
                  categories: ['AllImages'],
                  mainFolder: 'WelcomeImages',
                ));
              },
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.userCheck,
                color: Colors.red,
              ),
              onPressed: () {
                Get.to(UserListView());
              },
            ),
          ],
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // -- TOP CARD
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.45,
              margin: EdgeInsets.symmetric(horizontal: 22.0, vertical: 10.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepOrange.shade700, Colors.orange],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: Offset(0, 4),
                    blurRadius: 12.0,
                  ),
                ],
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
              padding: EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Profile Image
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 4.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: Offset(0, 4),
                              blurRadius: 8.0,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://st2.depositphotos.com/7573446/12066/v/450/depositphotos_120663986-stock-illustration-people-web-vector-icon.jpg'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black54, // Optional: border color
                        width: 2, // Optional: border width
                      ), // Curved borders
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      userName ?? '',
                      style: GoogleFonts.dmSerifDisplay(
                        // Use Google Fonts, you can replace 'lobster' with any font from Google Fonts
                        textStyle: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                          // You can add more text styles like shadows, decoration, etc. here
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color:
                          Colors.grey[300], // Set your desired background color
                      borderRadius: BorderRadius.circular(
                          10), // Optional: for rounded corners
                      border: Border.all(
                        color: Colors.black, // Optional: border color
                        width: 2, // Optional: border width
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.3), // Optional: shadow color
                          spreadRadius: 2, // Optional: spread radius
                          blurRadius: 5, // Optional: blur radius
                          offset: Offset(0, 3), // Optional: shadow offset
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        userPhoneNumber ?? '',
                        style: TextStyle(
                          fontSize:
                              16, // Adjust the font size for the phone number
                          color: Colors.black, // Text color
                          fontFamily:
                              'Roboto', // Optional: specify your desired font family
                          fontWeight:
                              FontWeight.bold, // Optional: specify font weight
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color:
                          Colors.grey[300], // Set your desired background color
                      borderRadius: BorderRadius.circular(
                          10), // Optional: for rounded corners
                      border: Border.all(
                        color: Colors.black, // Optional: border color
                        width: 2, // Optional: border width
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.3), // Optional: shadow color
                          spreadRadius: 2, // Optional: spread radius
                          blurRadius: 5, // Optional: blur radius
                          offset: Offset(0, 3), // Optional: shadow offset
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        userEmail ?? '',
                        style: TextStyle(
                          fontSize:
                              16, // Adjust the font size for the phone number
                          color: Colors.black, // Text color
                          fontFamily:
                              'Roboto', // Optional: specify your desired font family
                          fontWeight:
                              FontWeight.bold, // Optional: specify font weight
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color:
                          Colors.grey[300], // Set your desired background color
                      borderRadius: BorderRadius.circular(
                          10), // Optional: for rounded corners
                      border: Border.all(
                        color: Colors.black, // Optional: border color
                        width: 2, // Optional: border width
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.3), // Optional: shadow color
                          spreadRadius: 2, // Optional: spread radius
                          blurRadius: 5, // Optional: blur radius
                          offset: Offset(0, 3), // Optional: shadow offset
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        userCity ?? '',
                        style: TextStyle(
                          fontSize:
                              16, // Adjust the font size for the phone number
                          color: Colors.black, // Text color
                          fontFamily:
                              'Roboto', // Optional: specify your desired font family
                          fontWeight:
                              FontWeight.bold, // Optional: specify font weight
                        ),
                      ),
                    ),
                  ),

                  // SizedBox(height: 30),

                  // Edit Profile Button

                  // Additional Menu Items
                ],
              ),
            ),

            // -- LIST VIEW ITEMS (Each in a separate Card)

            Card(
              elevation: 5, // Add elevation for a card-like appearance
              margin: EdgeInsets.symmetric(horizontal: 22.0, vertical: 10.0),
              child: ProfileMenuWidget(
                  title: 'Help Center', icon: Icons.help, onPress: () {}),
            ),
            Card(
              elevation: 5, // Add elevation for a card-like appearance
              margin: EdgeInsets.symmetric(horizontal: 22.0, vertical: 10.0),
              child: ProfileMenuWidget(
                  title: 'Refer', icon: Icons.person_add, onPress: () {}),
            ),
            Card(
              elevation: 5, // Add elevation for a card-like appearance
              margin: EdgeInsets.symmetric(horizontal: 22.0, vertical: 10.0),
              child: ProfileMenuWidget(
                title: 'Developers',
                icon: Icons.developer_mode,
                onPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return Scaffold(
                          appBar: AppBar(
                            backgroundColor:
                                Colors.grey[300], // Change to grey[300]
                            elevation: 0,
                            title: Text(
                              'Developers Details',
                              style: GoogleFonts.rowdies(
                                // Use your desired Google Font, e.g., 'lobster'
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            centerTitle: true,
                            leading: BackButton(
                              color: Colors.black,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          body: DevelopersSection(),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            if (isAdmin) ...[
              Card(
                elevation: 5, // Add elevation for a card-like appearance
                margin: EdgeInsets.symmetric(horizontal: 22.0, vertical: 10.0),
                child: ProfileMenuWidget(
                  title: 'Recycle Bin',
                  icon: FontAwesomeIcons.dumpster,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {
                    Get.to(const CommonScreen(
                      title: 'RecycleBin',
                      categories: ['RecycleBin'],
                      mainFolder: 'RecycleBin',
                    ));
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor =
        isDark ? Colors.blue : Colors.green; // Replace with your desired color

    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: iconColor.withOpacity(0.1),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: const Icon(Icons.arrow_forward_ios,
                  size: 18.0, color: Colors.grey),
            )
          : null,
    );
  }
}

class DevelopersSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 400,
        width: 400,
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.orangeAccent,
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center horizontally
            children: [
              DeveloperInfo(
                name: 'Vijay Kumar Vellanki',
                email: 'thvtechnosolutions@gmail.com',
                phone: '9150987651',
              ),
              SizedBox(height: 16.0),
              DeveloperInfo(
                name: 'Tharun Rachabanti',
                email: 'thvtechnosolutions@gmail.com',
                phone: '9347644178',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeveloperInfo extends StatelessWidget {
  final String name;
  final String email;
  final String phone;

  DeveloperInfo({
    required this.name,
    required this.email,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
          children: [
            Text(
              'Name: $name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Email: $email'),
            Text('Phone: $phone'),
          ],
        ),
      ),
    );
  }
}
