import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dao/contact_dao.dart';

//funcao para criar a base de dados
//o async indica que tudo que estiver na funcao sera executado dentro de um future
Future<Database> getDatabase() async {
  //await executa o then e devolve o valor para a variavel
  //await segura a execucao assincronas
  final String path = join(await getDatabasesPath(), 'bytebank.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      //codigo em sql para criar a tabela de contatos
      //nome em minusculo e os tipos em maiusculo
      db.execute(ContactDao.tableSql);
    },
    version: 1,
    // onDowngrade: onDatabaseDowngradeDelete,
  );

//trabalhando de forma assincrona com o future
  // //pega o camingo do sqflite, tipo FUTURE
  // return getDatabasesPath().then((dbPath) {
  //   //cria o arquivo usando a funcao join no caminho dbPath
  //   final String path = join(dbPath, 'bytebank.db');
  //   //abre a data base que foi criada para determinar as tabelas e a versao da database
  //   return openDatabase(
  //     path,
  //     onCreate: (db, version) {
  //       //codigo em sql para criar a tabela de contatos
  //       //nome em minusculo e os tipos em maiusculo
  //       db.execute('CREATE TABLE contacts('
  //           'id INTEGER PRIMARY KEY,'
  //           'name TEXT,'
  //           'account_number INTEGER)');
  //     },
  //     version: 1,
  //     // onDowngrade: onDatabaseDowngradeDelete,
  //   );
  // });
}

// Data Access Object - DAO
//tem os comportamentos de uma entidade, tipo salvar etc


