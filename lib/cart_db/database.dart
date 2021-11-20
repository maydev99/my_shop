import 'package:floor/floor.dart';
import 'cart_dao.dart';
import 'cart_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

part 'database.g.dart';

@Database(version:1,entities:[CartEntity])
abstract class AppDatabase extends FloorDatabase{
  CartDao get cartDao;
}
