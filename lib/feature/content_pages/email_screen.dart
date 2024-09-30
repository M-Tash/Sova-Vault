import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emails'),
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
            )
          ],
        ),
      ),
    );
  }
}
