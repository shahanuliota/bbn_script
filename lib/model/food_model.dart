class FoodItem {
  String title;
  String itemName;
  String sheetName;
  String quantity;
  String unitName;

  FoodItem({
    required this.sheetName,
    required this.title,
    required this.itemName,
    required this.quantity,
    required this.unitName,
  });

  Map<String, dynamic> toJson() => {
    "foodName": title,
    "itemName": itemName,
    "sheetName": sheetName,
    "quantity": quantity,
    "unitName": unitName,
  };
}