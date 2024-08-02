import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../config/theme/my_theme.dart';
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

  @override
  void initState() {
    super.initState();
    loadAccounts();
  }

  Future<void> loadAccounts() async {
    List<Account> loadedAccounts = [];
    Map<String, String> allData = await storage.readAll();

    for (String key in allData.keys) {
      if (key.startsWith(widget.serviceName) && key.endsWith('-email')) {
        String serviceKey =
            key.substring(0, key.length - 6); // Removing '-email'
        String? email = allData[key];
        String? password = allData['$serviceKey-password'];

        if (email != null && password != null) {
          loadedAccounts.add(Account(
              service: widget.serviceName, email: email, password: password));
        }
      }
    }

    setState(() {
      accounts = loadedAccounts;
      isObscureList = List<bool>.filled(
          accounts.length, true); // Initialize the visibility list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.serviceName),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: accounts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: SelectableText(accounts[index].email),
                  subtitle: isObscureList[index]
                      ? Text('********')
                      : SelectableText(accounts[index].password),
                  trailing: GestureDetector(
                    child: isObscureList[index]
                        ? Icon(Icons.visibility_off_outlined,
                            size: 18, color: MyTheme.whiteColor)
                        : Icon(Icons.visibility_outlined,
                            size: 18, color: MyTheme.whiteColor),
                    onTap: () {
                      setState(() {
                        isObscureList[index] = !isObscureList[index];
                      });
                    },
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
                height: 48,
                width: 358,
                decoration: BoxDecoration(
                    color: MyTheme.secondaryColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                      size: 19,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Add Account',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
