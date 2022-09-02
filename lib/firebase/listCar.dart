import 'package:all_persistent_types/firebase/addCar.dart';
import 'package:all_persistent_types/firebase/models/car.dart';
import 'package:all_persistent_types/nosql/addBook.dart';
import 'package:all_persistent_types/nosql/daos/bookDao.dart';
import 'package:all_persistent_types/nosql/database/appDatabase.dart';
import 'package:all_persistent_types/nosql/models/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class ListCar extends StatefulWidget {
  const ListCar({Key? key}) : super(key: key);

  final Text title = const Text("Carros");

  @override
  _ListCarState createState() => _ListCarState();
}

class _ListCarState extends State<ListCar> {
  List<Car> cars = <Car>[];

  @override
  void initState(){
    super.initState();
  }

  insertCar(Car car) async{
    FirebaseFirestore.instance.collection("Cars").add(car.toJson());
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
                MaterialPageRoute(builder: (context) => AddCar()))
                .then((car) => {
                  setState((){
                    insertCar(car);
                  })
                });
            })
        ],
        ),
      body: buildList(context)
    );
  }

  Widget buildList(BuildContext buildContext){
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("Cars").snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData) return const LinearProgressIndicator();
        if(snapshot.data == null){
          return Container(child: const Text("Nenhum carro encontrado"));
        }else {
          return buildListView(context, snapshot.data!.docs);
        }
      });
  }

  Widget buildListView(BuildContext buildContext, List<QueryDocumentSnapshot> snapshot){
    return ListView(padding: EdgeInsets.only(top: 30),
    children: snapshot.map((data) => buildListItems(buildContext, data)).toList());
  }

  Widget buildListItems(BuildContext buildContext, QueryDocumentSnapshot queryDocumentSnapshot){
    Car car = Car.fromSnapshot(queryDocumentSnapshot);
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5)
          ),
          child: ListTile(
            //leading: Text(car.id != null ? car.id.toString() : "-1"),
            title: Text(car.name),
            subtitle: Text(car.brand),
            onLongPress: (){
              queryDocumentSnapshot.reference.delete();
            }
          ),
        ),
      );
  }
}