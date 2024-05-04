// Importing Dart package for Approval Testing
import 'package:approval_dart/approval_dart.dart';

void main() {
  // A list of all test cases that are to be verified
  const allTestCases = [
    ["foo", "Aged Brie", "Backstage passes to a TAFKAL80ETC concert", "Sulfuras, Hand of Ragnaros"], // Possible item names
    [-1, 0, 5, 6, 10, 11], // Possible "sellIn" values
    [-1, 0, 1, 49, 50] // Possible "quality" values
  ];

  // Verifying all combinations of test cases by passing them to an anonymous function
  ApprovalDart.verifyAllCombinations(allTestCases, (combinations) {
    // Initializing lists to store actual and expected items
    final List<Item> actualItems = [];
    final List<Item> expectedItems = [];

    // For each combination in combinations
    for (var combination in combinations) {
      // Extract data from the current combination
      String itemName = combination[0];
      int sellIn = combination[1];
      int quality = combination[2];

      // Create an Item object representing the current combination
      Item testItem = Item(itemName, sellIn: sellIn, quality: quality);

      // Add a copy of the item to actualItems for the "before" state
      actualItems.add(Item(itemName, sellIn: sellIn, quality: quality));

      // Passing testItem to the application
      GildedRose app = GildedRose(items: [testItem]);

      // Updating quality of testItem
      app.updateQuality();

      // Adding the updated item to expectedItems
      expectedItems.add(Item(itemName, sellIn: testItem.sellIn, quality: testItem.quality));
    }

    // Saving the state of actual and expected items
    ApprovalDart.saveCases(actualItems, expectedItems);

    // readValues(); (currently commented out)
  });
}

void readValues() {
  // Loading approved cases if they exist
  final approvedCases = ApprovalDart.loadApprovedCasesIfExists();
  final List<Item> actualItems = [];
  final List<Item> expectedItems = [];

  // For each case in approvedCases, add it as JSON to both actual and expected Items.
  for (var testCase in approvedCases) {
    actualItems.add(Item.fromJson(testCase['actual']));
    expectedItems.add(Item.fromJson(testCase['expected']));
  }

  // Printing the lengths of actualItems and expectedItems lists
  print(actualItems.length);
  print(expectedItems.length);
}

final class GildedRose {
  final List<Item> items;

  // Initializing items in the constructor
  GildedRose({
    required this.items,
  });

  /// Non refactored updateQuality method
  void updateQuality() {
    for (int i = 0; i < items.length; i++) {
      if (items[i].name != "Aged Brie" && items[i].name != "Backstage passes to a TAFKAL80ETC concert") {
        if (items[i].quality > 0) {
          if (items[i].name != "Sulfuras, Hand of Ragnaros") {
            items[i].quality = items[i].quality - 1;
          }
        }
      } else {
        if (items[i].quality < 50) {
          items[i].quality = items[i].quality + 1;

          if (items[i].name == "Backstage passes to a TAFKAL80ETC concert") {
            if (items[i].sellIn < 11) {
              if (items[i].quality < 50) {
                items[i].quality = items[i].quality + 1;
              }
            }

            if (items[i].sellIn < 6) {
              if (items[i].quality < 50) {
                items[i].quality = items[i].quality + 1;
              }
            }
          }
        }
      }

      if (items[i].name != "Sulfuras, Hand of Ragnaros") {
        items[i].sellIn = items[i].sellIn - 1;
      }

      if (items[i].sellIn < 0) {
        if (items[i].name != "Aged Brie") {
          if (items[i].name != "Backstage passes to a TAFKAL80ETC concert") {
            if (items[i].quality > 0) {
              if (items[i].name != "Sulfuras, Hand of Ragnaros") {
                items[i].quality = items[i].quality - 1;
              }
            }
          } else {
            items[i].quality = items[i].quality - items[i].quality;
          }
        } else {
          if (items[i].quality < 50) {
            items[i].quality = items[i].quality + 1;
          }
        }
      }
    }
  }
}

final class Item {
  final String name;
  int sellIn;
  int quality;

  Item(this.name, {required this.sellIn, required this.quality});

  // Factory constructor to create Item object from a map
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      json['name'],
      sellIn: json['sellIn'],
      quality: json['quality'],
    );
  }

  // Method to convert an Item object to a Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'sellIn': sellIn,
      'quality': quality,
    };
  }

  // A method to return the Item object as a string
  @override
  String toString() {
    return 'Item{name: $name, sellIn: $sellIn, quality: $quality}';
  }
}
