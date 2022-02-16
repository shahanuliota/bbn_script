// import 'dart:convert';
// import 'dart:io';
//
// import 'package:bbn_script/bbn_script.dart' as bbn_script;
// import 'package:bbn_script/model/food_model.dart';
// import 'package:excel/excel.dart';
//
// extension StringFi on List {
//   String get stringFi => const JsonEncoder.withIndent('  ').convert(this);
// }
//
// List<FoodItem> foolItemList = <FoodItem>[];
//
// void main() {
//   var file = "lib/Final Meal Ideas.xlsx";
//   var bytes = File(file).readAsBytesSync();
//   var excel = Excel.decodeBytes(bytes);
//   //
//   // for (var table in excel.tables.keys) {
//   //   print(table); //sheet Name
//   //   print(excel.tables[table]?.maxCols);
//   //   print(excel.tables[table]?.maxRows);
//   //   // for (var row in excel.tables[table]!.rows) {
//   //   //   print("$row");
//   //   // }
//   // }
//
//   String xlKey = 'Breakfast';
//    print(excel.tables.keys);
//   //print(excel.tables[xlKey]?.spannedItems);
//
//   int collLen = excel.tables[xlKey]!.maxCols;
//
//   for (int i = 0; i < 1; i++) {
//     for (var row in excel.tables[xlKey]!.rows) {
//       print(row.map((e) => "${e?.value?.toString()} ").toString());
//       // Data? data = row.first;
//       // if (data != null) {
//       //   print(data.value);
//       //   // parseData(data);
//       // }
//     }
//   }
//
//   File enJsonFile = File('lib/food.json');
//   enJsonFile.writeAsStringSync(foolItemList.stringFi);
// }
// //
// // List<String> unitList = [
// //   "g ",
// //   "cup",
// //   "cups",
// //   "slice",
// //   "tbsp",
// //   "Tbsp",
// //   "packet",
// //   'tsp',
// // ];
// // Map<String, String> blockNumber = {
// //   '¼': '0.25',
// //   '½': '0.50',
// // };
// //
// // String currentFood = '';
// //
// // void parseData(Data data) {
// //   String? value = data.value;
// //   if (value != null) {
// //     // blockNumber.forEach(
// //     //   (key, v) {
// //     //     value = value!.replaceAll(key, v);
// //     //   },
// //     // );
// //
// //     String aStr = value!.replaceAll(RegExp(r'[^0-9]'), '');
// //
// //     if (aStr.isEmpty) {
// //       currentFood = value!;
// //       print(value);
// //     } else {
// //       convertStrToData(value!, data.sheetName);
// //     }
// //   }
// // }
// //
// // void convertStrToData(String str, sheetName) {
// //   try {
// //     List<String> strList = str.split(' ');
// //     String num = strList.first;
// //
// //     String unitName = 'NA';
// //     String itemName = '';
// //     for (int i = 1; i < strList.length; i++) {
// //       if (unitList.contains(strList[i].toLowerCase())) {
// //         unitName = strList[i];
// //       } else {
// //         itemName += strList[i] + ' ';
// //       }
// //     }
// //
// //     FoodItem food = FoodItem(
// //       sheetName: sheetName,
// //       itemName: itemName,
// //       quantity: convertStringToNum(num),
// //       title: currentFood,
// //       unitName: unitName,
// //     );
// //     foolItemList.add(food);
// //   } catch (e) {
// //     print("error convert -----> e");
// //   }
// // }
//
//
//
//
