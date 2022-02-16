class FoodItem {
  String title;
  String fullData;
  String itemName;
  String sheetName;
  String quantity;
  String unitName;

  FoodItem({
    required this.sheetName,
    required this.fullData,
    required this.title,
    required this.itemName,
    required this.quantity,
    required this.unitName,
  });

  Map<String, dynamic> toJson() => {
    "foodName": title.trim(),
    "fullData": fullData.trim().replaceAll('  ', ' '),
    "itemName": itemName.trim(),
    "sheetName": sheetName.trim(),
    "quantity": quantity.trim(),
    "unitName": unitName.trim(),
  };
}