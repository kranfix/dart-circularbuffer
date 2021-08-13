import 'dart:collection';

/// A [CircularBuffer] with a fixed capacity supporting all [List] operations
///
/// ```dart
/// final buffer = CircularBuffer<int>(3)..add(1)..add(2);
/// print(buffer.length); // 2
/// print(buffer.first); // 1
/// print(buffer.isFilled); // false
/// print(buffer.isUnfilled); // true
///
/// buffer.add(3);
/// print(buffer.length); // 3
/// print(buffer.isFilled); // true
/// print(buffer.isUnfilled); // false
///
/// buffer.add(4);
/// print(buffer.first); // 4
/// ```
class CircularBuffer<T> with ListMixin<T> {
  /// Creates a [CircularBuffer] with a `capacity`
  CircularBuffer(int capacity)
      : assert(capacity > 1),
        _capacity = capacity,
        _buf = [],
        _end = -1,
        _count = 0;

  /// Creates a [CircularBuffer] based on another `list`
  CircularBuffer.of(List<T> list, [int? capacity])
      : assert(capacity == null || capacity >= list.length),
        _capacity = capacity ?? list.length,
        _buf = [...list],
        _end = list.length - 1,
        _count = list.length;

  final List<T> _buf;
  final int _capacity;

  int _start = 0;
  int _end;
  int _count;

  /// The [CircularBuffer] is `reset`
  void reset() {
    _start = 0;
    _end = -1;
    _count = 0;
  }

  @override
  void add(T element) {
    // Adding the next value
    _end++;
    if (_end == _capacity) {
      _end = 0;
    }
    if (isFilled) {
      _buf[_end] = element;
    } else {
      _buf.add(element);
      _count++;
      return;
    }

    _start++;
    if (_start == _capacity) {
      _start = 0;
    }
  }

  /// Number of elements of [CircularBuffer]
  @override
  int get length => _count;

  /// Maximum number of elements of [CircularBuffer]
  int get capacity => _capacity;

  /// The [CircularBuffer] `isFilled`  if the `length`
  /// is equal to the `capacity`
  bool get isFilled => _count == _capacity;

  /// The [CircularBuffer] `isUnfilled`  if the `length` is
  /// is less than the `capacity`
  bool get isUnfilled => _count < _capacity;

  @override
  T operator [](int index) {
    if (index >= 0 && index < _count) {
      return _buf[(_start + index) % _buf.length]!;
    }
    throw RangeError.index(index, this);
  }

  @override
  void operator []=(int index, T value) {
    if (index >= 0 && index < _count) {
      _buf[(_start + index) % _buf.length] = value;
    } else {
      throw RangeError.index(index, this);
    }
  }

  /// The `length` mutation is forbidden
  @override
  set length(int newLength) {
    throw UnsupportedError('Cannot resize immutable CircularBuffer.');
  }
}
