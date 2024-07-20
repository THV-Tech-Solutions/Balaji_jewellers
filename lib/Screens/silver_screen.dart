//SILVERSCREEN FINAL

//final_silver_screen

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:jewellery/Screens/common_screen.dart';

class SilverScreen extends StatefulWidget {
  const SilverScreen({Key? key}) : super(key: key);

  @override
  State<SilverScreen> createState() => _SilverScreenState();
}

class _SilverScreenState extends State<SilverScreen> {
  final String mainFolder = 'Silver';
  int currentTabIndex = 0;
  final ScrollController _scrollController = ScrollController();
  String selectedCategory = '';
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final List<String> titles = [
    'Silver Articles',
    'Sterling Silver',
    'Temple Items'
  ];
  final List<List<String>> categoriesForTitles = [
    [
      'Plates',
      'Glasses',
      'Stand Kundhulu',
      'Pancha Patra',
      'Vodharani',
      'AshtaLakshmi Chombu',
      'Plain Chambu',
      'Vigraharalu',
      'Simhasanalu',
      'Short Kundhulu',
      'Agarabathi Stand',
      'Pula Butta',
      'Powder Box',
      'Pattilu',
      'Kadiyalu',
      'Molathallu',
      'Gantalu',
      'Harathi Stands',
      'Pens',
      'Jugs',
      'Bindhalu',
      'Chains',
      'Flowers',
      'Photo Frames',
      'Seta Gopuram',
      'Kiritalu',
      'Bowls',
      'Kunkama Barani',
      'Thamalapakulu',
      'Arati Chetlu',
      'Kobbari Chetlu',
      'Dinner Sets',
      'Eyes', /* ... Add your items here ... */
    ],
    [
      'Gents Rings',
      'Necllace',
      'Chains',
      'Harams',
      'Bangles',
      'Chowker Lockets',
      'Chain Lockets',
      'Vadranam',
      'Aravanki',
      'Bracelets',
      'Kadiyalu',
      'Nallapursalu',
      'DD Balls Chains',
      'Black Beats',
      'Jukalu',
      'Buttalu',
      'Diddulu',
      'Chandh Bali',
      'Saniya Rings',
      'Matilu',
      'Champaswaralu',
      'Chevi Chutlu',
      'Chandra Haralu',
      'Jukalu',
      'Buttalu',
      'Diddulu',
      'Chandh Bali',
      'Saniya Rings',
      'Matilu',
      'Champaswaralu',
      'Chevi Chutlu',
      'Champaswaralu',
      'Chevi Chutlu',
      /* ... Add your items here ... */
    ],
    [
      'Kireetalu',
      'Hasthalu',
      'Vakshasthalam',
      'Kaallu',
      'Nagum Podagalu',
      'paadhalu',
      'kallu',
      'Makarathoranalu',
      'Petalu',
      'Simhasanalu',
      'Kireetalu',
      'Hasthalu',
      'Vakshasthalam',
      'Kaallu',
      'Nagum Podagalu',
      'paadhalu',
      'kallu',
      'Makarathoranalu',
      'Petalu',
      'Simhasanalu',
      'Kireetalu',
      'Hasthalu',
      'Vakshasthalam',
      'Kaallu',
      'Nagum Podagalu',
      'paadhalu',
      'kallu',
      'Makarathoranalu',
      'Petalu',
      'Simhasanalu',
      'Makarathoranalu',
      'Petalu',
      'Simhasanalu', /* ... Add your items here ... */
    ],
  ];

  final List<List<String>> itemImages = [
    [
      'SilverArticles1.png',
      'SilverArticles2.png',
      'SilverArticles3.png',
      'SilverArticles4.png',
      'SilverArticles5.png',
      'SilverArticles6.png',
      'SilverArticles7.png',
      'SilverArticles8.png',
      'SilverArticles9.png',
      'SilverArticles10.png',
      'SilverArticles11.png',
      'SilverArticles12.png',
      'SilverArticles13.png',
      'SilverArticles14.png',
      'SilverArticles15.png',
      'SilverArticles16.png',
      'SilverArticles17.png',
      'SilverArticles18.png',
      'SilverArticles19.png',
      'SilverArticles20.png',
      'SilverArticles21.png',
      'SilverArticles22.png',
      'SilverArticles23.png',
      'SilverArticles24.png',
      'SilverArticles25.png',
      'SilverArticles26.png',
      'SilverArticles27.png',
      'SilverArticles28.png',
      'SilverArticles29.png',
      'SilverArticles30.png',
      'SilverArticles31.png',
      'SilverArticles32.png',
      'SilverArticles33.png',
      /* ... Add your image paths here ... */
    ],
    [
      'SterlingSilver34.png',
      'SterlingSilver35.png',
      'SterlingSilver36.png',
      'SterlingSilver37.png',
      'SterlingSilver38.png',
      'SterlingSilver39.png',
      'SterlingSilver40.png',
      'SterlingSilver41.png',
      'SterlingSilver42.png',
      'SterlingSilver43.png',
      'SterlingSilver44.png',
      'SterlingSilver45.png',
      'SterlingSilver46.png',
      'SterlingSilver47.png',
      'SterlingSilver48.png',
      'SterlingSilver49.png',
      'SterlingSilver50.png',
      'SterlingSilver51.png',
      'SterlingSilver52.png',
      'SterlingSilver53.png',
      'SterlingSilver54.png',
      'SterlingSilver55.png',
      'SterlingSilver56.png',
      'SterlingSilver57.png',
      'SterlingSilver49.png',
      'SterlingSilver50.png',
      'SterlingSilver51.png',
      'SterlingSilver52.png',
      'SterlingSilver53.png',
      'SterlingSilver54.png',
      'SterlingSilver55.png',
      'SterlingSilver56.png',
      'SterlingSilver57.png',
      'SterlingSilver56.png',
      'SterlingSilver57.png',
      /* ... Add your image paths here ... */
    ],
    [
      'TempleItems58.png',
      'TempleItems59.png',
      'TempleItems60.png',
      'TempleItems61.png',
      'TempleItems62.png',
      'TempleItems63.png',
      'TempleItems64.png',
      'TempleItems65.png',
      'TempleItems66.png',
      'TempleItems67.png',
      'TempleItems58.png',
      'TempleItems59.png',
      'TempleItems60.png',
      'TempleItems61.png',
      'TempleItems62.png',
      'TempleItems63.png',
      'TempleItems64.png',
      'TempleItems65.png',
      'TempleItems66.png',
      'TempleItems67.png',
      'TempleItems58.png',
      'TempleItems59.png',
      'TempleItems60.png',
      'TempleItems61.png',
      'TempleItems62.png',
      'TempleItems63.png',
      'TempleItems64.png',
      'TempleItems65.png',
      'TempleItems66.png',
      'TempleItems67.png',
      'TempleItems65.png',
      'TempleItems66.png',
      'TempleItems67.png',

      /* ... Add your image paths here ... */
    ],
  ];

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
                    // padding: const EdgeInsets.symmetric(horizontal: 8),
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.02),

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
                          side: BorderSide(color: Colors.black, width: 1.0),
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
                                      image: AssetImage(
                                        'assets/images/${itemImages[currentTabIndex][itemIndex]}',
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
                                  color: Colors.grey,
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
