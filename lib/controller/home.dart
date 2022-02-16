import 'package:dept_alert_beta/model/databaseClientTest.dart';
import 'package:flutter/material.dart';
import 'package:dept_alert_beta/model/contact.dart';
import 'package:dept_alert_beta/widgets/newCustomerContainer.dart';
import 'package:sqflite/sqflite.dart';
import 'package:async/async.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Contact> contacts = [];


  @override void initState() {
    // TODO: implement initState
    super.initState();
    fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(widget.title),
        actions: <Widget>[
          ElevatedButton(onPressed: showAddContactDialog, child: const Text("Add"))
        ],
      ),
      body:
      (contacts.isEmpty) ? const Center(child: Text("il n'y a pas de contact dans la DB", textScaleFactor: 2,)) : ListView.builder(
        itemCount:  contacts.length,
        itemBuilder: (context, i) {
          Contact contact = contacts[i];
          return ListTile(
            title: Text('${contact.emailAddress} - ${contact.firstname} ${contact.lastname} (${contact.id})'),
          );
        },
      ),
    );
  }

  Future showAddContactDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return NewCustomerContainer(dialogContext: dialogContext);
      },
    );
    fetchContacts();
  }

  void fetchContacts() {
    DatabaseClient.instance.getAllContacts().then((contacts) {
      setState(() {
        this.contacts = contacts;
      });
    });
  }
}
