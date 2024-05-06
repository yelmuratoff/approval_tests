// TODO: Add tests for this
// // Importing Dart package for Gilded Rose example and Test Framework

// import 'package:approval_tests/examples/gilded_rose.dart';
// import 'package:approval_tests/src/core/utils/utils.dart';
// import 'package:test/test.dart';

// void main() {
//   // Grouping test cases for Gilded Rose Item Update
//   group('Gilded Rose Item Update Tests', () {
//     // Generate list of test cases for Gilded Rose and use it:
//     final list = []; // approvedCases;

//     print("Current Directory: ${ApprovalUtils.directoryPath}");

//     // Iterating over each test case in the list and performing item updates
//     for (var test in list) {
//       testItemUpdate(test);
//     }
//   });
// }

// // // Function definition for testing item update
// // void testItemUpdate(Map<String, dynamic> map) {
// //   // Initialization of actual item object with initial attributes from the map
// //   final actualItem = Item(
// //     map['initial']['name'],
// //     sellIn: map['initial']['sellIn'],
// //     quality: map['initial']['quality'],
// //   );

// //   // Initialization of expected item object with expected attributes from the map
// //   final expectedItem = Item(
// //     map['expected']['name'],
// //     sellIn: map['expected']['sellIn'],
// //     quality: map['expected']['quality'],
// //   );

// //   // Defining a test on the actual item where quality is updated
// //   test(
// //       '${actualItem.name} with sellIn ${actualItem.sellIn} and quality ${actualItem.quality}',
// //       () {
// //     print("Initial: ${actualItem.toString()}");
// //     GildedRose app = GildedRose(items: [actualItem]);

// //     // Updating the quality of actual item
// //     app.updateQuality();

// //     print("Expected: ${expectedItem.toString()}");
// //     expect(
// //         actualItem.toString(),
// //         equals(expectedItem
// //             .toString())); // Checking if the updated actual item is equal to the expected item
// //   });
// // }
