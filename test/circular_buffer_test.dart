import 'package:circular_buffer/circular_buffer.dart';
import 'package:test/test.dart';

void main() {
  group('Creating a CircularBuffer', () {
    test('with zero or one element capacity', () {
      expect(() {
        CircularBuffer<int>(0);
      }, throwsA(isA<AssertionError>()));

      expect(() {
        CircularBuffer<int>(1);
      }, throwsA(isA<AssertionError>()));
    });

    test('with two or more element capacity', () {
      final buffer2 = CircularBuffer<int>(2);
      expect(buffer2.length, 0);
      expect(buffer2.capacity, 2);

      final buffer3 = CircularBuffer<int>(3);
      expect(buffer3.length, 0);
      expect(buffer3.capacity, 3);

      final buffer4 = CircularBuffer<int>(4);
      expect(buffer4.length, 0);
      expect(buffer4.capacity, 4);
    });

    test('and adding some elements', () {
      final buffer = CircularBuffer<int>(5);
      expect(buffer.length, 0);
      expect(buffer.capacity, 5);

      expect(() {
        return buffer[-1];
      }, throwsA(isA<RangeError>()));

      expect(() {
        return buffer[0];
      }, throwsA(isA<RangeError>()));

      buffer.add(4);
      expect(buffer.length, 1);
      expect(buffer[0], 4);
      expect(() {
        return buffer[1];
      }, throwsA(isA<RangeError>()));

      buffer.add(5);
      expect(buffer.length, 2);
      expect(buffer[0], 4);
      expect(buffer[1], 5);
      expect(() {
        return buffer[2];
      }, throwsA(isA<RangeError>()));

      buffer.add(6);
      expect(buffer.length, 3);
      expect(buffer[0], 4);
      expect(buffer[1], 5);
      expect(buffer[2], 6);
      expect(() {
        return buffer[3];
      }, throwsA(isA<RangeError>()));

      buffer.add(7);
      expect(buffer.length, 4);
      expect(buffer[0], 4);
      expect(buffer[1], 5);
      expect(buffer[2], 6);
      expect(buffer[3], 7);
      expect(() {
        return buffer[4];
      }, throwsA(isA<RangeError>()));

      buffer.add(8);
      expect(buffer.length, 5);
      expect(buffer[0], 4);
      expect(buffer[1], 5);
      expect(buffer[2], 6);
      expect(buffer[3], 7);
      expect(buffer[4], 8);
      expect(() {
        return buffer[5];
      }, throwsA(isA<RangeError>()));
    });
  });

  group('Creating a CircularBuffer.of()', () {
    test('with zero or one element capacity', () {
      final cb1 = CircularBuffer<int>.of([]);
      expect(cb1.length, 0);
      expect(cb1.capacity, 0);

      final cb2 = CircularBuffer<int>.of([], 1);
      expect(cb2.length, 0);
      expect(cb2.capacity, 1);
    });

    test('when capacity is less than length, throws an error', () {
      expect(
        () {
          CircularBuffer<int>.of([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 3);
        },
        throwsA(isA<AssertionError>()),
      );
    });

    test('and adding some elements', () {
      final buffer = CircularBuffer<int>.of([4, 5, 6], 5);
      expect(buffer.length, 3);
      expect(buffer.capacity, 5);

      expect(() {
        return buffer[-1];
      }, throwsA(isA<RangeError>()));

      expect(buffer.length, 3);
      expect(buffer[0], 4);
      expect(buffer[1], 5);
      expect(buffer[2], 6);
      expect(() {
        return buffer[3];
      }, throwsA(isA<RangeError>()));

      buffer.add(7);
      expect(buffer.length, 4);
      expect(buffer[0], 4);
      expect(buffer[1], 5);
      expect(buffer[2], 6);
      expect(buffer[3], 7);
      expect(() {
        return buffer[4];
      }, throwsA(isA<RangeError>()));

      buffer.add(8);
      expect(buffer.length, 5);
      expect(buffer[0], 4);
      expect(buffer[1], 5);
      expect(buffer[2], 6);
      expect(buffer[3], 7);
      expect(buffer[4], 8);
      expect(() {
        return buffer[5];
      }, throwsA(isA<RangeError>()));
    });
  });

  test('when adding more elements than capacity', () {
    final buffer = CircularBuffer<int>(5)
      ..add(1)
      ..add(2)
      ..add(3)
      ..add(4)
      ..add(5);

    expect(buffer.length, 5);
    expect(buffer.capacity, 5);

    expect(buffer[0], 1);
    expect(buffer[1], 2);
    expect(buffer[2], 3);
    expect(buffer[3], 4);
    expect(buffer[4], 5);

    buffer.add(6);
    expect(buffer[0], 2);
    expect(buffer[1], 3);
    expect(buffer[2], 4);
    expect(buffer[3], 5);
    expect(buffer[4], 6);

    buffer.add(7);
    expect(buffer[0], 3);
    expect(buffer[1], 4);
    expect(buffer[2], 5);
    expect(buffer[3], 6);
    expect(buffer[4], 7);
  });

  test('is iterable', () {
    final buffer1 = CircularBuffer<int>(5);
    var count = 0;
    for (final _ in buffer1) {
      count++;
    }
    expect(count, 0);

    final buffer2 = CircularBuffer<int>(5)
      ..add(1) //
      ..add(2)
      ..add(3);
    final expectedList2 = <int>[1, 2, 3];
    final collectedList2 = <int>[];
    for (final el in buffer2) {
      collectedList2.add(el);
    }
    expect(collectedList2, expectedList2);

    final buffer3 = CircularBuffer<int>(5)
      ..add(1)
      ..add(2)
      ..add(3)
      ..add(4)
      ..add(5)
      ..add(6)
      ..add(7);
    final expectedList3 = <int>[3, 4, 5, 6, 7];
    final collectedList3 = <int>[];
    for (final el in buffer3) {
      collectedList3.add(el);
    }
    expect(collectedList3, expectedList3);
  });

  group('resetting', () {
    test('when is reset', () {
      final buffer = CircularBuffer<int>(5)
        ..add(1)
        ..add(2)
        ..reset();

      expect(buffer.length, 0);
      expect(buffer.capacity, 5);
    });

    test('adding items after a reset', () {
      final buffer = CircularBuffer<int>(5)
        ..add(1)
        ..add(2)
        ..reset()
        ..add(3)
        ..add(4);

      expect(buffer, [3, 4]);
      expect(buffer.capacity, 5);
    });
  });

  test('Editing a value with a given index', () {
    final buffer = CircularBuffer<int>(5)
      ..add(1)
      ..add(2);
    buffer[0] = 6;
    buffer[1] = 7;
    expect(buffer[0], 6);
    expect(buffer[1], 7);

    expect(() {
      buffer[2] = 3;
    }, throwsA(isA<IndexError>()));
  });
  test('when modifying length throws an error', () {
    final buffer = CircularBuffer<int>(5)
      ..add(1)
      ..add(2);
    expect(() {
      buffer.length = 1;
    }, throwsA(isA<UnsupportedError>()));
  });

  group('border conditions', () {
    test('is filled or unfilled', () {
      final buffer = CircularBuffer<int>(3)
        ..add(1)
        ..add(2);

      expect(buffer.isFilled, false);
      expect(buffer.isUnfilled, true);

      buffer.add(3);
      expect(buffer.isFilled, true);
      expect(buffer.isUnfilled, false);
    });

    test('first internal index is retarted', () {
      final buffer = CircularBuffer<int>(3)
        ..add(1)
        ..add(2)
        ..add(3);

      expect(buffer.first, 1);

      buffer.add(4);
      expect(buffer.first, 2);

      buffer.add(5);
      expect(buffer.first, 3);

      buffer.add(6);
      expect(buffer.first, 4);
    });
  });

  test('nullable elements', () {
    final buffer = CircularBuffer<int?>(3)
      ..add(null)
      ..add(2);
    expect(buffer, <int?>[null, 2]);
  });

  group('addHead', () {
    test('should add an element in an empty buffer', () {
      final buffer = CircularBuffer<int>(3)..addHead(1);
      expect(buffer[0], 1);
      expect(buffer.length, 1);
    });

    test('should add an element in a filled buffer', () {
      final buffer = CircularBuffer<int>.of([1, 2, 3])..addHead(4);
      expect(buffer[0], 4);
      expect(buffer[1], 1);
      expect(buffer[2], 2);

      buffer.addHead(5);
      expect(buffer[0], 5);
      expect(buffer[1], 4);
      expect(buffer[2], 1);
    });

    test('should add an element in an almost filled buffer', () {
      final buffer = CircularBuffer<int>.of([1, 2], 3)..addHead(4);
      expect(buffer[0], 4);
      expect(buffer[1], 1);
      expect(buffer[2], 2);
    });

    test('should add an element in an almost filled buffer', () {
      final buffer = CircularBuffer<int>.of([1, 2], 5);
      expect(buffer.length, 2);
      expect(buffer.capacity, 5);

      buffer.addHead(4);
      expect(buffer[0], 4);
      expect(buffer[1], 1);
      expect(buffer[2], 2);
      expect(buffer.length, 3);

      buffer.addHead(5);
      expect(buffer[0], 5);
      expect(buffer[1], 4);
      expect(buffer[2], 1);
      expect(buffer[3], 2);
      expect(buffer.length, 4);

      buffer.addHead(6);
      expect(buffer[0], 6);
      expect(buffer[1], 5);
      expect(buffer[2], 4);
      expect(buffer[3], 1);
      expect(buffer[4], 2);
      expect(buffer.length, 5);
    });
  });
}
