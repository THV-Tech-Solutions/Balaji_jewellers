//SearchScreen
//final search_screen

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jewellery/Screens/profile.dart';
import 'package:jewellery/Screens/SearchResultScreen.dart';
import 'package:logger/logger.dart';
import 'package:photo_view/photo_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String input = "";
  Stream<QuerySnapshot>? searchResults;
  final CollectionReference searchCollection =
      FirebaseFirestore.instance.collection('Search');

  final FocusNode _searchFocusNode = FocusNode();
  Logger logger =  Logger();

  @override
  void initState() {
    super.initState();
    // Request focus on the FocusNode when the screen is initialized
    _searchFocusNode.requestFocus();
  }

  @override
  void dispose() {
    // Dispose of the FocusNode when the screen is disposed
    _searchFocusNode.dispose();
    super.dispose();
  }

  //displaying image
  void _showImagePopup(
      BuildContext context, String imageUrl, String id, String weight) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            height: 400,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Stack(
              children: [
                PhotoView(
                  imageProvider: NetworkImage(imageUrl),
                  backgroundDecoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2,
                ),
                Positioned(
                  top: 10, // Adjust the top position as needed
                  left: 10, // Adjust the left position as needed
                  child: Text(
                    "Id: $id",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  top: 40, // Adjust the top position as needed
                  left: 10, // Adjust the left position as needed
                  child: Text(
                    "Weight: $weight",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  //end

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: Colors.white54,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Get.to(ProfileScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    // child: Image.asset(
                    //   'assets/images/profileIcon.jpeg',
                    //   width: MediaQuery.of(context).size.width *
                    //       0.08, // Adjust this value as needed
                    //   height: MediaQuery.of(context).size.width *
                    //       0.08, // Adjust this value as needed
                    //   fit: BoxFit.cover,
                    // ),
                    child: const Icon(FontAwesomeIcons.user)
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Material(
              borderRadius: BorderRadius.circular(30),
              elevation: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (val) {
                          setState(() {
                            // Convert user input to lowercase
                            input = val.toLowerCase();
                          });
                        },
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        decoration: InputDecoration(
                          hintText: "Search for Ornaments",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 20),
                        ),
                        focusNode: _searchFocusNode,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: searchCollection.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }

                  // Filter the documents based on the user input
                  final filteredDocs = snapshot.data!.docs.where((doc) {
                    final imageName = doc['ImageName'].toString().toLowerCase();
                    return imageName.contains(input);
                  }).toList();
                  // logger.e('filteredDocs : $filteredDocs');
                  if (filteredDocs.isEmpty) {
                    return Center(
                      child: Text('No results found'),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredDocs.length,
                    itemBuilder: (context, index) {
                      final doc = filteredDocs[index];
                      return ListTile(
                        title: Text(doc['ImageName']),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchResultScreen(
                                title: doc['title'],
                                categories: doc['catagory'],
                                mainFolder: doc['mainFolder'],
                                mainImageUrl: doc['imageUrl'],
                              ),
                            ),
                          );

                          print(doc['mainFolder']);
                          print(doc['title']);
                          print(doc['catagory']);
                          print(doc['imageUrl']);
                        },
                        onLongPress: () {
                          _showImagePopup(context, doc['imageUrl'], doc['id'],
                              doc['weight'].toString());
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
