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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add ${widget.serviceName} Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Email Or Username',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: 5,
              ),
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
              SizedBox(
                height: 5,
              ),
              Text(
                'Password',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: 5,
              ),
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
                          size: 18, color: MyTheme.whiteColor)
                      : Icon(Icons.visibility_outlined,
                          size: 18, color: MyTheme.whiteColor),
                  onTap: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                ),
                isSuffixIcon: true,
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  onTap: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      String email = emailController.text;
                      String password = passwordController.text;
                      String key =
                          '${widget.serviceName}_${DateTime.now().millisecondsSinceEpoch}';
                      await storage.write(key: '$key-email', value: email);
                      await storage.write(
                          key: '$key-password', value: password);

                      Navigator.pop(context);
                    }
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
                          'Save Account',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
