import 'package:all_persistent_types/utils/customWidgets.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  final Text title = const Text("Flutter Persistência");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title
      ),
      body: ListView(
        children: [
          ListTile(
            leading: buildSvgIcon("images/sqlite-icon.svg"),
            title: const Text("SQLite"),
            subtitle: const Text("Lista de pessoas"),
            trailing: const Icon(Icons.navigate_next),
            onTap: (){
              Navigator.pushNamed(context, "/person");
            },
          ),
          divisorListMain(),
          ListTile(
            leading: buildSvgIcon("images/db.svg"),
            title: const Text("Floor"),
            subtitle: const Text("Lista de livros"),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              Navigator.pushNamed(context, "/book");
            },
          ),
          divisorListMain(),
          ListTile(
            leading: buildSvgIcon("images/firebase-icon.svg"),
            title: const Text("Firebase"),
            subtitle: const Text("Lista de carros"),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              Navigator.pushNamed(context, "/car"); 
            }
          ),
          divisorListMain()
        ]
      ));
  }
}