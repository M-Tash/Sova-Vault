import 'package:flutter/material.dart';

import '../../config/utils/custom_Item.dart';

class SocialScreen extends StatelessWidget {
  static String routeName = 'social-screen';
  List<String> itemsImages = [
    'assets/images/facebook.png',
    'assets/images/instagram.png',
    'assets/images/twitter.png',
    'assets/images/tiktok.png',
    'assets/images/snapchat.png',
    'assets/images/linkedin.png',
    'assets/images/reddit.png',
    'assets/images/discord.png',
  ];
  List<String> itemsTag = [
    'Facebook',
    'Instagram',
    'X(Twitter)',
    'TikTok',
    'Snapchat',
    'LinkedIn',
    'Reddit',
    'Discord',
  ];

  SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    mainAxisSpacing: 5),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {},
                      child: CustomItem(
                        tagText: itemsTag[index],
                        imagePath: itemsImages[index],
                        style: Theme.of(context).textTheme.titleSmall,
                        height: 120,
                      ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
