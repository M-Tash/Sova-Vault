import 'package:flutter/material.dart';

import '../../config/utils/custom_Item.dart';
import '../data_screen/accounts_screen.dart';

class GamingScreen extends StatelessWidget {
  static String routeName = 'gaming-screen';
  List<String> itemsImages = [
    'assets/images/steam.png',
    'assets/images/epic_games.png',
    'assets/images/psn.png',
    'assets/images/xbox.png',
    'assets/images/riot_games.png',
    'assets/images/ea_play.png',
    'assets/images/ubisoft.png',
    'assets/images/blizzard.png',
  ];
  List<String> itemsTag = [
    'Steam',
    'Epic Games',
    'PSN',
    'Xbox',
    'Riot Games',
    'EA Play',
    'Ubisoft Connect',
    'Blizzard',
  ];

  GamingScreen({super.key});

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
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ServiceScreen.routeName,
                          arguments: {
                            'serviceName': itemsTag[index],
                          },
                        );
                      },
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
