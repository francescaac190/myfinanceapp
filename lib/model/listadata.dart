import 'package:myfinanceapp/model/1.dart';

List<money> geter() {
  money upwork = money();
  upwork.name = 'upwork';
  upwork.fee = '650';
  upwork.time = 'hoy';
  upwork.buy = false;
  money starbucks = money();
  starbucks.fee = '15';
  starbucks.buy = true;
  starbucks.name = 'starbucks';
  starbucks.time = 'hoy';
  return [upwork, starbucks];
}
