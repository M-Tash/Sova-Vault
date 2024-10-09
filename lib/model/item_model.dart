class Item {
  final String itemImage;
  final String itemTag;
  final bool
      isUserAdded; // New field to indicate if the item was added by the user

  Item({
    required this.itemImage,
    required this.itemTag,
    this.isUserAdded = false, // Default to false for default items
  });

  // Convert Item to a Map for SharedPreferences
  Map<String, dynamic> toJson() => {
        'itemImage': itemImage,
        'itemTag': itemTag,
        'isUserAdded': isUserAdded,
      };

  // Convert a Map to an Item object
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      itemImage: json['itemImage'],
      itemTag: json['itemTag'],
      isUserAdded:
          json['isUserAdded'] ?? false, // Default to false if not present
    );
  }
}
