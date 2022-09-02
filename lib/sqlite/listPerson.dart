import 'package:all_persistent_types/sqlite/addPerson.dart';
import 'package:all_persistent_types/sqlite/daos/personDAO.dart';
import 'package:all_persistent_types/sqlite/models/person.dart';
import 'package:flutter/material.dart';

class ListPerson extends StatefulWidget {
  const ListPerson({Key? key}) : super(key: key);

  final Text title = const Text("Pessoas");

  @override
  _ListPersonState createState() => _ListPersonState();
}

class _ListPersonState extends State<ListPerson> {
  List<Person> persons = <Person>[];

  @override
  void initState(){
    super.initState();
    getAllPersons();
  }

  getAllPersons() async{
    List<Person> result= await PersonDAO().readAll();
    setState(() {
      persons = result;
    });
  }

  insertPerson(Person person) async{
    int id = await PersonDAO().insertPerson(person);
    if(id > 0){
      person.id = id;
      setState(() {
        persons.add(person);
      });
    }
  }

  deletePerson(int personId) async{
    Person person = persons[personId];
    if(person.id != null){
      await PersonDAO().deletePersonById(person.id!);
      setState(() {
        persons.removeAt(personId);
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
                MaterialPageRoute(builder: (context) => AddPerson()))
                .then((person) => {
                  setState((){
                    insertPerson(person);
                  })
                });
            })
        ],
        ),
      body: ListView.separated(
        itemCount: persons.length,
        itemBuilder: ((context, index) => buildListItems(index)),
        separatorBuilder: (context, index) => const Divider(height: 1,)
        )
    );
  }

  Widget buildListItems(int personId){
    Person person = persons[personId];
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5)
          ),
          child: ListTile(
            leading: Text(person.id != null ? person.id.toString() : "-1"),
            title: Text(person.firstName),
            subtitle: Text(person.lastName),
            onLongPress: (){
              deletePerson(personId);
            }
          ),
        ),
      );
  }
}