import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/theme/my_theme.dart';
import '../../config/utils/custom_Item.dart';
import '../../model/item_model.dart';
import '../data_screen/accounts_screen.dart';
import 'add_item_screen.dart'; // Import the AddItemScreen

class SocialScreen extends StatefulWidget {
  static String routeName = 'social-screen';

  SocialScreen({super.key});

  @override
  _SocialScreenState createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  List<Item> items = [];

  @override
  void initState() {
    super.initState();
    _loadItems(); // Load saved items when the screen initializes
  }

  // Load saved items from SharedPreferences
  void _loadItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedItems = prefs.getString('socialItems');

    if (savedItems != null) {
      List<dynamic> decodedItems = jsonDecode(savedItems);
      setState(() {
        items = decodedItems
            .map((item) =>
                Item.fromJson(item)) // Use fromJson for deserialization
            .toList();
      });
    } else {
      // Initialize with default items if nothing is saved
      setState(() {
        items = [
          Item(
              itemImage: 'assets/images/social/facebook.png',
              itemTag: 'Facebook'),
          Item(
              itemImage: 'assets/images/social/instagram.png',
              itemTag: 'Instagram'),
          Item(
              itemImage: 'assets/images/social/twitter.png',
              itemTag: 'X(Twitter)'),
          Item(itemImage: 'assets/images/social/tiktok.png', itemTag: 'TikTok'),
          Item(
              itemImage: 'assets/images/social/snapchat.png',
              itemTag: 'Snapchat'),
          Item(
              itemImage: 'assets/images/social/linkedin.png',
              itemTag: 'LinkedIn'),
          Item(itemImage: 'assets/images/social/reddit.png', itemTag: 'Reddit'),
          Item(
              itemImage: 'assets/images/social/discord.png',
              itemTag: 'Discord'),
          Item(
              itemImage: 'assets/images/social/Twitch.jpeg', itemTag: 'Twitch'),
          Item(itemImage: 'assets/images/social/kick.jpeg', itemTag: 'Kick'),
          Item(
              itemImage: 'assets/images/social/Threads.jpeg',
              itemTag: 'Threads'),
          Item(
              itemImage: 'assets/images/social/Pinterest.jpeg',
              itemTag: 'Pinterest'),
        ];
      });
    }
  }

  // Save items to SharedPreferences
  void _saveItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> itemList =
        items.map((item) => item.toJson()).toList();
    prefs.setString('socialItems', jsonEncode(itemList));
  }

  // Navigate to the AddItemScreen
  void _navigateAndAddItem() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddItemScreen()),
    );

    if (result != null) {
      setState(() {
        items.add(Item(
          itemImage: result['image'],
          itemTag: result['title'],
          isUserAdded: true, // Mark the item as user-added
        ));
      });
      _saveItems(); // Save the updated list after adding
    }
  }

  // Remove a user-added item with confirmation dialog
  void _removeItemWithConfirmation(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: MyTheme.primaryColor,
          title: const Text('Warning'),
          content: Text(
            'The Item you added will be removed. Are you sure you want to delete this item?',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          actions: [
            TextButton(
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Close the dialog without deleting
              },
            ),
            TextButton(
              child: Text(
                'OK',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                setState(() {
                  items.removeAt(index); // Remove the item
                });
                _saveItems(); // Save the updated list after removal
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Media'),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            size:
                isPortrait ? screenSize.width * 0.06 : screenSize.width * 0.04,
            color: MyTheme.whiteColor,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              size: isPortrait
                  ? screenSize.width * 0.08
                  : screenSize.width * 0.05,
              color: MyTheme.whiteColor,
            ),
            onPressed: _navigateAndAddItem, // Navigate to add item screen
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: items.length, // Use the length of the items list
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isPortrait ? 2 : 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 5,
                  childAspectRatio: isPortrait ? 1.0 : 1.0,
                ),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ServiceScreen.routeName,
                            arguments: {
                              'serviceName': items[index].itemTag,
                              // Use itemTag
                            },
                          );
                        },
                        child: RepaintBoundary(
                          child: CustomItem(
                            tagText: items[index].itemTag, // Use itemTag
                            imagePath: items[index].itemImage, // Use itemImage
                            style: Theme.of(context).textTheme.titleSmall,
                            height: isPortrait ? 120 : 100,
                          ),
                        ),
                      ),
                      if (items[index]
                          .isUserAdded) // Only show delete for user-added items
                        Positioned(
                          top: -10,
                          right: -10,
                          child: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: isPortrait
                                  ? screenSize.width * 0.06
                                  : screenSize.width * 0.04,
                            ),
                            onPressed: () => _removeItemWithConfirmation(
                                index), // Show the confirmation dialog
                          ),
                        ),
                    ],
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
