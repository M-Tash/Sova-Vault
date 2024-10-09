import 'dart:io'; // For working with file paths

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Image picker package
import 'package:path_provider/path_provider.dart';

import '../../config/theme/my_theme.dart';
import '../../config/utils/custom_form_field.dart'; // Path provider for saving images

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController titleController = TextEditingController();
  File? _image; // Store the selected image file

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Get the app's documents directory to save the image
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/${pickedFile.name}';
      final savedImage = await File(pickedFile.path).copy(imagePath);

      setState(() {
        _image = savedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size:
                isPortrait ? screenSize.width * 0.06 : screenSize.width * 0.04,
            color: MyTheme.whiteColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Title',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize:
                              isPortrait ? 20 : 24, // Responsive font size
                        ),
                  ),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    controller: titleController,
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 50,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please Enter Your Email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 48,
                      width: double.infinity,
                      // Full width for better responsiveness
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
                            'Pick Image',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: isPortrait
                                      ? 16
                                      : 20, // Responsive font size
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _image != null
                      ? Image.file(_image!,
                          height: 200) // Display the selected image
                      : const Text('No image selected'),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                // Default title and image path if none provided
                String title = titleController.text.isEmpty
                    ? 'Temp Name'
                    : titleController.text;
                String image =
                    _image != null ? _image!.path : 'assets/images/temp.png';

                // Return the values to the previous screen
                Navigator.pop(context, {'title': title, 'image': image});
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
                      'Add Item',
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
