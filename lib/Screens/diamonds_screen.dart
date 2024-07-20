// DiamondScreen Final

//Gold_screen->Tharun->ListViewChanges 2

import 'package:flutter/material.dart';
import 'package:jewellery/Screens/common_screen.dart';

import 'package:google_fonts/google_fonts.dart';

class DiamondScreen extends StatefulWidget {
  const DiamondScreen({Key? key}) : super(key: key);

  @override
  _DiamondScreenState createState() => _DiamondScreenState();
}

class _DiamondScreenState extends State<DiamondScreen> {
  bool isCategorySelected = false;
  String selectedCategory = '';
  final TextEditingController searchController = TextEditingController();
  List<String> filteredTitles = [];
  final ScrollController _scrollController = ScrollController();
  final double itemHeight = 120.0;

  final String mainFolder = 'Diamonds';

  final List<String> titles = [
    'Ladies Rings',
    'Gents Rings',
    'Necklace',
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
  ];

  final List<List<String>> categoriesForTitles = [
    ['Stones', 'Plain'],
    ['Stones', 'Plain'],
    ['Stones', 'Plain'],
    ['Chains'],
    ['Stones', 'Plain'],
    ['Stones', 'Plain'],
    ['Stones', 'Plain'],
    ['Stones', 'Plain'],
    ['Stones', 'Plain'],
    ['Stones', 'Plain'],
    ['Gents', 'Ladies'],
    ['Gents', 'Ladies'],
    ['Short Length', 'Long Length'],
    ['DD Balls Chains'],
    ['Stones', 'Plain'],
    ['Stones', 'Plain'],
    ['Stones', 'Plain'],
    ['Stones', 'Plain'],
    ['Stones', 'Plain'],
    ['Stones', 'Plain'],
    ['Stones', 'Plain'],
    ['Stones', 'Plain'],
    ['Stones', 'Plain'],
    ['Chandra Haralu'],
  ];

  @override
  void initState() {
    super.initState();
    filteredTitles = titles; // Initialize with all categories
  }

  void filterCategories(String query) {
    setState(() {
      filteredTitles = titles
          .where((title) => title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void scrollToCategory(String category) {
    final index = filteredTitles.indexOf(category);
    if (index != -1) {
      // Scroll to the selected category
      _scrollController.animateTo(
        index * itemHeight,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300], // Change to grey[300]
      appBar: AppBar(
        backgroundColor: Colors.grey[300], // Change to grey[300]
        elevation: 0,
        title: Center(
          child: Text(
            mainFolder,
            style: GoogleFonts.rowdies(
              // Use your desired Google Font, e.g., 'lobster'
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                // Show search bar and handle search
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(titles: titles),
                ).then((selectedCategory) {
                  if (selectedCategory != null) {
                    scrollToCategory(selectedCategory);
                    // Set the selected category for animation
                    setState(() {
                      this.selectedCategory = selectedCategory;
                    });
                  }
                });
              },
            ),
          ),
        ],
      ),
      body: ListView.separated(
        controller: _scrollController,
        itemCount: filteredTitles.length,
        separatorBuilder: (context, index) => SizedBox(height: 10),
        itemBuilder: (context, index) {
          final category = filteredTitles[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: BorderSide(color: Colors.orangeAccent, width: 1.0),
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedCategory = titles[index];
                    isCategorySelected = true;
                    Future.delayed(Duration(milliseconds: 500), () {
                      setState(() {
                        isCategorySelected = false;
                      });
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommonScreen(
                          title: titles[index],
                          categories: categoriesForTitles[index],
                          mainFolder: mainFolder,
                        ),
                      ),
                    );
                  });
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
                                'assets/images/Diamond${index + 1}.png'),
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
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              titles[index],
                              style: GoogleFonts.vollkorn(
                                textStyle: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
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
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<String> titles;

  CustomSearchDelegate({required this.titles});

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
    return ListView.builder(
      itemCount: titles.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(titles[index]),
          onTap: () {
            close(context, titles[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show suggestions as the user types
    final suggestionList = query.isEmpty
        ? []
        : titles
            .where((title) => title.toLowerCase().contains(query.toLowerCase()))
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
