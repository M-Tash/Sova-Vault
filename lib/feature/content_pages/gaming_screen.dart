import 'package:flutter/material.dart';

import '../../config/theme/my_theme.dart';
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
    // Get the screen size and orientation
    final Size screenSize = MediaQuery.of(context).size;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gaming'),
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
                  // Adjust number of columns dynamically based on orientation
                  crossAxisCount: isPortrait ? 2 : 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: isPortrait
                      ? 1.0
                      : 1.0, // Adjust aspect ratio for responsiveness
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
                            : 100, // Adjust height for portrait/landscape
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
