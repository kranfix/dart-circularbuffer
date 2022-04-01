# dart-circularbuffer

A circular buffer with a fixed capacity supporting all Dart `List` operations.

```dart
final buffer = CircularBuffer<int>(3)..add(1)..add(2);
print(buffer.length); // 2
print(buffer.first); // 1
print(buffer.isFilled); // false
print(buffer.isUnfilled); // true

buffer.add(3);
print(buffer.length); // 3
print(buffer.isFilled); // true
print(buffer.isUnfilled); // false

buffer.add(4);
print(buffer.first); // 2
```
