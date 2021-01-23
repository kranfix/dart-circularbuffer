import 'package:circular_buffer/circular_buffer.dart';

main() async {
  final cb = CircularBuffer<int>(5);

  List<int> list = [4, 5, 1, -3, 8, 2, 6, 7, 4, 5];
  int sum = 0;
  double mean;
  for (int a in list) {
    final first = cb.isFilled ? cb.first : 0;
    cb.add(a);
    sum += cb.last - first;

    mean = sum.toDouble() / cb.length;

    print('Inserting ${a}:\tsum=$sum\tmean=$mean');
  }
}
