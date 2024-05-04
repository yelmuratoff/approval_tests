// ignore_for_file: depend_on_referenced_packages

import 'package:approval_dart/examples/approved_cases.g.dart';
import 'package:approval_dart/examples/gilded_rose.dart';
import 'package:test/test.dart';

void main() {
  group('Gilded Rose Item Update Tests', () {
    for (var test in approvedCases) {
      testItemUpdate(test);
    }
  });
}

void testItemUpdate(Map<String, dynamic> map) {
  final actualItem = Item(
    map['initial']['name'],
    sellIn: map['initial']['sellIn'],
    quality: map['initial']['quality'],
  );

  final expectedItem = Item(
    map['expected']['name'],
    sellIn: map['expected']['sellIn'],
    quality: map['expected']['quality'],
  );

  test('${actualItem.name} with sellIn ${actualItem.sellIn} and quality ${actualItem.quality}', () {
    print("Initial: ${actualItem.toString()}");
    GildedRose app = GildedRose(items: [actualItem]);
    app.updateQuality();

    print("Expected: ${expectedItem.toString()}");
    expect(actualItem.toString(), equals(expectedItem.toString()));
  });
}
