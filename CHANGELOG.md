# 0.12.0

- Added `addHead` method.
- Deprecated `reset` method in favor of `clear`.

# 0.11.0

- Fixed incorrect buffer state when adding items after calling `reset`.

- Made `clear` be an alias to `reset` instead of throwing an error.

- Fixed to work with nullable element types.

- Simplified the implementation.

# 0.10.0+1

- Corrected examples in documentation.

# 0.10.0 - 2021-08-13

- Added a `CircularBuffer.of(List<T> list, [int? capacity])` constructor.

# 0.9.1

- Added documentation to `CircularBuffer` class
- Added example to README

# 0.9.0

- Migrated to null-safety (thanks to @shyndman)
- Added test for border conditions

# 0.8.0

- The `CircularBuffer` minimum capacity is 2
- Added tests

# 0.7.0

- Use `ListMixin`.

# 0.6.0

- Migration to Dart 2.
- Added forEach method.

# 0.5.0

- A circular buffer made in Dart 1.
