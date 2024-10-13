// service_screen_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sova_vault/feature/data_screen/service_cubit/states.dart';
import '../../../model/account_model.dart';

// Cubit
class ServiceScreenCubit extends Cubit<ServiceScreenState> {
  final FlutterSecureStorage storage;
  final String serviceName;

  ServiceScreenCubit({required this.storage, required this.serviceName})
      : super(ServiceScreenInitial());

  List<String> keys = [];

  Future<void> loadAccounts() async {
    emit(ServiceScreenLoading());

    try {
      List<Account> loadedAccounts = [];
      keys = (await storage.read(key: 'keys'))?.split(',') ?? [];
      keys = keys.where((key) => key.isNotEmpty).toList();

      for (String key in keys) {
        if (key.startsWith(serviceName)) {
          String? email = await storage.read(key: '$key-email');
          String? password = await storage.read(key: '$key-password');

          if (email != null && password != null) {
            loadedAccounts.add(Account(
              service: serviceName,
              email: email,
              password: password,
            ));
          }
        }
      }

      List<bool> isObscureList =
          List<bool>.generate(loadedAccounts.length, (index) => true);
      emit(ServiceScreenLoaded(loadedAccounts, isObscureList));
    } catch (e) {
      emit(ServiceScreenError('Failed to load accounts: $e'));
    }
  }

  Future<void> deleteAccount(int index) async {
    if (state is ServiceScreenLoaded) {
      try {
        final currentState = state as ServiceScreenLoaded;
        if (index >= 0 && index < currentState.accounts.length) {
          String key = keys[index];
          if (key.isEmpty) return;

          await storage.delete(key: '$key-email');
          await storage.delete(key: '$key-password');

          keys.removeAt(index);
          await storage.write(key: 'keys', value: keys.join(','));

          List<Account> updatedAccounts = List.from(currentState.accounts)
            ..removeAt(index);
          List<bool> updatedIsObscureList =
              List.from(currentState.isObscureList)..removeAt(index);

          emit(ServiceScreenLoaded(updatedAccounts, updatedIsObscureList));
        }
      } catch (e) {
        emit(ServiceScreenError('Failed to delete account: $e'));
      }
    }
  }

  void togglePasswordVisibility(int index) {
    if (state is ServiceScreenLoaded) {
      final currentState = state as ServiceScreenLoaded;
      List<bool> updatedIsObscureList = List.from(currentState.isObscureList);
      updatedIsObscureList[index] = !updatedIsObscureList[index];
      emit(ServiceScreenLoaded(currentState.accounts, updatedIsObscureList));
    }
  }
}
