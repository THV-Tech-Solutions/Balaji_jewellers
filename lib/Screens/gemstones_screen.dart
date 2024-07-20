//GEMSTONE SCREEN

//final_silver_screen

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jewellery/Screens/common_screen.dart';

class GemStonesScreen extends StatefulWidget {
  const GemStonesScreen({Key? key}) : super(key: key);

  @override
  State<GemStonesScreen> createState() => _GemStonesScreenState();
}

class _GemStonesScreenState extends State<GemStonesScreen> {
  int currentTabIndex = 0;
  final ScrollController _scrollController = ScrollController();
  String selectedCategory = '';
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final String mainFolder = 'GemStones';

  final List<String> titles = [
    'Navaratnallu',
    'Even more GemStones',
  ];

  final List<List<String>> categoriesForTitles = [
    [
      'Kempu',
      'Diamond',
      'Blue Safare',
      'Yellow Safare',
      'Hessonite',
      'Cats Eye',
      'Paral',
      'Koral',
      'Emerold',
    ],
    [
      'Rudrakshalu',
      'Spatikalu',
      'Semi Freshes',
      'Rudrakshalu',
      'Spatikalu',
      'Semi Freshes',
      'Rudrakshalu',
      'Spatikalu',
      'Semi Freshes',
    ],
  ];

