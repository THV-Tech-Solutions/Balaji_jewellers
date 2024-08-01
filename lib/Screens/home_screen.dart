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
    _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_scrollController.hasClients) {
        final double maxScrollExtent =
            _scrollController.position.maxScrollExtent;
        final double currentScroll = _scrollController.offset;
        final double nextScroll = currentScroll +
            MediaQuery.of(context).size.width * 1.02; // Adjust as needed

        if (nextScroll >= maxScrollExtent) {
          _scrollController.animateTo(
            0.0,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          _scrollController.animateTo(
            nextScroll,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  final List<String> images = [
    'assets/images/canvascrollable.png',
    'assets/images/canvascrollable2.png',
    'assets/images/image 2.jpg',
    'assets/images/poster2.jpg',
    'assets/images/poster3.png',
    'assets/images/jj.jpg',
    'assets/images/poster6.jpg',
    'assets/images/poster7.jpg',
    'assets/images/poster8.jpg',
  ];

  final FocusNode _focusNode = FocusNode();

  void _showUnderDevelopmentMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Under Development"),
          content: Text("This feature is currently under development."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
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
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(65, 0, 0, 0),
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
              width: MediaQuery.of(context).size.width * 0.046,
            ),
            Text(
              "SriBalajiJewelers",
              style: GoogleFonts.mateSc(
                fontSize: 27,
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
                      child: const Icon(FontAwesomeIcons.user)),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 0, 0, 0),
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
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Material(
                        borderRadius: BorderRadius.circular(30),
                        elevation: 2,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
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
                                    Get.to(SearchScreen());
                                  },
                                  style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                  decoration: InputDecoration(
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
                                icon: Icon(Icons.mic),
                                color: Color.fromARGB(221, 255, 255, 255),
                              ),
                              IconButton(
                                onPressed: () {
                                  _showUnderDevelopmentMessage();
                                },
                                icon: Icon(Icons.settings),
                                color: const Color.fromARGB(221, 255, 255, 255),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    CustomCarouselSlider(images: images),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(
                          16.0), // You can adjust the padding value as needed
                      child: GridView.count(
                        crossAxisCount: 3,
                        mainAxisSpacing: 13,
                        crossAxisSpacing: 13,
                        childAspectRatio: (180 / 260),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          CategoryCard(
                            image: "assets/images/rk1.6.png",
                            title: "Gold",
                            onTap: () {
                              Get.to(GoldScreen());
                            },
                          ),
                          CategoryCard(
                            image: "assets/images/rk1.4.png",
                            title: "Silver",
                            onTap: () {
                              Get.to(SilverScreen());
                            },
                          ),
                          CategoryCard(
                            image: "assets/images/diamon.png",
                            title: "Diamond",
                            onTap: () {
                              Get.to(DiamondScreen());
                            },
                          ),
                          CategoryCard(
                            image: "assets/images/ty.jpg",
                            title: "Gemstone",
                            onTap: () {
                              Get.to(GemStonesScreen());
                            },
                          ),
                          CategoryCard(
                            image: "assets/images/RoseGoldHome.png",
                            title: "RoseGold",
                            onTap: () {
                              Get.to(RoseGoldScreen());
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
                              Get.to(GemStonesScreen());
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      margin: EdgeInsets.only(top: 40),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/canva2.png'),
                          fit: BoxFit
                              .cover, // This will cover the entire container.
                        ),
                      ),
                    ),
                    Container(
                      height: 190,
                      margin: EdgeInsets.only(top: 30),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        controller: _scrollController,
                        children: <Widget>[
                          Image.asset('assets/images/canvascroll1.png'),
                          SizedBox(
                            width: 10,
                          ),
                          Image.asset('assets/images/canvascroll2.png'),
                          SizedBox(
                            width: 10,
                          ),
                          Image.asset('assets/images/canvascroll3.png'),
                          SizedBox(
                            width: 10,
                          ),
                          Image.asset('assets/images/canvascroll4.png'),
                          SizedBox(
                            width: 10,
                          ),
                          Image.asset('assets/images/canvascroll5.png'),
                          SizedBox(
                            width: 10,
                          ),
                          Image.asset('assets/images/canvascroll6.png'),
                          SizedBox(
                            width: 10,
                          ),
                          Image.asset('assets/images/canvascroll7.png'),
                          SizedBox(
                            width: 10,
                          ),
                          Image.asset('assets/images/canvascroll8.png'),
                        ],
                      ),
                    ),
                    Container(
                      height: 300,
                      margin: EdgeInsets.only(
                          top: 50, left: 20, right: 20, bottom: 20),
                      decoration: BoxDecoration(
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
                        const Center(
                          child: Text(
                            'Quick Links',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            QuickLinkContainer(
                                assetBackgroundImagePath: "Gold1.png", catagory_: 'Stones', mainFolder_: 'Gold', title_: 'Ladies Rings',),
                            QuickLinkContainer(
                                assetBackgroundImagePath: "Gold5.png", catagory_: 'Stones', mainFolder_: 'Gold', title_: 'Necklace',),
                          ],
                        ),
                        //silver
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            QuickLinkContainer(
                                assetBackgroundImagePath:
                                    "SilverArticles5.png", catagory_: 'Vodharani', mainFolder_: 'Silver', title_: 'Silver Articles',),
                            QuickLinkContainer(
                                assetBackgroundImagePath:
                                    "SilverArticles1.png", catagory_: 'Plates', mainFolder_: 'Silver', title_: 'Silver Articles',),
                          ],
                        ),
                        //silver end
                        //roseGold
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            QuickLinkContainer(
                                assetBackgroundImagePath: "RoseGold5.png", catagory_: 'Stones', mainFolder_: 'RoseGold', title_: 'Harams',),
                            QuickLinkContainer(
                                assetBackgroundImagePath: "rosegold1.png", catagory_: 'Stones', mainFolder_: 'RoseGold', title_: 'Ladies Rings',),
                          ],
                        ),
                        //roseGold end
                        //diamond start
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            QuickLinkContainer(
                                assetBackgroundImagePath: "Diamond2.png", catagory_: 'Stones', mainFolder_: 'Diamond', title_: 'Ladies Rings',),
                            QuickLinkContainer(
                                assetBackgroundImagePath: "Diamond3.png", catagory_: 'Stones', mainFolder_: 'Diamond', title_: 'Necklace',),
                          ],
                        ),
                        //diamond end
                      ],
                    ),
                    Container(
                      height: 180,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'About Us',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.5,
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Check out beautiful gold, silver, diamond, rose gold, and gemstone pur special style from our handpicked gold, silver, diamond, rose gold, and gemstone choices.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.8),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 180,
                        padding: EdgeInsets.all(0.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Contact Us',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              'Email: contact@example.com\nPhone: +1234567890\nAddress: 123 Main St, City',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
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
                          IconButton(
                            onPressed: () {
                              // Launch your social media links here
                            },
                            icon: Icon(
                              Icons.facebook,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // Launch your social media links here
                            },
                            icon: Icon(
                              Icons.face,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // Launch your social media links here
                            },
                            icon: Icon(
                              Icons.face,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            right: 16,
            child: Container(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: FloatingActionButton(
                      onPressed: () {
                        final whatsappLink =
                            'https://wa.me/919247879511?text=Hi%20Balaji%20Jewellers';
                        launch(whatsappLink);
                      },
                      child: Image.network(
                          'https://w7.pngwing.com/pngs/343/922/png-transparent-whatsapp-computer-icons-icon-design-whatsapp-trademark-logo-copyright.png'),
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

  CustomCarouselSlider({required this.images});

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
            autoPlayAnimationDuration: Duration(milliseconds: 800),
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
                return Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width * 0.75,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
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
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.images.map((url) {
            int index = widget.images.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
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

  CategoryCard({
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
        Future.delayed(Duration(milliseconds: 300), () {
          setState(() {
            isTapped = false;
          });
          widget.onTap();
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: isTapped
                  ? Color.fromARGB(0, 96, 96, 96)
                  : Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
              spreadRadius: isTapped ? 0 : 0,
              blurRadius: isTapped ? 0 : 0,
              offset: isTapped ? Offset(0, 0) : Offset(0, 3),
            ),
          ],
          color:
              isTapped ? Colors.orangeAccent : Color.fromARGB(19, 145, 10, 10),
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
                    color: Color.fromARGB(226, 255, 255,
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
                      Shadow(
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

  ExtraCategoryCard({
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
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
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
            Container(
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
      {required this.assetBackgroundImagePath,
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
      padding: EdgeInsets.all(8.0),
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
            borderRadius: BorderRadius.all(Radius.circular(16)),
            image: DecorationImage(
                image: AssetImage(
                    'assets/images/${widget.assetBackgroundImagePath}'),
                fit: BoxFit.cover),
            border: Border.all(
              color: Colors.white70,
              width: 1.5,
            ),
            // gradient: const LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   colors: [Color.fromARGB(255, 240, 231, 131), Colors.white],
            //   stops: [0.3, 1.0], // Adjust the stops as needed
            // ),
            // color: widget.color_,
          ),
          height: 200,
          width: 150,
        ),
      ),
    );
  }
}
