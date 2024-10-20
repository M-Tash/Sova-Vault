import 'package:equatable/equatable.dart';

import '../../../model/item_model.dart';

enum CategoryType { email, gaming, shopping, social }

class CategoriesState extends Equatable {
  final Map<CategoryType, List<Item>> items;
  final bool isLoading;
  final String? error;

  const CategoriesState({
    required this.items,
    this.isLoading = false,
    this.error,
  });

  CategoriesState copyWith({
    Map<CategoryType, List<Item>>? items,
    bool? isLoading,
    String? error,
  }) {
    return CategoriesState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [items, isLoading, error];
}
