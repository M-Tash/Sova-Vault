import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sova_vault/feature/content_pages/gaming_screen.dart';
import 'package:sova_vault/feature/content_pages/social_media_screen.dart';

import '../../config/theme/my_theme.dart';
import '../../config/utils/custom_Item.dart';
import '../../config/utils/custom_bottom_navigation_bar.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = 'home-screen';

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image;
  List<String> itemsImages = [
    'assets/images/gaming.png',
    'assets/images/social.png',
    'assets/images/email.png',
    'assets/images/other.png',
  ];
  List<String> itemsTag = [
    'Gaming',
    'Social Media',
    'Emails',
    'Other',
  ];

  List<String> route = [
    GamingScreen.routeName,
    SocialScreen.routeName,
    'Banking',
    'Other',
  ];

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "DashBoard",
          style: Theme.of(context).textTheme.titleLarge,
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
                  width: 28,
                  height: 28,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: MyTheme.primaryColor,
                      radius: 80,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : const AssetImage('assets/images/profile.png')
                              as ImageProvider,
                      child: _image = null,
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
                                  width: 1, color: Colors.redAccent)),
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
              const SizedBox(height: 70),
              SizedBox(
                height: 400,
                child: GridView.builder(
                  itemCount: itemsTag.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, route[index]);
                        },
                        child: CustomItem(
                          tagText: itemsTag[index],
                          imagePath: itemsImages[index],
                          style: Theme.of(context).textTheme.titleLarge,
                          height: 135,
                        ));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
