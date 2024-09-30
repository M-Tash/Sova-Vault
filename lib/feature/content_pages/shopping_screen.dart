import 'package:flutter/material.dart';

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
    'assets/images/shopping/Ubuy.jpg',
    'assets/images/shopping/AliExpress.jpg',
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping'),
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
