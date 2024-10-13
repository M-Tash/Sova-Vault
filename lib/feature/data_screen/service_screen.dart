import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sova_vault/feature/data_screen/service_cubit/service_cubit.dart';
import 'package:sova_vault/feature/data_screen/service_cubit/states.dart';

import '../../config/theme/my_theme.dart';
import '../../config/utils/custom_snack_bar.dart';
import '../../model/account_model.dart';
import 'add_account.dart';

class ServiceScreen extends StatelessWidget {
  static String routeName = 'accounts-screen';
  final String serviceName;

  ServiceScreen({required this.serviceName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceScreenCubit(
        storage: FlutterSecureStorage(),
        serviceName: serviceName,
      )..loadAccounts(),
      child: ServiceScreenContent(serviceName: serviceName),
    );
  }
}

class ServiceScreenContent extends StatelessWidget {
  final String serviceName;

  ServiceScreenContent({required this.serviceName});

  void copyBoth(BuildContext context, Account account) {
    String combinedText = "${account.email}:${account.password}";
    Clipboard.setData(ClipboardData(text: combinedText));
    CustomSnackBar.showCustomSnackBar(
      context,
      'Email/Username and Password copied to clipboard',
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          serviceName,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: isPortrait ? 22 : 26,
              ),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            size:
                isPortrait ? screenSize.width * 0.06 : screenSize.width * 0.04,
            color: MyTheme.whiteColor,
          ),
        ),
      ),
      body: BlocBuilder<ServiceScreenCubit, ServiceScreenState>(
        builder: (context, state) {
          if (state is ServiceScreenLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ServiceScreenLoaded) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.02,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.accounts.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: SelectableText(
                            state.accounts[index].email,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: isPortrait ? 18 : 24,
                                ),
                          ),
                          subtitle: state.isObscureList[index]
                              ? Text(
                                  '********',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                        fontSize: isPortrait ? 16 : 22,
                                      ),
                                )
                              : SelectableText(
                                  state.accounts[index].password,
                                  style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                        fontSize: isPortrait ? 16 : 22,
                                      ),
                                ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                child: state.isObscureList[index]
                                    ? Icon(Icons.visibility_off_outlined,
                                        size: isPortrait
                                            ? screenSize.width * 0.06
                                            : screenSize.width * 0.05,
                                        color: MyTheme.whiteColor)
                                    : Icon(Icons.visibility_outlined,
                                        size: isPortrait
                                            ? screenSize.width * 0.06
                                            : screenSize.width * 0.05,
                                        color: MyTheme.whiteColor),
                                onTap: () {
                                  context
                                      .read<ServiceScreenCubit>()
                                      .togglePasswordVisibility(index);
                                },
                              ),
                              const SizedBox(width: 15),
                              GestureDetector(
                                child: Icon(
                                  Icons.copy,
                                  size: isPortrait
                                      ? screenSize.width * 0.06
                                      : screenSize.width * 0.05,
                                  color: MyTheme.whiteColor,
                                ),
                                onTap: () =>
                                    copyBoth(context, state.accounts[index]),
                              ),
                              const SizedBox(width: 15),
                              GestureDetector(
                                child: Icon(
                                  Icons.delete,
                                  size: isPortrait
                                      ? screenSize.width * 0.06
                                      : screenSize.width * 0.05,
                                  color: MyTheme.whiteColor,
                                ),
                                onTap: () {
                                  context
                                      .read<ServiceScreenCubit>()
                                      .deleteAccount(index);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    child: GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AddAccountScreen(serviceName: serviceName),
                          ),
                        );
                        context.read<ServiceScreenCubit>().loadAccounts();
                      },
                      child: Container(
                        height: isPortrait ? 48 : 55,
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
                              'Add Account',
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
            );
          } else if (state is ServiceScreenError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}