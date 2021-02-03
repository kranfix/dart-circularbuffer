import 'dart:collection';

/// Supports all [List] operations
class CircularBuffer<T> with ListMixin<T> {
  /// Creates a [CircularBuffer] with a `capacity`
  CircularBuffer(int capacity)
      : assert(capacity != null),
        _buf = List<T>(capacity) {
    reset();
  }

  final List<T> _buf;
  int _start = 0;
  int _end = -1;
  int _count = 0;

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
    if (_end == _buf.length) {
      _end = 0;
    }
    _buf[_end] = element;

    // updating the start
    if (_count < _buf.length) {
      _count++;
      return;
    }

    _start++;
    if (_start == _buf.length) {
      _start = 0;
    }
  }

  /// Number of elements of [CircularBuffer]
  @override
  int get length => _count;

  /// Maximum number of elements of [CircularBuffer]
  int get capacity => _buf.length;

  /// The [CircularBuffer] `isFilled`  if the `length`
  /// is equal to the `capacity`
  bool get isFilled => (_count == _buf.length);

  /// The [CircularBuffer] `isUnfilled`  if the `length` is
  /// is less than the `capacity`
  bool get isUnfilled => (_count < _buf.length);

  @override
  T operator [](int index) {
    if (index > _count) throw RangeError.index(index, this);
    return _buf[(_start + index) % _buf.length];
  }

  @override
  void operator []=(int index, T value) {
    if (index > _count) throw RangeError.index(index, this);

    _buf[(_start + index) % _buf.length] = value;
  }

  /// The `length` mutation is forbidden
  @override
  set length(int newLength) {
    throw UnsupportedError('Cannot resize immutable CircularBuffer.');
  }
}
