String convertStringToNum(String num) {
  List<String> numbers = num.split('/').toList();

  if (numbers.length == 2) {
    try {
      double num1 = double.parse(numbers[0]);
      double num2 = double.parse(numbers[1]);
      return (num1 / num2).toString();
    } catch (e, t) {
      print(e);
      print(t);
      return num;
    }
  }

  return num;
}