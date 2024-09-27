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
/// print(buffer.first); // 2
/// ```
class CircularBuffer<T> with ListMixin<T> {
  /// Creates a [CircularBuffer] with a `capacity`
  CircularBuffer(this.capacity)
      : assert(capacity > 1, 'CircularBuffer must have a positive capacity.'),
        _buf = [],
        _len = 0;

  /// Creates a [CircularBuffer] based on another `list`
  CircularBuffer.of(List<T> list, [int? capacity])
      : assert(
          capacity == null || capacity >= list.length,
          'The capacity must be at least as long as the existing list',
        ),
        capacity = capacity ?? list.length,
        _buf = [...list],
        _len = list.length;

  final List<T> _buf;

  /// Maximum number of elements of [CircularBuffer]
  final int capacity;

  int _start = 0;
  int _len;

  /// Resets the [CircularBuffer].
  ///
  /// [capacity] is unaffected.
  void reset() {
    _start = 0;
    _buf.clear();
    _len = 0;
  }

  /// An alias to [reset].
  @override
  void clear() => reset();

  @override
  void add(T element) {
    if (isUnfilled) {
      // The internal buffer is not at its maximum size.  Grow it.
      assert(_start == 0, 'Internal buffer grown from a bad state');
      _buf.add(element);
      _len++;
      return;
    }

    // All space is used, so overwrite the start.
    _buf[_start] = element;
    _start++;
    if (_start == capacity) {
      _start = 0;
    }
  }

  /// Adds an element as the first element
  void addHead(T element) {
    if (isFilled) {
      if (_start == 0) {
        _start = _len - 1;
      } else {
        _start--;
      }
      _buf[_start] = element;
    }
  }

  /// Number of used elements of [CircularBuffer]
  @override
  int get length => _len;

  /// The [CircularBuffer] `isFilled` if the [length]
  /// is equal to the [capacity].
  bool get isFilled => _len == capacity;

  /// The [CircularBuffer] `isUnfilled` if the [length] is
  /// less than the [capacity].
  bool get isUnfilled => _len < capacity;

  @override
  T operator [](int index) {
    if (index >= 0 && index < _len) {
      return _buf[(_start + index) % _len];
    }
    throw RangeError.index(index, this);
  }

  @override
  void operator []=(int index, T value) {
    if (index >= 0 && index < _len) {
      _buf[(_start + index) % _len] = value;
    } else {
      throw RangeError.index(index, this);
    }
  }

  /// The `length` mutation is forbidden
  @override
  set length(int newLength) {
    throw UnsupportedError('Cannot resize a CircularBuffer.');
  }
}
