import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jewellery/Screens/profile.dart';
import 'package:jewellery/Screens/wishlist_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserListView extends StatefulWidget {
  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  String userPhoneNumber = '';
  String userName = '';
  String wishlistUserCollectionDocName = '';

  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  // final HttpsCallable deleteUserAndDisableAccount =
  //     FirebaseFunctions.instance.httpsCallable('deleteUserAndDisableAccount');

  // Call the Cloud Function with data

  // Handle the result as needed

  void showDeleteConfirmationDialog(String documentId, String userName) {
    showDialog(
      context: context,
      builder: (BuildContext outerContext) {
        return AlertDialog(
          title: const Text('Select One option'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                DeleteOrmakeAdmin(documentId, userName, 'Admin', outerContext);
              },
              child: const Text('Admin'),
            ),
            TextButton(
              onPressed: () {
                DeleteOrmakeAdmin(documentId, userName, 'Delete', outerContext);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void DeleteOrmakeAdmin(String documentId, String userName, String text,
      BuildContext outerContext) {
    print('inside DeleteOrmakeAdmin');
    final firestore = FirebaseFirestore.instance;
    final collection = firestore.collection('users');

    showDialog(
      context: outerContext, // Use the context of the outer dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$text Selected User?'),
          content: Text("Are you sure you want to $text the $userName ?"),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                if (text == 'Delete') {
                  await collection.doc(documentId).delete();
                } else if (text == 'Admin') {
                  print('inside else if ');
                  await collection.doc(documentId).update({
                    'Admin': 'Admin2', // Making as admin
                  });
                }
                Navigator.of(context).pop(); // Close the inner dialog
                Navigator.of(outerContext).pop(); // Close the outer dialog
              },
              child: Text(text),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the inner dialog
                Navigator.of(outerContext).pop(); // Close the outer dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        leadingWidth: 0,
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 70,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                width: 50,
                height: 50,
                child: Image.asset(
                  'assets/images/logo9.png',
                  width: 42,
                  height: 42,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.045,
            ),
            Text(
              "SriBalajiJewelers",
              style: GoogleFonts.mateSc(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
                shadows: [
                  Shadow(
                    offset: Offset(3, 3),
                    blurRadius: 7,
                    color: Colors.black,
                  ),
                ],
                decoration: TextDecoration.none,
                foreground: Paint()
                  ..shader = LinearGradient(
                    colors: [Colors.orange, Colors.orange],
                  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 30.0)),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.045,
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.grey[300],
        child: StreamBuilder<QuerySnapshot>(
          stream: usersCollection.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text('No users found.'),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot userDocument = snapshot.data!.docs[index];
                Map<String, dynamic> userData =
                    userDocument.data() as Map<String, dynamic>;

                // Extract user data
                String userName = userData['userName'] ?? 'N/A';
                String userEmail = userData['userEmail'] ?? 'N/A';
                String userPhoneNumber = userData['userPhoneNumber'] ?? 'N/A';
                String userCity = userData['userCity'] ?? 'N/A';
                String admin_ = userData['Admin'] ?? 'N/A';
                Timestamp timeStamp = userData['TimeStamp'] as Timestamp;

                // Format timestamp
                String formattedTimestamp =
                    timeStamp.toDate().toString(); // Customize this as needed

                return GestureDetector(
                  onLongPress: () {
                    showDeleteConfirmationDialog(userDocument.id, userName);
                  },
                  onTap: () {
                    print('useEditScreen : $userPhoneNumber');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WishlistScreen(
                          userPhoneNumber: userPhoneNumber,
                          userName: userName,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    child: Card(
                      margin: EdgeInsets.all(8.0),
                      elevation: 2.0,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name: $userName',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Email: $userEmail',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              'Phone: $userPhoneNumber',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              'City: $userCity',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              'Admin: $admin_',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              'Timestamp: $formattedTimestamp',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
