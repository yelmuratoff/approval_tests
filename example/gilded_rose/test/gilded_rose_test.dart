// import 'package:approval_tests/approval_dart.dart';

// void main() {
//   // A list of all test cases that are to be verified
//   const allTestCases = [
//     ["foo", "Aged Brie", "Backstage passes to a TAFKAL80ETC concert", "Sulfuras, Hand of Ragnaros"], // Possible item names
//     [-1, 0, 5, 6, 10, 11], // Possible "sellIn" values
//     [-1, 0, 1, 49, 50] // Possible "quality" values
//   ];

//   // Verifying all combinations of test cases by passing them to an anonymous function
//   ApprovalTests.verifyAllCombinations(allTestCases, (combinations) {
//     // Initializing lists to store actual and expected items
//     final List<Item> actualItems = [];
//     final List<Item> expectedItems = [];

//     // For each combination in combinations
//     for (var combination in combinations) {
//       // Extract data from the current combination
//       String itemName = combination[0];
//       int sellIn = combination[1];
//       int quality = combination[2];

//       // Create an Item object representing the current combination
//       Item testItem = Item(itemName, sellIn: sellIn, quality: quality);

//       // Add a copy of the item to actualItems for the "before" state
//       actualItems.add(Item(itemName, sellIn: sellIn, quality: quality));

//       // Passing testItem to the application
//       GildedRose app = GildedRose(items: [testItem]);

//       // Updating quality of testItem
//       app.updateQuality();

//       // Adding the updated item to expectedItems
//       expectedItems.add(Item(itemName, sellIn: testItem.sellIn, quality: testItem.quality));
//     }

//     // Saving the state of actual and expected items
//     ApprovalDart.saveCases(actualItems, expectedItems);

//     // readValues(); (currently commented out)
//   });
// }
