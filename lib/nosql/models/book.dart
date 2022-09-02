import 'package:floor/floor.dart';

@entity
class Book{
  @primaryKey
  int? id;

  String author;
  String name;

  Book({this.id, required this.author, required this.name});
}