class CircularBuffer<T> {
  List<T> _buf;
  int _start;
  int _end;
  int _count;

  CircularBuffer(int n){
    _buf = new List<T>(n);
    reset();
  }

  reset(){
    _start = 0;
    _end = -1;
    _count = 0;
  }

  insert(T el) async{
    // Inserting the next value
    _end++;
    if(_end == _buf.length){
      _end = 0;
    }
    _buf[_end] = el;

    // updating the start
    if(_count < _buf.length){
      _count++;
      return;
    }

    _start++;
    if(_start == _buf.length){
      _start = 0;
    }
  }

  T get start => _buf[_start];
  T get end => _buf[_end];

  int get len => _count;
  int get cap => _buf.length;

  bool get filled => (_count == _buf.length);
  bool get unfilled => (_count < _buf.length);
}