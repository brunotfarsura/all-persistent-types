import 'dart:async';

import 'package:all_persistent_types/nosql/daos/bookDao.dart';
import 'package:all_persistent_types/nosql/models/book.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'appDatabase.g.dart';

@Database(version: 1, entities: [Book])
abstract class AppDataBase extends FloorDatabase{
  BookDao get bookDao;  
}