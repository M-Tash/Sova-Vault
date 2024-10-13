import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import 'package:sova_vault/feature/content_pages/cubit/states.dart';

class AddItemCubit extends Cubit<AddItemState> {
  AddItemCubit() : super(AddItemInitial());

  final TextEditingController titleController = TextEditingController();
  File? _image;

  Future<void> pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // Get the app's documents directory to save the image
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = '${directory.path}/${pickedFile.name}';
        final savedImage = await File(pickedFile.path).copy(imagePath);

        _image = savedImage;
        emit(AddItemImageSelected(image: _image!));
      }
    } catch (e) {
      emit(AddItemError('Failed to pick image: ${e.toString()}'));
    }
  }

  Future<void> submitItem() async {
    String title =
        titleController.text.isEmpty ? 'Temp Name' : titleController.text;
    String imagePath = _image != null ? _image!.path : 'assets/images/temp.png';

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? savedItems = prefs.getString('addedItems');
      List<dynamic> itemsList =
          savedItems != null ? jsonDecode(savedItems) : [];

      itemsList.add({'title': title, 'image': imagePath});
      await prefs.setString('addedItems', jsonEncode(itemsList));

      emit(AddItemSubmitted(title: title, imagePath: imagePath));
    } catch (e) {
      emit(AddItemError('Failed to save item: ${e.toString()}'));
    }
  }
}
