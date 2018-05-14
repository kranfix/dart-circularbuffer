import 'package:circular_buffer/circular_buffer.dart';

main() async {
  CircularBuffer<int> cb = new CircularBuffer<int>(5);
  
  List<int> L = [4,5,1,-3,8,2,6,7,4,5];
  int sum = 0;
  double mean;
  for(int a in L){
    int start = cb.filled? cb.start : 0;
    await cb.insert(a);
    sum += cb.end - start;

    mean = sum.toDouble() / cb.len;

    print('Inserting ${a}:\tsum=$sum\tmean=$mean');
  }
}