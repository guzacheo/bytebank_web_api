import 'package:flutter/material.dart';

import '../database/dao/contact_dao.dart';
import '../models/contact.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final ContactDao _dao = ContactDao();
  final TextEditingController _accountNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Contato"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Nome Completo",
                  ),
                  style: const TextStyle(
                      fontSize: 24.0
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  controller: _accountNumberController,
                  decoration: const InputDecoration(
                    labelText: "Numero da Conta",
                  ),
                  style: const TextStyle(
                      fontSize: 24.0
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 26.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () {
                      final String name = _nameController.text;
                      final int? accountNumber = int.tryParse(_accountNumberController.text);
                      final newContact = Contact(name, accountNumber!, 0);
                      _dao.save(newContact).then((id) => Navigator.pop(context));
                    },
                    child: const Text("Criar"),
                  ),
                ),
              ),
            ],)
      ),
    );
  }
}
