import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../config/theme/my_theme.dart';
import '../../config/utils/custom_form_field.dart';
import 'add_account_cubit/add_account_cubit.dart';
import 'add_account_cubit/states.dart';

class AddAccountScreen extends StatelessWidget {
  final String serviceName;

  AddAccountScreen({required this.serviceName});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return BlocProvider(
      create: (context) => AddAccountCubit(
        storage: FlutterSecureStorage(),
        serviceName: serviceName,
      ),
      child: Builder(
        builder: (context) => BlocConsumer<AddAccountCubit, AddAccountState>(
          listener: (context, state) {
            if (state is AddAccountSuccess) {
              Navigator.pop(context);
            } else if (state is AddAccountError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<AddAccountCubit>();
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                appBar: AppBar(
                  leading: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: isPortrait ? 20 : 24,
                      color: MyTheme.whiteColor,
                    ),
                  ),
                  title: Text('Add $serviceName Account'),
                  centerTitle: true,
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.05,
                        ),
                        child: Form(
                          key: cubit.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Email Or Username',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontSize: isPortrait ? 16 : 18,
                                    ),
                              ),
                              const SizedBox(height: 5),
                              CustomTextFormField(
                                controller: cubit.emailController,
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontSize: isPortrait ? 16 : 18,
                                    ),
                              ),
                              const SizedBox(height: 5),
                              BlocBuilder<AddAccountCubit, AddAccountState>(
                                buildWhen: (previous, current) =>
                                    current is AddAccountObscureToggled,
                                builder: (context, state) {
                                  return CustomTextFormField(
                                    controller: cubit.passwordController,
                                    isObscure: cubit.isObscure,
                                    maxLength: 50,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Please Enter Your Password';
                                      }
                                      return null;
                                    },
                                    suffixIcon: GestureDetector(
                                      onTap: cubit.toggleObscure,
                                      child: Icon(
                                        cubit.isObscure
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        size: isPortrait
                                            ? screenSize.width * 0.06
                                            : screenSize.width * 0.04,
                                        color: MyTheme.whiteColor,
                                      ),
                                    ),
                                    isSuffixIcon: true,
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.05,
                        vertical: screenSize.height * 0.02,
                      ),
                      child: GestureDetector(
                        onTap: cubit.addAccount,
                        child: Container(
                          height: 48,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: MyTheme.secondaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_circle_outline,
                                color: Colors.white,
                                size: isPortrait ? 20 : 23,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Save Account',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontSize: isPortrait ? 18 : 23,
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
          },
        ),
      ),
    );
  }
}