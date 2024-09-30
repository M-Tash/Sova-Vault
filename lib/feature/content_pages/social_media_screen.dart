import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Media'),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 18,
          ),
        ),
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 5,
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
                        height: 120,
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
