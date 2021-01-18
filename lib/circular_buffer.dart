import 'dart:collection';

/// Supports all [List] operations
class CircularBuffer<T> with ListMixin<T> {
  List<T> _buf;
  int _start;
  int _end;
  int _count;

  CircularBuffer(int n) {
    _buf = new List<T>(n);
    reset();
  }

  reset() {
    _start = 0;
    _end = -1;
    _count = 0;
  }

  void add(T el) {
    // Adding the next value
    _end++;
    if (_end == _buf.length) {
      _end = 0;
    }
    _buf[_end] = el;

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
  int get length => _count;

  /// Maximum number of elements of [CircularBuffer]
  int get capacity => _buf.length;

  bool get isFilled => (_count == _buf.length);
  bool get isUnfilled => (_count < _buf.length);

  T operator [] (int index) {
    if(index > _count) throw RangeError.index(index, this);

    return _buf[(_start + index) % _buf.length];
  }

  void operator []= (int index, T value) {
    if(index > _count) throw RangeError.index(index, this);

    _buf[(_start + index) % _buf.length] = value;
  }

  set length(int newLength) {
    throw new UnsupportedError("Cannot resize immutable CircularBuffer.");
  }
}
