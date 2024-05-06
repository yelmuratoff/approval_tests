<div align="center">
<p align="center">
    <a href="https://github.com/K1yoshiSho/approval_tests" align="center">
        <img src="https://github.com/K1yoshiSho/packages_assets/blob/main/assets/approval_tests.png?raw=true" width="400px">
    </a>
</p>
</div>

<h2 align="center"> Approval Tests implementation in Dart 🚀 </h2>

## 📖 About

I want to write, and am writing an implementation of a great tool like **[Approval Tests](https://approvaltests.com/)** in Dart. If anyone wants to help, please **[text](https://t.me/yelmuratoff)** me. 🙏

<!-- At the moment the package is **in development** and <u>not ready</u> to use. 🚧 -->

## 📦 Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  approval_tests: ^0.0.7-dev
```

## 📚 How to use

### Comparators

You can use different comparators to compare files. The default is `CommandLineComparator` which compares files in the console.

To use `IDEComparator` you just need to add it to `options`:
```dart
 options: const Options(
   comparator: IDEComparator(
      ide: ComparatorIDE.visualStudioCode,
   ),
 ),
```

But before you add an `IDEComparator` you need to do the initial customization:

- **Visual Studio Code**
  - For this method to work, you need to have Visual Studio Code installed on your machine.
  - And you need to have the `code` command available in your terminal.
  - To enable the `code` command, press `Cmd + Shift + P` and type `Shell Command: Install 'code' command in PATH`.

- **IntelliJ IDEA**
   - For this method to work, you need to have IntelliJ IDEA installed on your machine.
   - And you need to have the `idea` command available in your terminal.
   - To enable the `idea` command, you need to create the command-line launcher using `Tools - Create Command-line Launcher` in IntelliJ IDEA.

- **Android Studio**
   - For this method to work, you need to have Android Studio installed on your machine.
   - And you need to have the `studio` command available in your terminal.
   - To enable the `studio` command, you need to create the command-line launcher using `Tools - Create Command-line Launcher` in Android Studio.

## 📝 Examples

### JSON example

```dart
import 'package:approval_tests/approval_dart.dart';
import 'package:test/test.dart';

void main() {
  group('Approval Tests for Complex Objects', () {
    test('test complex JSON object', () {
      var complexObject = {
        'name': 'JsonTest',
        'features': ['Testing', 'JSON'],
        'version': 0.1,
      };
      ApprovalTests.verifyAsJson(complexObject);
    });
  });
}
```

### Gilded Rose

```dart
void main() {
  // Define all test cases
  const allTestCases = [
    ["foo", "Aged Brie", "Backstage passes to a TAFKAL80ETC concert", "Sulfuras, Hand of Ragnaros"],
    [-1, 0, 5, 6, 10, 11],
    [-1, 0, 1, 49, 50]
  ];

  group('Approval Tests for Gilded Rose', () {
    test('should verify all combinations of test cases', () {
      // Perform the verification for all combinations
      ApprovalTests.verifyAllCombinations(
        inputs: allTestCases,
        options: const Options(
          comparator: IDEComparator(
            ide: ComparatorIDE.visualStudioCode,
          ),
        ),
        processor: processItemCombination,
        file: "example/gilded_rose/test/approved_results/test",
      );
    });
  });
}

// Function to process each combination and generate output for verification
String processItemCombination(Iterable<List<dynamic>> combinations) {
  final receivedBuffer = StringBuffer();

  for (var combination in combinations) {
    // Extract data from the current combination
    String itemName = combination[0];
    int sellIn = combination[1];
    int quality = combination[2];

    // Create an Item object representing the current combination
    Item testItem = Item(itemName, sellIn: sellIn, quality: quality);

    // Passing testItem to the application
    GildedRose app = GildedRose(items: [testItem]);

    // Updating quality of testItem
    app.updateQuality();

    // Adding the updated item to expectedItems
    receivedBuffer.writeln(testItem.toString());
  }

  // Return a string representation of the updated item
  return receivedBuffer.toString();
}
```

## 🤝 Contributing

<br>
<span style="font-size: 0.9em"> Show some 💙 and <a href="https://github.com/K1yoshiSho/approval_tests_dart.git">star the repo</a> to support the project! 🙌</span>


<br><br><br>
<p align="center">
  <a href="https://pub.dev/packages/approval_tests"><img src="https://img.shields.io/pub/v/approval_tests.svg" alt="Pub"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT"></a>
  <a href="https://github.com/K1yoshiSho/approval_tests_dart"><img src="https://hits.dwyl.com/K1yoshiSho/approval_tests_dart.svg?style=flat" alt="Repository views"></a>
  <a href="https://github.com/K1yoshiSho/approval_tests"><img src="https://img.shields.io/github/stars/K1yoshiSho/approval_tests_dart?style=social" alt="Pub"></a>
</p>
<p align="center">
  <a href="https://pub.dev/packages/approval_tests/score"><img src="https://img.shields.io/pub/likes/approval_tests?logo=flutter" alt="Pub likes"></a>
  <a href="https://pub.dev/packages/approval_tests/score"><img src="https://img.shields.io/pub/popularity/approval_tests?logo=flutter" alt="Pub popularity"></a>
  <a href="https://pub.dev/packages/approval_tests/score"><img src="https://img.shields.io/pub/points/approval_tests?logo=flutter" alt="Pub points"></a>
</p>

<br>

<br>
<div align="center" >
  <p>Thanks to all contributors of this package</p>
  <a href="https://github.com/K1yoshiSho/approval_tests_dart/graphs/contributors">
    <img src="https://contrib.rocks/image?repo=K1yoshiSho/approval_tests_dart" />
  </a>
</div>
<br>