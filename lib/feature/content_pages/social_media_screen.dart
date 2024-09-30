import 'package:flutter/material.dart';

import '../../config/theme/my_theme.dart';
import '../../config/utils/custom_Item.dart';
import '../data_screen/accounts_screen.dart';

class SocialScreen extends StatelessWidget {
  static String routeName = 'social-screen';

  final List<String> itemsImages = [
    'assets/images/social/facebook.png',
    'assets/images/social/instagram.png',
    'assets/images/social/twitter.png',
    'assets/images/social/tiktok.png',
    'assets/images/social/snapchat.png',
    'assets/images/social/linkedin.png',
    'assets/images/social/reddit.png',
    'assets/images/social/discord.png',
    'assets/images/social/Twitch.jpeg',
    'assets/images/social/kick.jpeg',
    'assets/images/social/Threads.jpeg',
    'assets/images/social/Pinterest.jpeg',
  ];

  final List<String> itemsTag = [
    'Facebook',
    'Instagram',
    'X(Twitter)',
    'TikTok',
    'Snapchat',
    'LinkedIn',
    'Reddit',
    'Discord',
    'Twitch',
    'Kick',
    'Threads',
    'Pinterest',
  ];

  SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size and orientation
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
              size: isPortrait
                  ? screenSize.width * 0.06
                  : screenSize.width * 0.04, // Adjust the size dynamically
              color: MyTheme.whiteColor,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: itemsTag.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  // Adjust the number of columns based on orientation
                  crossAxisCount: isPortrait ? 2 : 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 5,
                  childAspectRatio: isPortrait
                      ? 1.0
                      : 1.0, // Adjust aspect ratio for portrait/landscape
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ServiceScreen.routeName,
                        arguments: {
                          'serviceName': itemsTag[index],
                        },
                      );
                    },
                    child: RepaintBoundary(
                      child: CustomItem(
                        tagText: itemsTag[index],
                        imagePath: itemsImages[index],
                        style: Theme.of(context).textTheme.titleSmall,
                        height: isPortrait
                            ? 120
                            : 100, // Adjust height based on orientation
                      ),
                    ),
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
