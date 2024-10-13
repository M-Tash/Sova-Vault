import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sova_vault/feature/home/cubit/states.dart';
import '../../content_pages/email_screen.dart';
import '../../content_pages/gaming_screen.dart';
import '../../content_pages/shopping_screen.dart';
import '../../content_pages/social_media_screen.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    loadInitialData();
  }

  final List<String> itemsImages = [
    'assets/images/gaming.png',
    'assets/images/social.png',
    'assets/images/email.png',
    'assets/images/shopping.png',
  ];

  final List<String> itemsTag = [
    'Gaming',
    'Social Media',
    'Emails',
    'Shopping',
  ];

  final List<String> routes = [
    GamingScreen.routeName,
    SocialScreen.routeName,
    EmailScreen.routeName,
    ShoppingScreen.routeName,
  ];

  File? _profileImage;

  Future<void> loadInitialData() async {
    emit(HomeLoading());
    try {
      await _loadImage();
      await _preloadData();
      emit(HomeLoaded(
        profileImage: _profileImage,
        itemsImages: itemsImages,
        itemsTag: itemsTag,
        routes: routes,
      ));
    } catch (e) {
      emit(HomeError('Failed to load initial data: ${e.toString()}'));
    }
  }

  Future<void> pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = '${directory.path}/${pickedFile.name}';
        final savedImage = await File(pickedFile.path).copy(imagePath);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('profile_image', savedImage.path);

        _profileImage = savedImage;
        emit(HomeLoaded(
          profileImage: _profileImage,
          itemsImages: itemsImages,
          itemsTag: itemsTag,
          routes: routes,
        ));
      }
    } catch (e) {
      emit(HomeError('Failed to pick image: ${e.toString()}'));
    }
  }

  Future<void> _loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('profile_image');

    if (imagePath != null) {
      final imageFile = File(imagePath);
      if (await imageFile.exists()) {
        _profileImage = imageFile;
      } else {
        prefs.remove('profile_image');
        _profileImage = null;
      }
    }
  }

  Future<void> _preloadData() async {
    // Preload data for other screens here
    // For example:
    // await EmailScreen.preloadData();
    // await GamingScreen.preloadData();
    // This is just a placeholder. You'll need to implement these methods in your respective screen classes.
  }
}
