import 'package:dept_alert_beta/model/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class DatabaseClient {
  static final DatabaseClient instance = DatabaseClient._init();

  static Database? _database;

  DatabaseClient._init();

  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await _initDB('test.db');
    return _database!;
  }

  /*Future openDb(String path) async {
    database = await openDatabase(path, version: 1, onCreate: (Database database, int version) async {
      await database.execute('''
     CREATE TABLE CONTACT (
        _id INTEGER PRIMARY KEY AUTOINCREMENT
      , firstname TEXT NOT NULL
      , lastname TEXT NOT NULL
      , email_address TEXT NOT NULL
    ''');
    });
  }*/

  Future<Database> _initDB(String filePath) async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future _createDatabase(Database db, int version) async {
    await db.execute('''
     CREATE TABLE $tableContacts (
        ${ContactFields.id} INTEGER PRIMARY KEY AUTOINCREMENT
      , ${ContactFields.firstname} TEXT NOT NULL
      , ${ContactFields.lastname} TEXT NOT NULL
      , ${ContactFields.emailAddress} TEXT NOT NULL
    )''');
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  Future<Contact> insertContact(Contact contact) async {
    final db = await instance.database;

    print('[IN] insertContact() [BEFORE] await db.insert - contact.id = ${contact.id}');
    contact.id = await db.insert(tableContacts, contact.toMap());
    print('[IN] insertContact() [AFTER] await db.insert - contact.id = ${contact.id}');


    return contact;
  }

  Future<Contact?> selectContact(int id) async {
    final db = await instance.database;

    List<Map<String, dynamic>> maps = await db.query('CONTACT',
        columns: ['_id', 'firstname', 'lastname', 'email_address'],
        where: '${ContactFields.id} = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Contact.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
    //return null;
  }

  Future<List<Contact>> getAllContacts() async {
    final db = await instance.database;

    List<Map<String, dynamic>> queryResult = await db.rawQuery('SELECT * FROM $tableContacts ORDER BY ${ContactFields.id}');
    List<Contact> contacts = [];

    for (var sqlContact in queryResult) {
      Contact contact = Contact.fromMap(sqlContact);
      contacts.add(contact);
    }
    return contacts;
  }
}