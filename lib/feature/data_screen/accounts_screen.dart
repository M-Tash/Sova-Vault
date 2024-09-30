import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For Clipboard functionality
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../config/theme/my_theme.dart';
import '../../config/utils/custom_snack_bar.dart';
import '../../model/account_model.dart';
import 'add_account.dart';

class ServiceScreen extends StatefulWidget {
  static String routeName = 'accounts-screen';

  final String serviceName;

  ServiceScreen({required this.serviceName});

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  List<Account> accounts = [];
  List<bool> isObscureList = [];
  List<String> keys = [];

  @override
  void initState() {
    super.initState();
    loadAccounts();
  }

  Future<void> loadAccounts() async {
    List<Account> loadedAccounts = [];
    keys = (await storage.read(key: 'keys'))?.split(',') ?? [];

    // Filter out empty keys
    keys = keys.where((key) => key.isNotEmpty).toList();

    for (String key in keys) {
      if (key.startsWith(widget.serviceName)) {
        String? email = await storage.read(key: '$key-email');
        String? password = await storage.read(key: '$key-password');

        if (email != null && password != null) {
          loadedAccounts.add(Account(
              service: widget.serviceName, email: email, password: password));
        }
      }
    }

    setState(() {
      accounts = loadedAccounts;
      isObscureList =
          List<bool>.generate(accounts.length, (index) => true, growable: true);
    });
  }

  Future<void> deleteAccount(int index) async {
    if (index >= 0 && index < accounts.length) {
      String key = keys[index];
      if (key.isEmpty) return;

      String emailKey = '$key-email';
      String passwordKey = '$key-password';

      // Delete the keys from secure storage
      await storage.delete(key: emailKey);
      await storage.delete(key: passwordKey);

      // Remove the key from the keys list
      keys.removeAt(index);

      // Update the stored keys list
      await storage.write(key: 'keys', value: keys.join(','));

      // Remove the account from the local list
      setState(() {
        accounts.removeAt(index);
        isObscureList.removeAt(index); // Remove from growable list
      });
    }
  }

  // Function to copy both email/username and password to clipboard
  void copyBoth(int index) {
    String email = accounts[index].email;
    String password = accounts[index].password;
    String combinedText =
        "$email:$password"; // Concatenate email and password with colon

    Clipboard.setData(ClipboardData(text: combinedText));

    // Show a SnackBar to notify the user
    CustomSnackBar.showCustomSnackBar(
        context, 'Email/Username and Password copied to clipboard');
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size and orientation for responsive design
    final Size screenSize = MediaQuery.of(context).size;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.serviceName,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: isPortrait
                    ? 20
                    : 24, // Adjust font size based on orientation
              ),
        ),
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
        padding: EdgeInsets.symmetric(
          horizontal:
              screenSize.width * 0.02, // Adjust padding based on screen size
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: accounts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: SelectableText(
                      accounts[index].email,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: isPortrait ? 16 : 22, // Adjust font size
                          ),
                    ),
                    subtitle: isObscureList[index]
                        ? Text(
                            '********',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  fontSize:
                                      isPortrait ? 16 : 18, // Adjust font size
                                ),
                          )
                        : SelectableText(
                            accounts[index].password,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  fontSize:
                                      isPortrait ? 16 : 18, // Adjust font size
                                ),
                          ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          child: isObscureList[index]
                              ? Icon(Icons.visibility_off_outlined,
                                  size: isPortrait
                                      ? screenSize.width * 0.05
                                      : screenSize.width * 0.04,
                                  color: MyTheme.whiteColor)
                              : Icon(Icons.visibility_outlined,
                                  size: isPortrait
                                      ? screenSize.width * 0.05
                                      : screenSize.width * 0.04,
                                  color: MyTheme.whiteColor),
                          onTap: () {
                            setState(() {
                              isObscureList[index] = !isObscureList[index];
                            });
                          },
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          child: Icon(
                            Icons.copy,
                            size: isPortrait
                                ? screenSize.width * 0.05
                                : screenSize.width * 0.04,
                            color: MyTheme.whiteColor,
                          ),
                          onTap: () =>
                              copyBoth(index), // Call copyBoth function on tap
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          child: Icon(
                            Icons.delete,
                            size: isPortrait
                                ? screenSize.width * 0.05
                                : screenSize.width * 0.04,
                            color: MyTheme.whiteColor,
                          ),
                          onTap: () async {
                            await deleteAccount(index);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              child: GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddAccountScreen(serviceName: widget.serviceName),
                    ),
                  );
                  loadAccounts(); // Reload accounts after adding a new one
                },
                child: Container(
                  height: isPortrait ? 48 : 55,
                  width: double.infinity,
                  // Full width for better responsiveness
                  decoration: BoxDecoration(
                    color: MyTheme.secondaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                        size: 19,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Add Account',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize:
                                  isPortrait ? 16 : 18, // Adjust font size
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
