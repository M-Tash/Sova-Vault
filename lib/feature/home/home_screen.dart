import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/theme/my_theme.dart';
import '../../config/utils/custom_Item.dart';
import '../content_pages/email_screen.dart';
import '../content_pages/gaming_screen.dart';
import '../content_pages/shopping_screen.dart';
import '../content_pages/social_media_screen.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home-screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image;
  final List<String> itemsImages = [
    'assets/images/gaming.png',
    'assets/images/social.png',
    'assets/images/email.png',
    'assets/images/shopping.png',
  ];
  final List<String> itemsTag = [
    'Gaming',
    'Social Media',
    'Emails',
    'Shopping',
  ];

  final List<String> route = [
    GamingScreen.routeName,
    SocialScreen.routeName,
    EmailScreen.routeName,
    ShoppingScreen.routeName,
  ];

  // Pick an image and save it locally
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/${pickedFile.name}';
      final savedImage = await File(pickedFile.path).copy(imagePath);

      // Save the image path in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image', savedImage.path);

      setState(() {
        _image = savedImage;
      });
    }
  }

  // Load the image if it exists
  Future<void> _loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('profile_image');

    if (imagePath != null) {
      final imageFile = File(imagePath);

      // Check if the image still exists
      if (await imageFile.exists()) {
        setState(() {
          _image = imageFile;
        });
      } else {
        // If the file doesn't exist, reset to default
        prefs.remove('profile_image');
        setState(() {
          _image = null;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadImage(); // Load image when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size and orientation
    final Size screenSize = MediaQuery.of(context).size;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    // Adjust avatar radius based on screen size
    final double avatarRadius =
        isPortrait ? screenSize.width * 0.2 : screenSize.width * 0.12;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontSize: isPortrait ? 28 : 30),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, SettingsScreen.routeName),
              child: Image.asset(
                'assets/icons/settings.png',
                width: screenSize.width * 0.08,
                height: screenSize.height * 0.08,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: Stack(
                        children: [
                          RepaintBoundary(
                            child: CircleAvatar(
                              backgroundColor: MyTheme.primaryColor,
                              radius: avatarRadius,
                              backgroundImage: _image != null
                                  ? FileImage(_image!)
                                  : const AssetImage(
                                          'assets/images/profile.png')
                                      as ImageProvider,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 15,
                            child: GestureDetector(
                              onTap: _pickImage,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: MyTheme.primaryColor,
                                  child: const Icon(Icons.add,
                                      color: Colors.blue, size: 12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: isPortrait
                  ? screenSize.height * 0.48
                  : screenSize.height * 0.4,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                // Prevent scrolling
                itemCount: itemsTag.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  // Adjust number of columns based on orientation
                  crossAxisCount: isPortrait ? 2 : 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, route[index]);
                    },
                    child: RepaintBoundary(
                      child: CustomItem(
                        tagText: itemsTag[index],
                        imagePath: itemsImages[index],
                        style: Theme.of(context).textTheme.titleLarge,
                        height: isPortrait ? 130 : 110, // Adjust height
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: isPortrait ? 10 : 5,
          ),
        ],
      ),
    );
  }
}
