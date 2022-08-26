import 'package:all_persistent_types/sqlite/models/person.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PersonDAO{

  Future<Database> getDatabase() async{
    Database db = await openDatabase(
      join(await getDatabasesPath(), 'person_database.db'),
      onCreate: (db, version) {
        return db.execute("CREATE TABLE PERSON(ID INTEGER PRIMARY KEY, FIRSTNAME TEXT, LASTNAME TEXT, ADDRESS TEXT);");
      },
      version: 1
    );

    return db;
  }

  Future<List<Person>> readAll() async{
    Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('person');

    List<Person> result = List.generate(maps.length, (item){
        return Person(
          maps[item]['ID'],
          maps[item]['FIRSTNAME'],
          maps[item]['LASTNAME'],
          maps[item]['ADDRESS']
        );
    });

    return result;
  }
}