import '../../../model/account_model.dart';

abstract class ServiceScreenState {}

class ServiceScreenInitial extends ServiceScreenState {}

class ServiceScreenLoading extends ServiceScreenState {}

class ServiceScreenLoaded extends ServiceScreenState {
  final List<Account> accounts;
  final List<bool> isObscureList;

  ServiceScreenLoaded(this.accounts, this.isObscureList);
}

class ServiceScreenError extends ServiceScreenState {
  final String message;

  ServiceScreenError(this.message);
}
