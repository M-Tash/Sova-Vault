import 'package:flutter/material.dart';

import '../../config/theme/my_theme.dart';
import '../../config/utils/custom_Item.dart';
import '../data_screen/accounts_screen.dart';

class EmailScreen extends StatelessWidget {
  static String routeName = 'email-screen';

  final List<String> itemsImages = [
    'assets/images/email/Gmail.png',
    'assets/images/email/iCloud.jpeg',
    'assets/images/email/Microsoft.jpeg',
    'assets/images/email/Outlook.jpeg',
    'assets/images/email/ProtonMail.jpeg',
    'assets/images/email/Yahoo.jpeg',
    'assets/images/email/Yandex.jpeg',
    'assets/images/email/mail_ru.jpeg',
  ];

  final List<String> itemsTag = [
    'Gmail',
    'iCloud',
    'Microsoft',
    'Outlook',
    'ProtonMail',
    'Yahoo',
    'Yandex',
    'mail.ru',
  ];

  EmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size and orientation
    final Size screenSize = MediaQuery.of(context).size;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Emails'),
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
                  mainAxisSpacing: 20,
                  childAspectRatio: isPortrait
                      ? 1.0
                      : 1.0, // Adjust aspect ratio based on orientation
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
