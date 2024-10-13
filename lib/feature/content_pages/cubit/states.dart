import 'dart:io';

abstract class AddItemState {}

class AddItemInitial extends AddItemState {}

class AddItemImageSelected extends AddItemState {
  final File image;

  AddItemImageSelected({required this.image});
}

class AddItemSubmitted extends AddItemState {
  final String title;
  final String imagePath;

  AddItemSubmitted({required this.title, required this.imagePath});
}

class AddItemError extends AddItemState {
  final String message;

  AddItemError(this.message);
}
