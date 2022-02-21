import 'package:sqflite/sqflite.dart';

import '../../models/contact.dart';
import '../app_database.dart';

class ContactDao{

  static const String tableSql = 'CREATE TABLE contacts('
      '$_id INTEGER PRIMARY KEY,'
      '$_name TEXT,'
      '$_accountNumber INTEGER)';
  static const String _tableName = 'contacts';
  static const String _accountNumber = 'account_number';
  static const String _name = 'name';
  static const String _id = 'id';

  //funcao para salvar o contato na db
  Future<int> save(Contact contact) async {
    final Database db = await getDatabase();
    Map<String, dynamic> contactMap = toMap(contact);
    //insere o dado na db
    return db.insert(_tableName, contactMap);


    // return createDatabase().then((db) {
    //   //precisa criar um mapa para usar o insert
    //   final Map<String, dynamic> contactMap = {};
    //   //define o que vai para o mapa
    //   contactMap['id'] = contact.id;
    //   contactMap['name'] = contact.name;
    //   contactMap['account_number'] = contact.accountNumber;
    //   //insere o dado na db
    //   return db.insert('contacts', contactMap);
    // });
  }

  Map<String, dynamic> toMap(Contact contact) {
    final Map<String, dynamic> contactMap = {};
    //define o que vai para o mapa

    //se tirar o preenchimento do ID o sqflite adiciona um id sozinho
    // contactMap['id'] = contact.id;
    contactMap[_name] = contact.name;
    contactMap[_accountNumber] = contact.accountNumber;
    return contactMap;
  }

  Future<List<Contact>> findAll() async{

    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Contact> contacts = toList(result);
    return contacts;

    // return getDatabase().then((db) {
    //   return db.query('contacts').then((maps) {
    //     final List<Contact> contacts = [];
    //     for (Map<String, dynamic> map in maps) {
    //       final Contact contact =
    //       Contact(map['name'], map['account_number'], map['id']);
    //       contacts.add(contact);
    //     }
    //     return contacts;
    //   });
    // });
  }

  List<Contact> toList(List<Map<String, dynamic>> result) {
    final List<Contact> contacts = [];

    for (Map<String, dynamic> row in result) {
      final Contact contact =
      Contact(row[_name], row[_accountNumber], row[_id]);
      contacts.add(contact);
    }
    return contacts;
  }
}