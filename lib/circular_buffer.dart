import 'dart:collection';

/// A [CircularBuffer] with a fixed capacity.
///
/// Supports most [List] read operations and a fixed-size write interface
/// ([add], [addHead], [clear]). Mutation methods that resize the list
/// (e.g. [insert], [removeAt], [removeLast]) either throw [UnsupportedError]
/// or are unsupported.
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
      : assert(capacity > 1, 'CircularBuffer capacity must be greater than 1.'),
        _buf = List<Object?>.filled(capacity, _none),
        _len = 0;

  /// Creates a [CircularBuffer] based on another `list`
  CircularBuffer.of(List<T> list, [int? capacity])
      : assert(
          capacity == null || capacity >= list.length,
          'The capacity must be at least as long as the existing list',
        ),
        assert(
          (capacity ?? list.length) > 1,
          'CircularBuffer capacity must be greater than 1.',
        ),
        capacity = capacity ?? list.length,
        _buf = List<Object?>.filled(capacity ?? list.length, null)
          ..setRange(0, list.length, list),
        _len = list.length;

  final List<Object?> _buf;

  /// Maximum number of elements of [CircularBuffer]
  final int capacity;

  int _start = 0;
  int _len;

  /// Clears the [CircularBuffer].
  ///
  /// [capacity] is unaffected.
  @override
  void clear() {
    // Release references so GC can collect stored objects.
    // Only the _len occupied slots need clearing; they may wrap around.
    final end = _start + _len;
    if (end <= capacity) {
      _buf.fillRange(_start, end, _none);
    } else {
      _buf
        ..fillRange(_start, capacity, _none)
        ..fillRange(0, end - capacity, _none);
    }
    _start = 0;
    _len = 0;
  }

  @override
  void add(T element) {
    if (isUnfilled) {
      // Place the new element at the next available slot after current content.
      _buf[(_start + _len) % capacity] = element;
      _len++;
      return;
    }

    // Buffer is full: overwrite the oldest element and advance start.
    _buf[_start] = element;
    _start = (_start + 1) % capacity;
  }

  /// Adds an element as the first element.
  ///
  /// If the buffer is full, the last (tail) element is dropped.
  void addHead(T element) {
    // Move the start pointer one step back (wrapping around) and write there.
    // When full this overwrites the old tail slot; when unfilled it claims a
    // new slot and increments the length.
    _start = (_start == 0) ? capacity - 1 : _start - 1;
    _buf[_start] = element;
    if (isUnfilled) _len++;
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
      return _buf[(_start + index) % capacity] as T;
    }
    throw RangeError.index(index, this);
  }

  @override
  void operator []=(int index, T value) {
    if (index >= 0 && index < _len) {
      _buf[(_start + index) % capacity] = value;
    } else {
      throw RangeError.index(index, this);
    }
  }

  /// The `length` mutation is forbidden
  @override
  set length(int newLength) {
    throw UnsupportedError('Cannot resize a CircularBuffer.');
  }

  /// Inserting into a [CircularBuffer] is not supported.
  @override
  void insert(int index, T element) {
    throw UnsupportedError('Cannot insert into a CircularBuffer.');
  }
}

class _None {
  const _None._();
}

const _none = _None._();
