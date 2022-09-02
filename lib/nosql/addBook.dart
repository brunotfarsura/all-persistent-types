import 'package:all_persistent_types/nosql/models/book.dart';
import 'package:flutter/material.dart';
import 'package:all_persistent_types/sqlite/models/person.dart';

///Add person Widget
class AddBook extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Livro"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: "Name",
                      labelText: "Name"
                  ),
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira o nome do livro';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: "Author",
                      labelText: "Author"
                  ),
                  controller: _authorController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira o autor do livro';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Book person = Book(
                        name: _nameController.text,
                        author: _authorController.text);
                        Navigator.pop(context, person);
                      }
                    },
                    child: const Text('Salvar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}