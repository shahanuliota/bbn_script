import 'dart:convert';
import 'dart:io';

import 'package:bbn_script/utils.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

import 'model/food_model.dart';

extension StringFi on List {
  String get stringFi => const JsonEncoder.withIndent('  ').convert(this);
}

List<FoodItem> foolItemList = <FoodItem>[];

void main() {
  var file = 'lib/Final Meal Ideas.xlsx';
  var bytes = File(file).readAsBytesSync();
  var decoder = SpreadsheetDecoder.decodeBytes(bytes, update: true);
  print(decoder.tables.keys);

  String table = 'Breakfast';

  int rowLen = decoder.tables[table]!.rows.length;

  Map<int, List<String>> xlColMap = <int, List<String>>{};
  for (int i = 1; i < rowLen; i++) {
    List row = decoder.tables[table]!.rows[i];
    for (int j = 0; j < row.length; j++) {
      if (row[j] != null) {
        if (xlColMap[j] == null) {
          xlColMap[j] = [];
        }
        xlColMap[j]!.add(row[j]);
      }
    }
  }


  for(int i=0;i<xlColMap.length;i++){
    for (String element in xlColMap[i]!) {
      parseData(element, table);
    }
  }


  File enJsonFile = File('bin/${table.toLowerCase()}_food.json');
  enJsonFile.writeAsStringSync(foolItemList.stringFi);
}

List<String> unitList = [
  "g ",
  "cup",
  "cups",
  "slice",
  "tbsp",
  "Tbsp",
  "packet",
  'tsp',
  'tub',
];
Map<String, String> blockNumber = {
  '¼': '0.25',
  '½': '0.50',
  'I ': '1 ',
};

String currentFood = '';

void parseData(String data, sheetName) {
  String value = data;
  blockNumber.forEach(
    (key, v) {
      value = value.replaceAll(key, v);
    },
  );

  String aStr = value.replaceAll(RegExp(r'[^0-9]'), '');

  if (aStr.isEmpty) {
    currentFood = value;
    print(value);
  } else {
    convertStrToData(value, sheetName);
  }
}

void convertStrToData(String str, sheetName) {
  try {
    List<String> strList = str.split(' ');
    String num = strList.first;

    String unitName = 'NA';
    String itemName = '';
    for (int i = 1; i < strList.length; i++) {
      if (unitList.contains(strList[i].toLowerCase())) {
        unitName = strList[i];
      } else {
        itemName += strList[i] + ' ';
      }
    }

    FoodItem food = FoodItem(
      sheetName: sheetName,
      itemName: itemName,
      quantity: convertStringToNum(num),
      title: currentFood,
      unitName: unitName,
    );
    foolItemList.add(food);
  } catch (e) {
    print("error convert -----> e");
  }
}
