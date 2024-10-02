import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jewellery/Screens/Search.dart';
import 'package:jewellery/Screens/common_screen.dart';
import 'package:jewellery/Screens/diamonds_screen.dart';
import 'package:jewellery/Screens/profile.dart';
import 'gemstones_screen.dart';
import 'gold_screen.dart';
import 'rosegold_screen.dart';
import 'silver_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async'; // Import this for Timer

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_scrollController.hasClients) {
        final double maxScrollExtent =
            _scrollController.position.maxScrollExtent;
        final double currentScroll = _scrollController.offset;
        final double nextScroll = currentScroll +
            MediaQuery.of(context).size.width * 1.02; // Adjust as needed

        if (nextScroll >= maxScrollExtent) {
          _scrollController.animateTo(
            0.0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          _scrollController.animateTo(
            nextScroll,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  final List<String> images = [
    'assets/images/scrollsecond1.png',
    // 'assets/images/scrollsecond.png',
    'assets/images/scrollsecond3.png',
    'assets/images/scrollsecond4.png',
    'assets/images/scrollsecond5.png',
    'assets/images/scrollsecond6.png',
    // 'assets/images/canvascrollable.png',
    // 'assets/images/canvascrollable2.png',
    // 'assets/images/image 2.jpg',
    // 'assets/images/poster2.jpg',
    // 'assets/images/poster3.png',
    // 'assets/images/jj.jpg',
    // 'assets/images/poster6.jpg',
    // 'assets/images/poster7.jpg',
    // 'assets/images/poster8.jpg',
  ];

  final FocusNode _focusNode = FocusNode();

  void _showUnderDevelopmentMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Under Development"),
          content: const Text("This feature is currently under development."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[300],
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(65, 0, 0, 0),
        leadingWidth: 0,
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 70,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: SizedBox(
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
              width: MediaQuery.of(context).size.width * 0.046,
            ),
            Text(
              "SriBalajiJewelers",
              style: GoogleFonts.mateSc(
                fontSize: 27,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
                shadows: [
                  const Shadow(
                    offset: Offset(3, 3),
                    blurRadius: 7,
                    color: Colors.black,
                  ),
                ],
                decoration: TextDecoration.none,
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: [Colors.orange, Colors.orange],
                  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 30.0)),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.046),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: Colors.white54,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Get.to(const ProfileScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      'https://cdn-icons-png.freepik.com/512/10302/10302971.png', // Replace with your network image URL
                      width: MediaQuery.of(context).size.width *
                          0.08, // Adjust as needed
                      height: MediaQuery.of(context).size.width *
                          0.08, // Adjust as needed
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return const Icon(Icons
                            .error); // Show error icon if the image fails to load
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 0, 0, 0),
                  Color.fromARGB(139, 96, 67, 6)
                ], // Black to Gold gradient
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Material(
                        borderRadius: BorderRadius.circular(30),
                        elevation: 2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  onTap: () {
                                    _focusNode.unfocus();
                                    Get.to(const SearchScreen());
                                  },
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                  decoration: const InputDecoration(
                                    hintText: "Search for Ornaments",
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 218, 218,
                                          218), // Change this to the desired color
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: 20),
                                  ),
                                  focusNode: _focusNode,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _showUnderDevelopmentMessage();
                                },
                                icon: const Icon(Icons.mic),
                                color: const Color.fromARGB(221, 255, 255, 255),
                              ),
                              IconButton(
                                onPressed: () {
                                  _showUnderDevelopmentMessage();
                                },
                                icon: const Icon(Icons.settings),
                                color: const Color.fromARGB(221, 255, 255, 255),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    CustomCarouselSlider(images: images),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(
                          16.0), // You can adjust the padding value as needed
                      child: GridView.count(
                        crossAxisCount: 3,
                        mainAxisSpacing: 13,
                        crossAxisSpacing: 13,
                        childAspectRatio: (180 / 260),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          CategoryCard(
                            image: "assets/images/rk1.6.png",
                            title: "Gold",
                            onTap: () {
                              Get.to(const GoldScreen());
                            },
                          ),
                          CategoryCard(
                            image: "assets/images/rk1.4.png",
                            title: "Silver",
                            onTap: () {
                              Get.to(const SilverScreen());
                            },
                          ),
                          CategoryCard(
                            image: "assets/images/diamon.png",
                            title: "Diamond",
                            onTap: () {
                              Get.to(const DiamondScreen());
                            },
                          ),
                          CategoryCard(
                            image: "assets/images/ty.jpg",
                            title: "Gemstone",
                            onTap: () {
                              Get.to(const GemStonesScreen());
                            },
                          ),
                          CategoryCard(
                            image: "assets/images/RoseGoldHome.png",
                            title: "RoseGold",
                            onTap: () {
                              Get.to(const RoseGoldScreen());
                            },
                          ),
                          // ExtraCategoryCard(
                          //   image1: "assets/images/wa.jpg",
                          //   image2: "assets/images/fb.jpg",
                          //   onTapImage1: () {
                          //     final whatsappLink =
                          //         'https://wa.me/919247879511?text=Hi%20Balaji%20Jewellers';
                          //     launch(whatsappLink);
                          //   },
                          //   onTapImage2: () {
                          //     final facebookLink =
                          //         'https://www.facebook.com/profile.php?id=100054242660344&mibextid=ZbWKwL';
                          //     launch(facebookLink);
                          //   },
                          // ),
                          CategoryCard(
                            image: "assets/images/ty.jpg",
                            title: "Gemstone",
                            onTap: () {
                              Get.to(const GemStonesScreen());
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      margin: const EdgeInsets.only(top: 40),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/canva2.png'),
                          fit: BoxFit
                              .cover, // This will cover the entire container.
                        ),
                      ),
                    ),
                    Container(
                      height: 190,
                      margin: const EdgeInsets.only(top: 30),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        controller: _scrollController,
                        children: <Widget>[
                          Image.asset('assets/images/canvascroll1.png'),
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset('assets/images/canvascroll2.png'),
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset('assets/images/canvascroll3.png'),
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset('assets/images/canvascroll4.png'),
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset('assets/images/canvascroll5.png'),
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset('assets/images/canvascroll6.png'),
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset('assets/images/canvascroll7.png'),
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset('assets/images/canvascroll8.png'),
                        ],
                      ),
                    ),
                    Container(
                      height: 300,
                      margin: const EdgeInsets.only(
                          top: 50, left: 20, right: 20, bottom: 20),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/canva3.png'),
                          fit: BoxFit
                              .cover, // This will cover the entire container.
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 15),
                        Text(
                          'Quick Links',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.orbitron(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 203, 203, 203),
                            letterSpacing: 1.5,
                          ),
                        ),

                        const SizedBox(height: 0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            QuickLinkContainer(
                              assetBackgroundImagePath: "QuickLink1.jpeg",
                              catagory_: 'Stones',
                              mainFolder_: 'Gold',
                              title_: 'Ladies Rings',
                            ),
                            QuickLinkContainer(
                              assetBackgroundImagePath: "QuickLink2.jpg",
                              catagory_: 'Stones',
                              mainFolder_: 'Gold',
                              title_: 'Necklace',
                            ),
                          ],
                        ),
                        //silver
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     QuickLinkContainer(
                        //       assetBackgroundImagePath: "QuickLink3.jpg",
                        //       catagory_: 'Vodharani',
                        //       mainFolder_: 'Silver',
                        //       title_: 'Silver Articles',
                        //     ),
                        //     QuickLinkContainer(
                        //       assetBackgroundImagePath: "QuickLink4.jpg",
                        //       catagory_: 'Plates',
                        //       mainFolder_: 'Silver',
                        //       title_: 'Silver Articles',
                        //     ),
                        //   ],
                        // ),
                        //silver end
                        //roseGold
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            QuickLinkContainer(
                              assetBackgroundImagePath: "QuickLink11.webp",
                              catagory_: 'Stones',
                              mainFolder_: 'RoseGold',
                              title_: 'Harams',
                            ),
                            QuickLinkContainer(
                              assetBackgroundImagePath: "QuickLink7.jpg",
                              catagory_: 'Stones',
                              mainFolder_: 'RoseGold',
                              title_: 'Ladies Rings',
                            ),
                          ],
                        ),
                        //roseGold end
                        //diamond start
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            QuickLinkContainer(
                              assetBackgroundImagePath: "QuickLink8.jpg",
                              catagory_: 'Stones',
                              mainFolder_: 'Diamond',
                              title_: 'Ladies Rings',
                            ),
                            QuickLinkContainer(
                              assetBackgroundImagePath: "QuickLink9.jpg",
                              catagory_: 'Stones',
                              mainFolder_: 'Diamond',
                              title_: 'Necklace',
                            ),
                          ],
                        ),
                        //diamond end
                      ],
                    ),
                    Container(
                      height: 200,
                      padding: const EdgeInsets.all(25.0),
                      decoration: const BoxDecoration(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'About Us',
                            style: GoogleFonts.orbitron(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Check out beautiful gold, silver, diamond, rose gold, and gemstone pur special style from our handpicked gold, silver, diamond, rose gold, and gemstone choices.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cinzel(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 130,
                        padding: const EdgeInsets.all(0.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Contact Us',
                              style: GoogleFonts.orbitron(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Email: sribalajijewellers@gmail.com\nPhone: +91 9166226916\nAddress: Bangaram kotlu Bazaar, \nCity - Jaggayyapet',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.cinzel(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.8),
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Launch your social media link here
                            },
                            child: Material(
                              elevation:
                                  8, // Adds more elevation (shadow effect)
                              shape: const CircleBorder(), // Keeps it circular
                              color: const Color.fromARGB(255, 0, 0,
                                  0), // Adds a background color like a button
                              child: InkWell(
                                borderRadius: BorderRadius.circular(
                                    50), // To keep the ripple effect circular
                                onTap: () {
                                  // Handle tap
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      8.0), // Adds padding around the logo to give button-like feel
                                  child: CircleAvatar(
                                    radius: 20, // Size of the circular button
                                    backgroundImage: NetworkImage(
                                      'https://i.pinimg.com/564x/a7/26/b7/a726b78996d835c9b913932ad2a67059.jpg', // Replace with logo URL
                                    ),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Launch your social media link here
                            },
                            child: Material(
                              elevation:
                                  8, // Adds more elevation (shadow effect)
                              shape: const CircleBorder(),
                              color: const Color.fromARGB(255, 0, 0,
                                  0), // Adds a background color like a button
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () {
                                  // Handle tap
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      8.0), // Adds padding around the logo
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                      'https://i.pinimg.com/736x/8f/8f/b4/8f8fb43ce828a22c91c0b59f55fb91b3.jpg', // Replace with logo URL
                                    ),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Launch your social media link here
                            },
                            child: Material(
                              elevation:
                                  8, // Adds more elevation (shadow effect)
                              shape: const CircleBorder(),
                              color: const Color.fromARGB(255, 0, 0,
                                  0), // Adds a background color like a button
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () {
                                  // Handle tap
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      8.0), // Adds padding around the logo
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                      'https://i.pinimg.com/736x/89/34/81/893481b49099773b537d198d284edbd2.jpg', // Replace with logo URL
                                    ),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 55,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            right: 10,
            child: Container(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: FloatingActionButton(
                      onPressed: () {
                        const whatsappLink =
                            'https://wa.me/919247879511?text=Hi%20Balaji%20Jewellers';
                        launch(whatsappLink);
                      },
                      child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSA0W1ZrYWrI28u4z8pNVEdsD-QrbfWPn9QTs1n5amNXYEtxsrYCmsSbfjG6FuW7ZfiOU&usqp=CAU'),
                    ),
                  ),
                  // SizedBox(height: 16),
                  // FloatingActionButton(
                  //   onPressed: () {
                  //     final facebookLink =
                  //         'https://www.facebook.com/profile.php?id=100054242660344&mibextid=ZbWKwL';
                  //     launch(facebookLink);
                  //   },
                  //   child: Image.asset("assets/images/fb.jpg"),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  container() {}
}

class CustomCarouselSlider extends StatefulWidget {
  final List<String> images;

  const CustomCarouselSlider({super.key, required this.images});

  @override
  _CustomCarouselSliderState createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.width * 0.45,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 4 / 3,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 0.8,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: widget.images.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width * 0.75,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: AspectRatio(
                      aspectRatio: 4 / 3,
                      child: Image.asset(
                        item,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.images.map((url) {
            int index = widget.images.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    _currentIndex == index ? Colors.orange : Colors.grey[600],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class CategoryCard extends StatefulWidget {
  final String image;
  final String title;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isTapped = true;
        });
        Future.delayed(const Duration(milliseconds: 300), () {
          setState(() {
            isTapped = false;
          });
          widget.onTap();
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: isTapped
                  ? const Color.fromARGB(0, 96, 96, 96)
                  : const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
              spreadRadius: isTapped ? 0 : 0,
              blurRadius: isTapped ? 0 : 0,
              offset: isTapped ? const Offset(0, 0) : const Offset(0, 3),
            ),
          ],
          color: isTapped
              ? Colors.orangeAccent
              : const Color.fromARGB(19, 145, 10, 10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.asset(
                widget.image,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                  border: Border.all(
                    color: Color.fromARGB(255, 255, 255,
                        255), // Change this to your desired border color
                    width: 0, // Change this to your desired border width
                  ),
                ),
              ),
              Center(
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.tradeWinds(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent,
                    shadows: [
                      const Shadow(
                        offset: Offset(4, 4),
                        blurRadius: 3,
                        color: Colors.black,
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
}

class ExtraCategoryCard extends StatelessWidget {
  final String image1;
  final String image2;
  final VoidCallback onTapImage1;
  final VoidCallback onTapImage2;

  const ExtraCategoryCard({
    super.key,
    required this.image1,
    required this.image2,
    required this.onTapImage1,
    required this.onTapImage2,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle onTap for the entire card, if needed
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.01),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 64,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                child: GestureDetector(
                  onTap: onTapImage1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: Image.asset(
                      image1,
                      height: 64,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 8,
              color: Colors.grey[300],
            ),
            SizedBox(
              height: 64,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                child: GestureDetector(
                  onTap: onTapImage2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: Image.asset(
                      image2,
                      height: 64,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuickLinkContainer extends StatefulWidget {
  String assetBackgroundImagePath;
  String title_;
  String mainFolder_;
  String catagory_;
  QuickLinkContainer(
      {super.key,
      required this.assetBackgroundImagePath,
      required this.catagory_,
      required this.mainFolder_,
      required this.title_});

  @override
  State<QuickLinkContainer> createState() => _QuickLinkContainerState();
}

class _QuickLinkContainerState extends State<QuickLinkContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CommonScreen(
                title: widget.title_,
                categories: [widget.catagory_], // Wrap it in a list
                mainFolder: widget.mainFolder_,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(0)),
            image: DecorationImage(
                image: AssetImage(
                    'assets/images/${widget.assetBackgroundImagePath}'),
                fit: BoxFit.cover),
            border: Border.all(
              color: Colors.white70,
              width: 0,
            ),
            // gradient: const LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   colors: [Color.fromARGB(255, 240, 231, 131), Colors.white],
            //   stops: [0.3, 1.0], // Adjust the stops as needed
            // ),
            // color: widget.color_,
          ),
          height: 160,
          width: 160,
        ),
      ),
    );
  }
}
