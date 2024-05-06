// ignore_for_file: avoid_relative_lib_imports

import 'package:approval_tests/approval_dart.dart';
import 'package:test/test.dart';

import '../lib/gilded_rose.dart';
import '../lib/item.dart';

void main() {
  // Define all test cases
  const allTestCases = [
    [
      "foo",
      "Aged Brie",
      "Backstage passes to a TAFKAL80ETC concert",
      "Sulfuras, Hand of Ragnaros"
    ],
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
