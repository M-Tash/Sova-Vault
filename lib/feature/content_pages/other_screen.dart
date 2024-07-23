import 'package:flutter/material.dart';

import '../../config/utils/custom_Item.dart';

class OtherScreen extends StatelessWidget {
  static String routeName = 'social-screen';
  List<String> itemsImages = [
    'assets/images/gaming.jpeg',
    'assets/images/social.png',
    'assets/images/bank.png',
    'assets/images/other.png',
    'assets/images/gaming.jpeg',
    'assets/images/social.png',
    'assets/images/bank.png',
    'assets/images/other.png',
  ];
  List<String> itemsTag = [
    'Facebook',
    'Instagram',
    'X(Twitter)',
    'TikTok',
    'Snapchat',
    'LInkedIn',
    'Reddit',
    'Discord',
  ];

  OtherScreen({super.key});

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
