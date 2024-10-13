// add_account_cubit.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sova_vault/feature/data_screen/add_account_cubit/states.dart';

class AddAccountCubit extends Cubit<AddAccountState> {
  final FlutterSecureStorage storage;
  final String serviceName;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isObscure = true;

  AddAccountCubit({required this.storage, required this.serviceName})
      : super(AddAccountInitial());

  void toggleObscure() {
    isObscure = !isObscure;
    emit(AddAccountObscureToggled(isObscure));
  }

  Future<void> addAccount() async {
    if (formKey.currentState?.validate() ?? false) {
      emit(AddAccountLoading());

      try {
        String key = '${serviceName}_${DateTime.now().millisecondsSinceEpoch}';

        await storage.write(key: '$key-email', value: emailController.text);
        await storage.write(
            key: '$key-password', value: passwordController.text);

        await _saveKey(key);

        emit(AddAccountSuccess());
      } catch (e) {
        emit(AddAccountError('Failed to add account: $e'));
      }
    }
  }

  Future<void> _saveKey(String key) async {
    List<String> keys = (await storage.read(key: 'keys'))?.split(',') ?? [];
    keys.add(key);
    await storage.write(key: 'keys', value: keys.join(','));
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
