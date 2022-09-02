import 'package:all_persistent_types/nosql/models/book.dart';
import 'package:floor/floor.dart';

@dao
abstract class BookDao{

  @Query("SELECT * FROM Book")
  Future<List<Book>> findAll();

  @insert
  Future<int> insertBook(Book book);

  @delete
  Future<int> deleteBook(Book book);
}