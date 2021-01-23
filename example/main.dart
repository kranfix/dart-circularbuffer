import 'package:circular_buffer/circular_buffer.dart';

main() async {
  CircularBuffer<int> cb = new CircularBuffer(5);

  List<int> L = [4, 5, 1, -3, 8, 2, 6, 7, 4, 5];
  int sum = 0;
  double mean;
  for (int a in L) {
    int first = cb.isFilled ? cb.first : 0;
    cb.add(a);
    sum += cb.last - first;

    mean = sum.toDouble() / cb.length;

    print('Inserting ${a}:\tsum=$sum\tmean=$mean');
  }
}
