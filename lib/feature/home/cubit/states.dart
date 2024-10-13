import 'dart:io';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final File? profileImage;
  final List<String> itemsImages;
  final List<String> itemsTag;
  final List<String> routes;

  HomeLoaded({
    required this.profileImage,
    required this.itemsImages,
    required this.itemsTag,
    required this.routes,
  });
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
