class CircularBuffer<T> {
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

  insert(T el) async {
    // Inserting the next value
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

  @Deprecated("Use `first` instead")
  T get start => _buf[_start];
  @Deprecated("Use `last` instead")
  T get end => _buf[_end];

  /// Element at the start of the [CircularBuffer]
  T get first => _buf[_start];

  /// Element at the end of the [CircularBuffer]
  T get last => _buf[_end];

  @Deprecated("Use `length` instead")
  int get len => _count;
  @Deprecated("Use `capacity` instead")
  int get cap => _buf.length;

  /// Number of elements of [CircularBuffer]
  int get length => _count;

  /// Maximun number of elements of [CircularBuffer]
  int get capacity => _buf.length;

  @Deprecated("Use `isFilled` instead")
  bool get filled => (_count == _buf.length);
  @Deprecated("Use `isUnfilled` instead")
  bool get unfilled => (_count < _buf.length);

  bool get isFilled => (_count == _buf.length);
  bool get isUnfilled => (_count < _buf.length);

  /// Allows you to iterate over the contents of the buffer
  /// The [action] callback is called for each item in the
  /// buffer.
  void forEach(void Function(T) action) {
    for (var i = _start; i < _start + _count; i++) {
      var val = _buf[i % len];
      action(val);
    }
  }
}
