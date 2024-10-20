import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/theme/my_theme.dart';
import '../../core/utils/custom_form_field.dart';
import '../../core/utils/validators.dart';
import 'cubit/add_item_cubit.dart';
import 'cubit/states.dart';

class AddItemScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddItemCubit(),
      child: BlocConsumer<AddItemCubit, AddItemState>(
        listener: (context, state) {
          if (state is AddItemSubmitted) {
            Navigator.pop(
                context, {'title': state.title, 'image': state.imagePath});
          } else if (state is AddItemError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<AddItemCubit>();
          final Size screenSize = MediaQuery.of(context).size;
          final bool isPortrait =
              MediaQuery.of(context).orientation == Orientation.portrait;

          return GestureDetector(
            onTap: () {
              FocusScope.of(context)
                  .unfocus(); // Dismiss keyboard when tapping outside
            },
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Add New Item'),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: isPortrait
                        ? screenSize.width * 0.06
                        : screenSize.width * 0.04,
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: isPortrait
                                      ? 20
                                      : 24, // Responsive font size
                                ),
                          ),
                          const SizedBox(height: 5),
                          Form(
                            key: _formKey,
                            child: CustomTextFormField(
                              controller: cubit.titleController,
                              keyboardType: TextInputType.text,
                              maxLength: 50,
                              validator: Validators.titleValidator,
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () => cubit.pickImage(),
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
                                  Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.white,
                                    size: isPortrait ? 20 : 23,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Pick Image',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontSize: isPortrait
                                              ? 18
                                              : 23, // Responsive font size
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          if (state is AddItemImageSelected)
                            Image.file(state.image,
                                height: 200) // Display the selected image
                          else
                            const Text('No image selected'),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          cubit.submitItem();
                        }
                      },
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
                            Icon(
                              Icons.add_circle_outline,
                              color: Colors.white,
                              size: isPortrait ? 20 : 23,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Add Item',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontSize: isPortrait
                                        ? 18
                                        : 23, // Responsive font size
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
    );
  }
}