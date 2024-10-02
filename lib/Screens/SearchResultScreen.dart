//SearchResultScreen
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:io';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class SearchResultScreen extends StatefulWidget {
  final String mainFolder;
  final String title;
  final String categories;
  final String mainImageUrl;

  const SearchResultScreen(
      {super.key,
      required this.title,
      required this.categories,
      required this.mainFolder,
      required this.mainImageUrl});

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

var logger = Logger();

class _SearchResultScreenState extends State<SearchResultScreen> {
  String generatedId = '';
  final firestore = FirebaseFirestore.instance;
  late TabController tabController;
  List<String> selectedImages = [];
  bool isSelectionMode = false;
  int currentCount = 0;
  double weight = 0;
  Map<String, dynamic> imageUrlCache = {};
  List<DocumentReference> imageUrls = [];
  List<SelectedItem> selectedItems = [];
  String userPhoneNumber = '';
  String userName = '';
  String wishlistUserCollectionDocName = '';
  final ScrollController _scrollController = ScrollController();
  bool isMainImage = false;
  List<String> scrollToimgList = [];
  List<String> isInWishlist = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadImagesForCategory();
    getUserDataFromSharedPreferences();
  }

  Future<void> getUserDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userPhoneNumber = prefs.getString('userPhoneNumber')!;
      userName = prefs.getString('userName')!;
      print("in searchResultScreen $userPhoneNumber $userName");
    });
  }

  Stream<QuerySnapshot> getWishlistImagesStream() {
    return FirebaseFirestore.instance
        .collection(widget.mainFolder)
        .doc(widget.title)
        .collection(widget.categories)
        .orderBy('TimeStamp', descending: true)
        .snapshots(); // Listen to changes in the collection
  }

  void _loadImagesForCategory() {
    final stream = getWishlistImagesStream();

    stream.listen((QuerySnapshot querySnapshot) {
      // This code will be executed whenever there's a change in the Firestore collection.
      final List<DocumentReference> refs = querySnapshot.docs
          .map((doc) => doc.reference)
          .where((ref) => ref != null)
          .toList();

      setState(() {
        imageUrls = refs;
      });
    });
  }

  void _showImagePopup(
      BuildContext context, String imageUrl, String id, String weight) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          child: Container(
            width: 400,
            height: 400, // Specify the height here
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Expanded(
                  child: PhotoView(
                    imageProvider: NetworkImage(imageUrl),
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Weight: $weight",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Id: $id",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _shareSelectedImages() async {
    if (selectedImages.isNotEmpty) {
      final List<String> imageFiles = [];

      for (final imageRef in selectedImages) {
        final filePath = await _downloadImage(imageRef);
        if (filePath.isNotEmpty) {
          imageFiles.add(filePath);
        }
      }

      if (imageFiles.isNotEmpty) {
        Share.shareFiles(imageFiles,
            text: 'Sharing ${selectedImages.length} images');
      } else {
        // Handle the case when no images could be downloaded.
        print('No images to share.');
      }
    }
  }

  Future<String> _downloadImage(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final directory = await getTemporaryDirectory();
        final filePath =
            '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
        final File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        return filePath;
      }
    } catch (e) {
      print('Error downloading image: $e');
    }

    return ''; // Return an empty string if there's an error
  }

  Future<void> _shareImages(List<String> imageUrls) async {
    final List<String> imageFiles = [];

    for (final imageUrl in imageUrls) {
      final filePath = await _downloadImage(imageUrl);
      imageFiles.add(filePath);
    }

    Share.shareFiles(imageFiles, text: 'Sharing ${imageUrls.length} images');
  }

  Future<void> toggleWishlist(imageUrl, id, weight) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final collection = firestore
          .collection('Wishlist')
          .doc('${userName}_$userPhoneNumber')
          .collection('Wishlist');

      final existingDoc = await collection
          .where('imageUrl', isEqualTo: imageUrl)
          .limit(1)
          .get();

      if (existingDoc.docs.isNotEmpty) {
        // Item exists in the wishlist, remove it
        await collection.doc(existingDoc.docs.first.id).delete();
        setState(() {
          isInWishlist.remove(imageUrl); // Remove from the list
        });
      } else {
        // Item does not exist in the wishlist, add it
        await collection.add({
          'imageUrl': imageUrl,
          'id': id,
          'weight': weight,
        });
        setState(() {
          isInWishlist.add(imageUrl); // Add to the list
        });
      }
    } catch (e) {
      print('Error toggling wishlist: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        leading: BackButton(
          color: Color.fromARGB(255, 255, 255, 255),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '${widget.title}->${widget.categories}',
          style: GoogleFonts.rowdies(
            textStyle: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          if (isSelectionMode) ...[
            IconButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                _shareSelectedImages();
              },
              icon: const Icon(
                Icons.share,
                color: Colors.blue,
                size: 30,
              ),
            ),
          ],
        ],
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 0, 0, 0),
              Color.fromARGB(255, 101, 70, 1)
            ], // Black to Gold gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: Visibility(
                  visible: isLoading,
                  child: SpinKitCircle(
                    size: 120,
                    itemBuilder: (context, index) {
                      final colors = [Colors.orangeAccent, Colors.black];
                      final color = colors[index % colors.length];

                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: color,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: buildGridView(imageUrls),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          final whatsappLink =
              'https://wa.me/919247879511?text=Hi%2C%20Balaji%20Jewellers%2C%20I%20am%20$userName%20and%20interested%20in%20your%20catalogue';
          launch(whatsappLink);
        },
        child: Container(
          width: 80.0, // Adjust the width of the rectangular container
          height: 56.0, // Adjust the height of the rectangular container
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                11.0), // Adjust the border radius as needed
            color: Colors.green,
          ),
          child: Image.asset(
            "assets/images/wa.jpg", // Replace with the path to your asset
            width: 66.0, // Adjust the width of the image
            height: 42.0, // Adjust the height of the image
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildGridView(List<DocumentReference<Object?>> imageUrls) {
    return GridView.builder(
      controller: _scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
        mainAxisExtent: 270,
      ),
      itemCount: imageUrls.length,
      itemBuilder: (BuildContext context, index) {
        final documentReference = imageUrls[index];

        return FutureBuilder<Map<String, dynamic>>(
          future: _getImageUrlFromReference(documentReference),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.white,
                ),
              );
            } else if (snapshot.hasError) {
              return const Text('Error loading image');
            } else {
              final data = snapshot.data;
              final imageUrl = data?['imageUrl'];
              final id = data?['id'];
              final weight = data?['weight'];
              final isSelected = selectedImages.contains(imageUrl);
              final isInWish = isInWishlist.contains(imageUrl);

              final isMainImage = scrollToimgList.contains(imageUrl);

              if (imageUrl == widget.mainImageUrl) {
                // Print statements for debugging
                print('Scrolling to main image: $imageUrl');
                print('Index: $index');
                _scrollController
                    .jumpTo(index * 100); // Adjust this value as needed
              }

              return Container(
                decoration: BoxDecoration(
                  border: isMainImage
                      ? Border.all(
                          color: Colors.red, // Set the unique border color
                          width: 1.5, // Set the border width
                        )
                      : null, // No border for non-main images
                  borderRadius: isMainImage
                      ? BorderRadius.circular(
                          1.5) // Set the border radius based on the border width
                      : null, // No border radius for non-main images
                ),
                child: Card(
                  color: Color.fromARGB(115, 0, 0, 0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelectionMode) {
                          if (!isSelected) {
                            selectedImages.add(imageUrl!);
                          } else {
                            selectedImages.remove(imageUrl);
                            if (selectedImages.isEmpty) {
                              isSelectionMode = false;
                            }
                          }
                        } else {
                          _showImagePopup(context, imageUrl!, id, weight);
                        }
                      });
                    },
                    onLongPress: () {
                      setState(() {
                        isSelectionMode = !isSelectionMode;
                        if (!isSelected) {
                          selectedImages.add(imageUrl!);
                        }
                      });
                    },
                    child: SizedBox(
                      height: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: 180,
                                width: 190,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrl.toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        color: Colors.white,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.delete),
                                  ),
                                ),
                              ),
                              if (isSelected)
                                const Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 32,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Text(
                                  "Weight : $weight",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Id : $id',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        toggleWishlist(
                                            imageUrl, id, weight.toString());
                                      },
                                      icon: Icon(
                                        isInWish
                                            ? Icons.favorite
                                            : Icons.favorite_outline,
                                        size: 30,
                                        color: isInWish
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }

  Future<Map<String, dynamic>> _getImageUrlFromReference(
      DocumentReference reference) async {
    final String refPath = reference.path;

    if (imageUrlCache.containsKey(refPath)) {
      return imageUrlCache[refPath];
    }

    try {
      final snapshot = await reference.get();
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;

        if (data.isNotEmpty && data.containsKey('imageUrl')) {
          final imageUrl = data['imageUrl'] as String;
          final Id = data['id'] as String;
          final weight = data['weight'] as String;

          if (imageUrl == widget.mainImageUrl) {
            scrollToimgList.add(imageUrl);
            print('bool in _getimageref : $isMainImage');
            print(scrollToimgList);
          }

          try {
            final querySnapshot = await FirebaseFirestore.instance
                .collection('Wishlist')
                .doc('${userName}_$userPhoneNumber')
                .collection('Wishlist')
                .where('imageUrl', isEqualTo: imageUrl)
                .get();

            if (querySnapshot.docs.isNotEmpty) {
              // If there are any documents with the same imageUrl, it's in the Wishlist
              isInWishlist.add(imageUrl);
            }

            // If there are any documents with the same imageUrl, it's in the Wishlist
          } catch (e) {
            print('Error checking imageUrl in Wishlist: $e');
            // Handle the error case accordingly
          }

          imageUrlCache[refPath] = {
            'imageUrl': imageUrl,
            'id': Id,
            'weight': weight,
          };

          return imageUrlCache[refPath];
        }
      }
    } catch (e) {
      print('Error fetching image URL: $e');
    }

    return {};
  }
}

class SelectedItem {
  final String imageUrls;
  bool isSelected;

  SelectedItem(this.imageUrls, {this.isSelected = false});
}
