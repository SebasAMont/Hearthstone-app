import 'package:first_app/src/data/model/card.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks.dart';

void main() {


  group('HearthstoneCard.fromJson', () {
    test(
        'factory constructor receives a Map<String, dynamic> that matches the required parameters and creates a HearthstoneCard',
        () {
      expect(
        HearthstoneCard.fromJson(jsonMockito),
        const TypeMatcher<HearthstoneCard>(),
      );
    });
    test(
        'factory constructor receives  a corrupted Map<String, dynamic>, required parameters dont match and should return error',
        () {
      expect(
        () => HearthstoneCard.fromJson(jsonMockitoCorrupted),
        throwsA(
          const TypeMatcher<TypeError>(),
        ),
      );
    });
  });
}
