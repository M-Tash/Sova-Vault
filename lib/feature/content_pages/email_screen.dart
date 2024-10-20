import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/theme/my_theme.dart';
import '../../core/utils/custom_Item.dart';
import '../data_screen/service_screen.dart';
import 'add_item_screen.dart';
import 'category_cubit/category_cubit.dart';
import 'category_cubit/states.dart';

class EmailScreen extends StatelessWidget {
  static String routeName = 'email-screen';

  const EmailScreen({super.key});

  void _navigateAndAddItem(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddItemScreen()),
    );

    if (result != null) {
      context.read<CategoriesCubit>().addItem(
            CategoryType.email,
            result['image'],
            result['title'],
          );
    }
  }

  void _removeItemWithConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: MyTheme.primaryColor,
          title: const Text('Warning'),
          content: Text(
            'The Item you added will be removed. Are you sure you want to delete this item?',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          actions: [
            TextButton(
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(
                'OK',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                context
                    .read<CategoriesCubit>()
                    .removeItem(CategoryType.email, index);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Load items when the widget is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoriesCubit>().loadItems(CategoryType.email);
    });

    final Size screenSize = MediaQuery.of(context).size;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Emails'),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            size:
                isPortrait ? screenSize.width * 0.06 : screenSize.width * 0.04,
            color: MyTheme.whiteColor,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              size: isPortrait
                  ? screenSize.width * 0.08
                  : screenSize.width * 0.05,
              color: MyTheme.whiteColor,
            ),
            onPressed: () => _navigateAndAddItem(context),
          ),
        ],
      ),
      body: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(child: Text(state.error!));
          }

          final items = state.items[CategoryType.email] ?? [];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: GridView.builder(
                    itemCount: items.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isPortrait ? 2 : 4,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: isPortrait ? 1.0 : 1.0,
                    ),
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                ServiceScreen.routeName,
                                arguments: {
                                  'serviceName': items[index].itemTag,
                                },
                              );
                            },
                            child: RepaintBoundary(
                              child: CustomItem(
                                tagText: items[index].itemTag,
                                imagePath: items[index].itemImage,
                                style: Theme.of(context).textTheme.titleSmall,
                                height: isPortrait ? 120 : 100,
                              ),
                            ),
                          ),
                          if (items[index].isUserAdded)
                            Positioned(
                              top: -10,
                              right: -10,
                              child: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: isPortrait
                                      ? screenSize.width * 0.06
                                      : screenSize.width * 0.04,
                                ),
                                onPressed: () =>
                                    _removeItemWithConfirmation(context, index),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}