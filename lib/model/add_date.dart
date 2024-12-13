import 'package:hive/hive.dart';
part 'add_date.g.dart';

@HiveType(typeId: 1)
class Add_data extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String explain;
  @HiveField(2)
  String monto;
  @HiveField(3)
  String IN;
  @HiveField(4)
  DateTime date;

  Add_data(this.date, this.explain, this.IN, this.monto, this.name);
}
