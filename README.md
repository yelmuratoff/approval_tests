<div align="center">
<p align="center">
    <a href="https://github.com/K1yoshiSho/approval_tests" align="center">
        <img src="https://github.com/K1yoshiSho/packages_assets/blob/main/assets/approval_tests/approval_tests.png?raw=true" width="400px">
    </a>
</p>
</div>

<h2 align="center"> Approval Tests implementation in Dart 🚀 </h2>

## 📖 About

Unit testing asserts can be **difficult** to use. `Approval tests` simplify this by taking a snapshot of the results, and confirming that they have not changed.   

In normal unit testing, you say `expect(person.getAge(), 5)`. Approvals allow you to do this when the thing that you want to assert is no longer a primitive but a complex object. For example, you can say, `Approvals.verify(person)`.

I am writing an implementation of a great tool like **[Approval Tests](https://approvaltests.com/)** in Dart. If anyone wants to help, please **[text](https://t.me/yelmuratoff)** me. 🙏

<!-- At the moment the package is **in development** and <u>not ready</u> to use. 🚧 -->

## 📦 Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  approval_tests: ^0.0.8-dev
```

## 📚 How to use

### Comparators

You can use different comparators to compare files. The default is `CommandLineComparator` which compares files in the console.

<img src="https://github.com/K1yoshiSho/packages_assets/blob/main/assets/approval_tests/diff_command_line.png?raw=true" alt="CommandLineComparator img" title="ApprovalTests" style="max-width: 500px;">


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

<div style="display: flex; justify-content: center; align-items: center;">
  <img src="https://github.com/K1yoshiSho/packages_assets/blob/main/assets/approval_tests/diff_tool_vs_code.png?raw=true" alt="Visual Studio code img" style="width: 45%;margin-right: 1%;" />
  <img src="https://github.com/K1yoshiSho/packages_assets/blob/main/assets/approval_tests/diff_tool_studio.png?raw=true" alt="Android Studio img" style="width: 45%;" />
</div>


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

<img src="https://github.com/K1yoshiSho/packages_assets/blob/main/assets/approval_tests/passed.png?raw=true" alt="Passed test example" title="ApprovalTests" style="max-width: 800px;">

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

<img src="https://github.com/K1yoshiSho/packages_assets/blob/main/assets/approval_tests/doesnt_match_error.png?raw=true" alt="Passed test example" title="ApprovalTests" style="max-width: 800px;">

## ❓ Which File Artifacts to Exclude from Source Control
You must add any `approved` files to your source control system. But `received` files can change with any run and should be ignored. For Git, add this to your `.gitignore`:

```gitignore
*.received.*
```

## ✉️ For More Information
### Questions?  
Ask me on Telegram: [`@yelmuratoff`](https://t.me/yelmuratoff).   
Email: [`yelamanyelmuratov@gmail.com`](mailto:yelamanyelmuratov@gmail.com)   

### Video Tutorials
- [Getting Started with ApprovalTests.Swift](https://qualitycoding.org/approvaltests-swift-getting-started/)
- [How to Verify Objects (and Simplify TDD)](https://qualitycoding.org/approvaltests-swift-verify-objects/)
- [Verify Arrays and See Simple, Clear Diffs](https://qualitycoding.org/verify-arrays-approvaltests-swift/)
- [Write Parameterized Tests by Transforming Sequences](https://qualitycoding.org/parameterized-tests-approvaltests-swift/)
- [Wrangle Legacy Code with Combination Approvals](https://qualitycoding.org/wrangle-legacy-code-combination-approvals/)

You can also watch a series of short videos about [using ApprovalTests in .Net](http://www.youtube.com/playlist?list=PL0C32F89E8BBB5368) on YouTube.

### Podcasts
Prefer learning by listening? Then you might enjoy the following podcasts:

- [This Agile Life](http://www.thisagilelife.com/46/)
- [Hanselminutes](http://www.hanselminutes.com/360/approval-tests-with-llewellyn-falco)
- [Herding Code](http://www.developerfusion.com/media/122649/herding-code-117-llewellyn-falcon-on-approval-tests/)
- [The Watir Podcast](http://watirpodcast.com/podcast-53/)

## 🤝 Contributing
Show some 💙 and <a href="https://github.com/K1yoshiSho/approval_tests_dart.git">star the repo</a> to support the project! 🙌


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