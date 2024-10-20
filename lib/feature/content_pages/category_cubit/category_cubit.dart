import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sova_vault/feature/content_pages/category_cubit/states.dart';

import '../../../model/item_model.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit()
      : super(CategoriesState(items: {
          CategoryType.email: [],
          CategoryType.gaming: [],
          CategoryType.shopping: [],
          CategoryType.social: [],
        }));

  // Default items for each category
  final Map<CategoryType, List<Item>> _defaultItems = {
    CategoryType.email: [
      Item(itemImage: 'assets/images/email/Gmail.png', itemTag: 'Gmail'),
      Item(itemImage: 'assets/images/email/iCloud.jpeg', itemTag: 'iCloud'),
      Item(
          itemImage: 'assets/images/email/Microsoft.jpeg',
          itemTag: 'Microsoft'),
      Item(itemImage: 'assets/images/email/Outlook.jpeg', itemTag: 'Outlook'),
      Item(
          itemImage: 'assets/images/email/ProtonMail.jpeg',
          itemTag: 'ProtonMail'),
      Item(itemImage: 'assets/images/email/Yahoo.jpeg', itemTag: 'Yahoo'),
      Item(itemImage: 'assets/images/email/Yandex.jpeg', itemTag: 'Yandex'),
      Item(itemImage: 'assets/images/email/mail_ru.jpeg', itemTag: 'mail.ru'),
    ],
    CategoryType.gaming: [
      Item(itemImage: 'assets/images/gaming/steam.png', itemTag: 'Steam'),
      Item(
          itemImage: 'assets/images/gaming/epic_games.png',
          itemTag: 'Epic Games'),
      Item(itemImage: 'assets/images/gaming/psn.png', itemTag: 'PSN'),
      Item(itemImage: 'assets/images/gaming/xbox.png', itemTag: 'Xbox'),
      Item(
          itemImage: 'assets/images/gaming/Switch.jpeg',
          itemTag: 'Nintendo Switch'),
      Item(
          itemImage: 'assets/images/gaming/riot_games.png',
          itemTag: 'Riot Games'),
      Item(itemImage: 'assets/images/gaming/ea_play.png', itemTag: 'EA Play'),
      Item(
          itemImage: 'assets/images/gaming/ubisoft.png',
          itemTag: 'Ubisoft Connect'),
      Item(itemImage: 'assets/images/gaming/blizzard.png', itemTag: 'Blizzard'),
      Item(itemImage: 'assets/images/gaming/GOG.jpeg', itemTag: 'GOG Galaxy'),
    ],
    CategoryType.shopping: [
      Item(itemImage: 'assets/images/shopping/Amazon.jpeg', itemTag: 'Amazon'),
      Item(itemImage: 'assets/images/shopping/noon.jpeg', itemTag: 'Noon'),
      Item(itemImage: 'assets/images/shopping/Jumia.jpeg', itemTag: 'Jumia'),
      Item(itemImage: 'assets/images/shopping/Raya.png', itemTag: 'Raya Shop'),
      Item(itemImage: 'assets/images/shopping/talabat.jpg', itemTag: 'Talabat'),
      Item(
          itemImage: 'assets/images/shopping/Waffarha.jpg',
          itemTag: 'Waffarha'),
      Item(itemImage: 'assets/images/shopping/Elmenus.png', itemTag: 'Elmenus'),
      Item(
          itemImage: 'assets/images/shopping/Breadfast.jpg',
          itemTag: 'Breadfast'),
      Item(
          itemImage: 'assets/images/shopping/Dubizzle.jpg',
          itemTag: 'Dubizzle'),
      Item(itemImage: 'assets/images/shopping/Mrsool.jpg', itemTag: 'Mrsool'),
      Item(itemImage: 'assets/images/shopping/Ubuy.png', itemTag: 'Ubuy'),
      Item(
          itemImage: 'assets/images/shopping/AliExpress.png',
          itemTag: 'AliExpress'),
    ],
    CategoryType.social: [
      Item(itemImage: 'assets/images/social/facebook.png', itemTag: 'Facebook'),
      Item(
          itemImage: 'assets/images/social/instagram.png',
          itemTag: 'Instagram'),
      Item(
          itemImage: 'assets/images/social/twitter.png', itemTag: 'X(Twitter)'),
      Item(itemImage: 'assets/images/social/tiktok.png', itemTag: 'TikTok'),
      Item(itemImage: 'assets/images/social/snapchat.png', itemTag: 'Snapchat'),
      Item(itemImage: 'assets/images/social/linkedin.png', itemTag: 'LinkedIn'),
      Item(itemImage: 'assets/images/social/reddit.png', itemTag: 'Reddit'),
      Item(itemImage: 'assets/images/social/discord.png', itemTag: 'Discord'),
      Item(itemImage: 'assets/images/social/Twitch.jpeg', itemTag: 'Twitch'),
      Item(itemImage: 'assets/images/social/kick.jpeg', itemTag: 'Kick'),
      Item(itemImage: 'assets/images/social/Threads.jpeg', itemTag: 'Threads'),
      Item(
          itemImage: 'assets/images/social/Pinterest.jpeg',
          itemTag: 'Pinterest'),
    ],
  };

  String _getPrefsKey(CategoryType type) {
    switch (type) {
      case CategoryType.email:
        return 'emailItems';
      case CategoryType.gaming:
        return 'gamingItems';
      case CategoryType.shopping:
        return 'shoppingItems';
      case CategoryType.social:
        return 'socialItems';
    }
  }

  Future<void> loadItems(CategoryType type) async {
    emit(state.copyWith(isLoading: true));
    try {
      final prefs = await SharedPreferences.getInstance();
      final String prefsKey = _getPrefsKey(type);
      final String? savedItems = prefs.getString(prefsKey);

      List<Item> categoryItems;
      if (savedItems != null) {
        final List<dynamic> decodedItems = jsonDecode(savedItems);
        categoryItems =
            decodedItems.map((item) => Item.fromJson(item)).toList();
      } else {
        categoryItems = _defaultItems[type] ?? [];
      }

      final Map<CategoryType, List<Item>> updatedItems = Map.from(state.items);
      updatedItems[type] = categoryItems;

      emit(state.copyWith(
        items: updatedItems,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to load items: $e',
        isLoading: false,
      ));
    }
  }

  Future<void> addItem(
      CategoryType type, String imagePath, String title) async {
    try {
      final newItem = Item(
        itemImage: imagePath,
        itemTag: title,
        isUserAdded: true,
      );

      final updatedItems = Map<CategoryType, List<Item>>.from(state.items);
      updatedItems[type] = [...(updatedItems[type] ?? []), newItem];

      emit(state.copyWith(items: updatedItems));
      await _saveItems(type);
    } catch (e) {
      emit(state.copyWith(error: 'Failed to add item: $e'));
    }
  }

  Future<void> removeItem(CategoryType type, int index) async {
    try {
      final updatedItems = Map<CategoryType, List<Item>>.from(state.items);
      final categoryItems = List<Item>.from(updatedItems[type] ?? []);
      categoryItems.removeAt(index);
      updatedItems[type] = categoryItems;

      emit(state.copyWith(items: updatedItems));
      await _saveItems(type);
    } catch (e) {
      emit(state.copyWith(error: 'Failed to remove item: $e'));
    }
  }

  Future<void> _saveItems(CategoryType type) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String prefsKey = _getPrefsKey(type);
      final categoryItems = state.items[type] ?? [];
      final itemList = categoryItems.map((item) => item.toJson()).toList();
      await prefs.setString(prefsKey, jsonEncode(itemList));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to save items: $e'));
    }
  }
}
