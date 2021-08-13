import 'package:circular_buffer/circular_buffer.dart';

void main() {
  final cb = CircularBuffer<int>(5);

  final list = <int>[4, 5, 1, -3, 8, 2, 6, 7, 4, 5];
  var sum = 0;
  double mean;
  for (final a in list) {
    final first = cb.isFilled ? cb.first : 0;
    cb.add(a);
    sum += cb.last - first;

    mean = sum.toDouble() / cb.length;

    // ignore: avoid_print
    print('Inserting $a:\tsum=$sum\tmean=$mean');
  }
}
