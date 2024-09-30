import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../config/theme/my_theme.dart';
import '../../config/utils/custom_form_field.dart';

class AddAccountScreen extends StatefulWidget {
  final String serviceName;

  AddAccountScreen({required this.serviceName});

  @override
  State<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  bool isObscure = true;
  var formKey = GlobalKey<FormState>();

  Future<void> _saveKey(String key) async {
    List<String>? keys = (await storage.read(key: 'keys'))?.split(',') ?? [];
    keys.add(key);
    await storage.write(key: 'keys', value: keys.join(','));
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size and orientation for responsive design
    final Size screenSize = MediaQuery.of(context).size;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios,
              size: isPortrait ? 20 : 24, // Adjust the size dynamically
              color: MyTheme.whiteColor,
            )),
        title: Text('Add ${widget.serviceName} Account'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              // Wrap content with SingleChildScrollView to avoid overflow
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.05, // Responsive padding
              ),
              child: Column(
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Email Or Username',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: isPortrait
                                        ? 16
                                        : 18, // Responsive font size
                                  ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          maxLength: 50,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please Enter Your Email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Password',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: isPortrait
                                        ? 16
                                        : 18, // Responsive font size
                                  ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextFormField(
                          controller: passwordController,
                          isObscure: isObscure,
                          maxLength: 50,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please Enter Your Password';
                            }
                            return null;
                          },
                          suffixIcon: GestureDetector(
                            child: isObscure
                                ? Icon(Icons.visibility_off_outlined,
                                    size: 20, color: MyTheme.whiteColor)
                                : Icon(Icons.visibility_outlined,
                                    size: 20, color: MyTheme.whiteColor),
                            onTap: () {
                              setState(() {
                                isObscure = !isObscure;
                              });
                            },
                          ),
                          isSuffixIcon: true,
                        ),
                        const SizedBox(height: 20), // Added spacing
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.05,
              vertical: screenSize.height * 0.02, // Responsive padding
            ), // Adjust padding
            child: GestureDetector(
              onTap: () async {
                if (formKey.currentState?.validate() ?? false) {
                  String email = emailController.text;
                  String password = passwordController.text;
                  String key =
                      '${widget.serviceName}_${DateTime.now().millisecondsSinceEpoch}';

                  await storage.write(key: '$key-email', value: email);
                  await storage.write(key: '$key-password', value: password);

                  // Save the key in secure storage
                  await _saveKey(key);

                  if (mounted) {
                    // Check if widget is still mounted
                    Navigator.pop(context); // Go back to previous screen
                  }
                }
              },
              child: Container(
                height: 48,
                width: double.infinity, // Full width for better responsiveness
                decoration: BoxDecoration(
                  color: MyTheme.secondaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add_circle_outline,
                        color: Colors.white, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      'Save Account',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize:
                                isPortrait ? 16 : 20, // Responsive font size
                          ),
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
