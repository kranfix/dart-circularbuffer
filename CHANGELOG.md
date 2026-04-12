# 0.13.0 - 2026-04-12

- Fixed `addHead` to correctly drop the tail element when the buffer is full.
- Removed deprecated `reset()` method (deprecated since 0.12.0, use `clear()` instead).
- `insert()` now explicitly throws `UnsupportedError`.
- `CircularBuffer.of([])` and `CircularBuffer.of([], 1)` now throw `AssertionError` (capacity must be > 1).
- Internal buffer is now pre-allocated with fixed capacity; `clear()` releases references for garbage collection.

# 0.12.0 - 2024-09-28

- Added `addHead` method.
- Deprecated `reset` method in favor of `clear`.

# 0.11.0 - 2022-04-18

- Fixed incorrect buffer state when adding items after calling `reset`.

- Made `clear` be an alias to `reset` instead of throwing an error.

- Fixed to work with nullable element types.

- Simplified the implementation.

# 0.10.0+1

- Corrected examples in documentation.

# 0.10.0 - 2021-08-13

- Added a `CircularBuffer.of(List<T> list, [int? capacity])` constructor.

# 0.9.1 - 2021-03-28

- Added documentation to `CircularBuffer` class
- Added example to README

# 0.9.0 - 2021-03-28

- Migrated to null-safety (thanks to @shyndman)
- Added test for border conditions

# 0.8.0 - 2021-02-03

- The `CircularBuffer` minimum capacity is 2
- Added tests

# 0.7.0 - 2021-01-23

- Use `ListMixin`.

# 0.6.0 - 2020-03-16

- Migration to Dart 2.
- Added forEach method.

# 0.5.0 - 2018-05-14

- A circular buffer made in Dart 1.
