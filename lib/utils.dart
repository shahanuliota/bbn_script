String convertStringToNum(String num) {
  bool multiplay = false;
  bool divide = false;
  List<String> numbers = num.split(' ').toList();
  if (num.contains('x')) {
    multiplay = true;
    numbers = num.split('x').toList();
  } else if (num.contains('/')) {
    divide = true;
    numbers = num.split('/').toList();
  }

  if (numbers.length == 2) {
    try {
      double num1 = double.parse(numbers[0]);
      double num2 = double.parse(numbers[1]);
      if (divide == true) {
        return (num1 / num2).toString();
      }
      if (multiplay == true) {
        return (num1 * num2).toString();
      }
      return (num1 * num2).toString();
    } catch (e, t) {
      // print(e);
      // print(t);
      rethrow;
      // return num;
    }
  } else {
    try {
      double num1 = double.parse(num);
      return num1.toString();

      // throw Exception('string is not a valid number :=> $num');
    } catch (e, t) {
      // print(e);
      // print(t);
      rethrow;
    }
  }

  //return num;
}

bool isNumber(String item) {
  return '0123456789.'.split('').contains(item);
}
