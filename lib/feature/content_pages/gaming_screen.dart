import 'package:flutter/material.dart';

import '../../config/utils/custom_Item.dart';
import '../data_screen/accounts_screen.dart';

class GamingScreen extends StatelessWidget {
  static String routeName = 'gaming-screen';

  final List<String> itemsImages = [
    'assets/images/gaming/steam.png',
    'assets/images/gaming/epic_games.png',
    'assets/images/gaming/psn.png',
    'assets/images/gaming/xbox.png',
    'assets/images/gaming/Switch.jpeg',
    'assets/images/gaming/riot_games.png',
    'assets/images/gaming/ea_play.png',
    'assets/images/gaming/ubisoft.png',
    'assets/images/gaming/blizzard.png',
    'assets/images/gaming/GOG.jpeg',
  ];

  final List<String> itemsTag = [
    'Steam',
    'Epic Games',
    'PSN',
    'Xbox',
    'Nintendo Switch',
    'Riot Games',
    'EA Play',
    'Ubisoft Connect',
    'Blizzard',
    'GOG Galaxy',
  ];

  GamingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gaming'),
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
                  mainAxisSpacing: 0,
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
