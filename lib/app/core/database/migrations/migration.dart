import 'package:sqflite/sqflite.dart';

// Interface com dois métodos que quem implementar ela vai ter que implementar os dois métodos também.
abstract class Migration {
  void create(Batch batch);
  void update(Batch batch);
}
