import 'package:flutter/material.dart';

import '../../config/theme/my_theme.dart';
import '../../config/utils/custom_Item.dart';
import '../data_screen/accounts_screen.dart';

class ShoppingScreen extends StatelessWidget {
  static String routeName = 'shopping-screen';

  final List<String> itemsImages = [
    'assets/images/shopping/Amazon.jpeg',
    'assets/images/shopping/noon.jpeg',
    'assets/images/shopping/Jumia.jpeg',
    'assets/images/shopping/Raya.png',
    'assets/images/shopping/talabat.jpg',
    'assets/images/shopping/Waffarha.jpg',
    'assets/images/shopping/Elmenus.png',
    'assets/images/shopping/Breadfast.jpg',
    'assets/images/shopping/Dubizzle.jpg',
    'assets/images/shopping/Mrsool.jpg',
    'assets/images/shopping/Ubuy.png',
    'assets/images/shopping/AliExpress.png',
  ];

  final List<String> itemsTag = [
    'Amazon',
    'Noon',
    'Jumia',
    'Raya Shop',
    'Talabat',
    'Waffarha',
    'Elmenus',
    'Breadfast',
    'Dubizzle',
    'Mrsool',
    'Ubuy',
    'AliExpress',
  ];

  ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size and orientation
    final Size screenSize = MediaQuery.of(context).size;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping'),
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
                  // Adjust the number of columns based on screen orientation
                  crossAxisCount: isPortrait ? 2 : 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
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