  final Map<String, String> itemImages = {
    'Kempu':
        'https://firebasestorage.googleapis.com/v0/b/jewelleryapp-9e127.appspot.com/o/WelcomeImages%2Fgemstones_images%2FGemstone1.png?alt=media&token=1b54649e-f7fd-4885-bcf8-9960b8fddd4c&_gl=1*14e0xh*_ga*MTQ0Njc1NzE2Ny4xNjkxNzU3NDc1*_ga_CW55HF8NVT*MTY5NjEzMzQxMS4xMzQuMS4xNjk2MTMzNjI5LjYwLjAuMA..',
    'Diamond':
        'https://firebasestorage.googleapis.com/v0/b/jewelleryapp-9e127.appspot.com/o/WelcomeImages%2Fgemstones_images%2FGemstone2.png?alt=media&token=4e25fe07-04c6-4b82-8877-720a86ba23ad&_gl=1*1ai8rum*_ga*MTQ0Njc1NzE2Ny4xNjkxNzU3NDc1*_ga_CW55HF8NVT*MTY5NjEzMzQxMS4xMzQuMS4xNjk2MTM0MDM1LjU0LjAuMA..',
    'Blue Safare':
        'https://firebasestorage.googleapis.com/v0/b/jewelleryapp-9e127.appspot.com/o/WelcomeImages%2Fgemstones_images%2FGemstone3.png?alt=media&token=af0e306e-1ab8-4700-93ff-00dc3106aef1&_gl=1*6o7xkr*_ga*MTQ0Njc1NzE2Ny4xNjkxNzU3NDc1*_ga_CW55HF8NVT*MTY5NjEzMzQxMS4xMzQuMS4xNjk2MTM0MDUyLjM3LjAuMA..',
    'Yellow Safare':
        'https://firebasestorage.googleapis.com/v0/b/jewelleryapp-9e127.appspot.com/o/WelcomeImages%2Fgemstones_images%2FGemstone4.png?alt=media&token=2676ce78-7644-4243-b149-64e1369d1913&_gl=1*xqzd2n*_ga*MTQ0Njc1NzE2Ny4xNjkxNzU3NDc1*_ga_CW55HF8NVT*MTY5NjEzMzQxMS4xMzQuMS4xNjk2MTM0MDY2LjIzLjAuMA..',
    'Hessonite':
        'https://firebasestorage.googleapis.com/v0/b/jewelleryapp-9e127.appspot.com/o/WelcomeImages%2Fgemstones_images%2FGemstone5.png?alt=media&token=c51ddab1-0461-4bf0-add8-930847ad58ba&_gl=1*1thp34p*_ga*MTQ0Njc1NzE2Ny4xNjkxNzU3NDc1*_ga_CW55HF8NVT*MTY5NjEzMzQxMS4xMzQuMS4xNjk2MTM0MDc1LjE0LjAuMA..',
    'Cats Eye':
        'https://firebasestorage.googleapis.com/v0/b/jewelleryapp-9e127.appspot.com/o/WelcomeImages%2Fgemstones_images%2FGemstone6.png?alt=media&token=fa727cdc-256b-4f91-ab2b-12f08c169e54&_gl=1*ogzg52*_ga*MTQ0Njc1NzE2Ny4xNjkxNzU3NDc1*_ga_CW55HF8NVT*MTY5NjEzMzQxMS4xMzQuMS4xNjk2MTM0MDg1LjQuMC4w',
    'Paral':
        'https://firebasestorage.googleapis.com/v0/b/jewelleryapp-9e127.appspot.com/o/WelcomeImages%2Fgemstones_images%2FGemstone7.png?alt=media&token=5faf6895-2797-49a6-878b-f0993f525fd9&_gl=1*1rt8095*_ga*MTQ0Njc1NzE2Ny4xNjkxNzU3NDc1*_ga_CW55HF8NVT*MTY5NjEzMzQxMS4xMzQuMS4xNjk2MTM0MDk2LjYwLjAuMA..',
    'Koral':
        'https://firebasestorage.googleapis.com/v0/b/jewelleryapp-9e127.appspot.com/o/WelcomeImages%2Fgemstones_images%2FGemstone8.png?alt=media&token=f32027aa-70c7-476e-be45-68f4e2114b91&_gl=1*zrwtdh*_ga*MTQ0Njc1NzE2Ny4xNjkxNzU3NDc1*_ga_CW55HF8NVT*MTY5NjEzMzQxMS4xMzQuMS4xNjk2MTM0MTA3LjQ5LjAuMA..',
    'Emerold':
        'https://firebasestorage.googleapis.com/v0/b/jewelleryapp-9e127.appspot.com/o/WelcomeImages%2Fgemstones_images%2FGemstone9.png?alt=media&token=fdc4f9d5-4f8e-4b97-8c68-331fa45f389d&_gl=1*1e4wl2i*_ga*MTQ0Njc1NzE2Ny4xNjkxNzU3NDc1*_ga_CW55HF8NVT*MTY5NjEzMzQxMS4xMzQuMS4xNjk2MTM0MTE2LjQwLjAuMA..',
    'Rudrakshalu':
        'https://firebasestorage.googleapis.com/v0/b/jewelleryapp-9e127.appspot.com/o/WelcomeImages%2Fgemstones_images%2FGemstone10.png?alt=media&token=1ee1b01e-51aa-4e2c-a445-8d6028968d08&_gl=1*1tc9lip*_ga*MTQ0Njc1NzE2Ny4xNjkxNzU3NDc1*_ga_CW55HF8NVT*MTY5NjEzMzQxMS4xMzQuMS4xNjk2MTM0MTI5LjI3LjAuMA..',
    'Spatikalu':
        'https://firebasestorage.googleapis.com/v0/b/jewelleryapp-9e127.appspot.com/o/WelcomeImages%2Fgemstones_images%2FGemstone11.png?alt=media&token=37228536-e69b-44a7-b066-15b17cabf7fa&_gl=1*1pqh53q*_ga*MTQ0Njc1NzE2Ny4xNjkxNzU3NDc1*_ga_CW55HF8NVT*MTY5NjEzMzQxMS4xMzQuMS4xNjk2MTM0MTU4LjYwLjAuMA..',
    'Semi Freshes':
        'https://firebasestorage.googleapis.com/v0/b/jewelleryapp-9e127.appspot.com/o/WelcomeImages%2Fgemstones_images%2FGemstone12.png?alt=media&token=d9145fb8-9242-440d-9670-3793795923f8&_gl=1*1fizto5*_ga*MTQ0Njc1NzE2Ny4xNjkxNzU3NDc1*_ga_CW55HF8NVT*MTY5NjEzMzQxMS4xMzQuMS4xNjk2MTM0MjE3LjEuMC4w',
  };

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToCategory(String category) {
    final index = categoriesForTitles[currentTabIndex].indexOf(category);
    if (index != -1) {
      // Scroll to the selected category
      _scrollController.animateTo(
        index.toDouble() * 95.0, // Adjust for your itemHeight
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.grey[300],
        title: Center(
          child: Text(
            mainFolder,
            style: GoogleFonts.rowdies(
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () async {
                await showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(
                    categoriesForTitles: categoriesForTitles[currentTabIndex],
                  ),
                ).then(
                  (selectedCategory) {
                    if (selectedCategory != null &&
                        selectedCategory.isNotEmpty) {
                      scrollToCategory(selectedCategory);
                      setState(() {
                        this.selectedCategory = selectedCategory;
                      });
                    }
                  },
                );
              },
            ),
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          // CUSTOM TABBAR
          Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            height: 60,
            child: ListView.builder(
              itemCount: titles.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      currentTabIndex = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(3),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: currentTabIndex == index
                          ? Colors.orange
                          : Colors.white70,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: currentTabIndex == index
                            ? Colors.orange
                            : Colors.grey,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        titles[index],
                        style: GoogleFonts.mateSc(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: currentTabIndex == index
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // MAIN BODY
          Expanded(
            child: AnimatedList(
              key: _listKey,
              controller: _scrollController,
              initialItemCount: categoriesForTitles[currentTabIndex].length,
              itemBuilder: (context, itemIndex, animation) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    // Calculate the item height based on the constraints

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          side: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CommonScreen(
                                  title: titles[currentTabIndex],
                                  categories: [
                                    categoriesForTitles[currentTabIndex]
                                        [itemIndex]
                                  ], // Wrap it in a list
                                  mainFolder: mainFolder,
                                ),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(16.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  margin: const EdgeInsets.all(7.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        itemImages[
                                            categoriesForTitles[currentTabIndex]
                                                [itemIndex]]!,
                                      ),
                                      fit: BoxFit.contain,
                                    ),
                                    border: Border.all(
                                      color: Colors.black26,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        categoriesForTitles[currentTabIndex]
                                            [itemIndex],
                                        style: GoogleFonts.vollkorn(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.double_arrow,
                                  color: Colors.blueGrey,
                                ),
                                const SizedBox(width: 10),
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
        ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<String> categoriesForTitles;

  CustomSearchDelegate({required this.categoriesForTitles});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Perform the search and display results
    final suggestionList = categoriesForTitles
        .where(
            (category) => category.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index]),
          onTap: () {
            close(context, suggestionList[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show suggestions as the user types
    final suggestionList = categoriesForTitles
        .where(
            (category) => category.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index]),
          onTap: () {
            close(context, suggestionList[index]);
          },
        );
      },
    );
  }
}
