import 'package:approval_dart/approval_dart.dart';

void main() {
  const allTestCases = [
    ["foo", "Aged Brie", "Backstage passes to a TAFKAL80ETC concert", "Sulfuras, Hand of Ragnaros"],
    [-1, 0, 5, 6, 10, 11],
    [-1, 0, 1, 49, 50]
  ];

  ApprovalDart.verifyAllCombinations(allTestCases, (combinations) {
    final List<Item> actualItems = [];
    final List<Item> expectedItems = [];

    for (var combination in combinations) {
      String itemName = combination[0];
      int sellIn = combination[1];
      int quality = combination[2];
      Item testItem = Item(itemName, sellIn: sellIn, quality: quality);

      // Add a clone of the item to actualItems for the "before" state
      actualItems.add(Item(itemName, sellIn: sellIn, quality: quality));

      // Pass the testItem to the application
      GildedRose app = GildedRose(items: [testItem]);
      app.updateQuality();

      // Now add the updated item to expectedItems
      expectedItems.add(Item(itemName, sellIn: testItem.sellIn, quality: testItem.quality));
    }

    ApprovalDart.saveCases(actualItems, expectedItems);

    // readValues();
  });
}

void readValues() {
  final approvedCases = ApprovalDart.loadApprovedCasesIfExists();
  final List<Item> actualItems = [];
  final List<Item> expectedItems = [];
  for (var testCase in approvedCases) {
    actualItems.add(Item.fromJson(testCase['actual']));
    expectedItems.add(Item.fromJson(testCase['expected']));
  }
  print(actualItems.length);
  print(expectedItems.length);
}

final class GildedRose {
  final List<Item> items;

  GildedRose({
    required this.items,
  });

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

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      json['name'],
      sellIn: json['sellIn'],
      quality: json['quality'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'sellIn': sellIn,
      'quality': quality,
    };
  }

  @override
  String toString() {
    return 'Item{name: $name, sellIn: $sellIn, quality: $quality}';
  }
}
