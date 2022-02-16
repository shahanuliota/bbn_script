import 'dart:convert';
import 'dart:io';

import 'package:bbn_script/utils.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

import 'model/food_model.dart';

extension StringFi on List {
  String get stringFi => const JsonEncoder.withIndent('  ').convert(this);
}

List<FoodItem> foolItemList = <FoodItem>[];

String getNumberOrExpression(String str) {
  List<String> list = str.split('');

  String num1 = '';
  String num2 = '';
  String exp = '';
  int i = 0;
  for (i = 0; i < list.length; i++) {
    if (list[i] == ' ') continue;
    if (isNumber(list[i])) {
      num1 += list[i];
    } else {
      if (num1.isNotEmpty) {
        //    i--;
        break;
      }
    }
  }

  for (i; i < list.length; i++) {
    if (list[i] == ' ') continue;
    if (<String>['x', '/'].contains(list[i])) {
      exp = list[i];
      i++;
      break;
    }
  }

  if (exp.isNotEmpty) {
    for (i; i < list.length; i++) {
      if (list[i] == ' ') continue;
      if (isNumber(list[i])) {
        num2 += list[i];
      } else {
        break;
      }
    }
  }
  if (num2.isEmpty) {
    exp = '';
  }

  return num1 + exp + num2;
}

void main() {
//   String test = '1 packet of roasted chickpeas/fav-va beans';
//
//   test = getNumberOrExpression(test);
// //  test = test.replaceAll(RegExp(r'[^0-9]'), '');
//   print(test);
//
//   return;
  var file = 'lib/Final Meal Ideas.xlsx';
  var bytes = File(file).readAsBytesSync();
  var decoder = SpreadsheetDecoder.decodeBytes(bytes, update: true);
  // print(decoder.tables.keys);
  List<String> tablesList = decoder.tables.keys.toList();

  // print(tablesList.length);
  //
  // for (String table in tablesList) {
  //   print(table);
  // }
  // return;
  //String table = 'Dinner';
  for (String table in tablesList) {
    int rowLen = decoder.tables[table]!.rows.length;

    Map<int, List<String>> xlColMap = <int, List<String>>{};
    for (int i = 0; i < rowLen; i++) {
      List row = decoder.tables[table]!.rows[i];
      for (int j = 0; j < row.length; j++) {
        if (row[j] != null) {
          if (xlColMap[j] == null) {
            xlColMap[j] = [];
          }
          if(!row[j].toString().contains('Blocks')) {
            xlColMap[j]!.add(row[j]);
          }

        }
      }
    }

    List<int> mapKey = xlColMap.keys.toList();

    for (int i = 0; i < mapKey.length; i++) {
      for (String element in xlColMap[mapKey[i]]!) {
        parseData(element, table);
      }
    }

    File enJsonFile = File('bin/${table.toLowerCase()}_food.json');
    enJsonFile.writeAsStringSync(foolItemList.stringFi);
    foolItemList.clear();
  }
}
/// used unit names
List<String> unitList = [
  "g ",
  "g",
  "cup",
  "cups",
  "slice",
  "slices",
  "tbsp",
  "Tbsp",
  "packet",
  'tsp',
  'tub',
  'L',
  'l',
  'packet',
];

/// special case handle
Map<String, String> blockNumber = {
  '¼': '0.25',
  '½': '0.50',
  'I ': '1 ',
  'L ': ' L ',
  'g ': ' g ',
  'G ': ' G ',
  'tsp ': ' tsp ',
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
    String num = getNumberOrExpression(str);

    String unitName = 'NA';
    String itemName = '';
    for (int i = 1; i < strList.length; i++) {
      if (unitList.contains(strList[i].toLowerCase())) {
        unitName = strList[i];
      } else {
        itemName += strList[i] + ' ';
      }
    }

    try {
      FoodItem food = FoodItem(
        fullData: str,
        sheetName: sheetName,
        itemName: itemName,
        quantity: convertStringToNum(num),
        title: currentFood,
        unitName: unitName,
      );
      foolItemList.add(food);
    } catch (e, t) {
      print(e);
      print(t);
      print("error String : => $str");
    }
  } catch (e) {
    print("error convert -----> e");
  }
}
