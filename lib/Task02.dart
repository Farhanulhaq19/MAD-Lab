import 'dart:io';

void main() {
  stdout.write("Enter your name: ");
  String name = stdin.readLineSync()!;

  stdout.write("Enter your age: ");
  int age = int.parse(stdin.readLineSync()!);

  if (age < 18) {
    print("Sorry $name, you are not eligible to register.");
    return;
  }

  stdout.write("How many numbers do you want to enter? ");
  int n = int.parse(stdin.readLineSync()!);

  List<int> numbers = [];
  for (int i = 0; i < n; i++) {
    stdout.write("Enter number ${i + 1}: ");
    numbers.add(int.parse(stdin.readLineSync()!));
  }

  int sumEven = 0, sumOdd = 0;
  int largest = numbers[0], smallest = numbers[0];

  for (int num in numbers) {
    if (num % 2 == 0) {
      sumEven += num;
    } else {
      sumOdd += num;
    }
    if (num > largest) largest = num;
    if (num < smallest) smallest = num;
  }

  print("\nResults:");
  print("Sum of Even Numbers: $sumEven");
  print("Sum of Odd Numbers: $sumOdd");
  print("Largest Number: $largest");
  print("Smallest Number: $smallest");
}