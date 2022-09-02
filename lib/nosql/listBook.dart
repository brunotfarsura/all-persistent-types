import 'package:all_persistent_types/nosql/addBook.dart';
import 'package:all_persistent_types/nosql/daos/bookDao.dart';
import 'package:all_persistent_types/nosql/database/appDatabase.dart';
import 'package:all_persistent_types/nosql/models/book.dart';
import 'package:flutter/material.dart';

class ListBook extends StatefulWidget {
  const ListBook({Key? key}) : super(key: key);

  final Text title = const Text("Livros");

  @override
  _ListBookState createState() => _ListBookState();
}

class _ListBookState extends State<ListBook> {
  List<Book> books = <Book>[];
  BookDao? dao;

  @override
  void initState(){
    super.initState();
    getAllBooks();
  }

  getAllBooks() async{
    final database = await $FloorAppDataBase.databaseBuilder("app_floor_database.db").build();
    dao = database.bookDao;

    if(dao != null){
      final result = await dao!.findAll();
      if(result.isNotEmpty){
        setState(() {
          books = result;
        });
      }
    }
  }

  insertBook(Book book) async{
    if(dao != null){
      final id = await dao!.insertBook(book);
      book.id = id;
      setState(() {
        books.add(book);
      });
    }
  }

  deleteBook(int bookId) async{
      if(dao != null){
        final book = books[bookId];
        await dao!.deleteBook(book);
        setState(() {
          books.removeAt(bookId);
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.title,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: (){
              Navigator.push(context, 
                MaterialPageRoute(builder: (context) => AddBook()))
                .then((book) => {
                  setState((){
                    insertBook(book);
                  })
                });
            })
        ],
        ),
      body: ListView.separated(
        itemCount: books.length,
        itemBuilder: ((context, index) => buildListItems(index)),
        separatorBuilder: (context, index) => const Divider(height: 1,)
        )
    );
  }

  Widget buildListItems(int bookId){
    Book book = books[bookId];
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5)
          ),
          child: ListTile(
            leading: Text(book.id != null ? book.id.toString() : "-1"),
            title: Text(book.name),
            subtitle: Text(book.author),
            onLongPress: (){
              deleteBook(bookId);
            }
          ),
        ),
      );
  }
}