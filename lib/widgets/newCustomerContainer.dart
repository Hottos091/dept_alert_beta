import 'package:flutter/material.dart';
import 'package:dept_alert_beta/model/contact.dart';
import 'package:dept_alert_beta/model/databaseClientTest.dart';

class NewCustomerContainer extends StatefulWidget {
  final BuildContext dialogContext;

  const NewCustomerContainer({Key? key, required this.dialogContext}) : super(key: key);

  @override
  State<NewCustomerContainer> createState() => _NewCustomerContainerState();
}

class _NewCustomerContainerState extends State<NewCustomerContainer> {
  late TextEditingController firstnameTextEditingController;
  late TextEditingController lastnameTextEditingController;
  late TextEditingController emailAddressTextEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    firstnameTextEditingController = TextEditingController();
    lastnameTextEditingController = TextEditingController();
    emailAddressTextEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ajouter un contact'),
      content: getInputContent(),
      actions: <Widget>[
        TextButton(
          child: const Text('Annuler', style: TextStyle(color: Colors.red)),
          onPressed: () {
            Navigator.of(widget.dialogContext).pop(); // Dismiss alert dialog
          },
        ),
        TextButton(
          child: const Text('Confirmer', style: TextStyle(color: Colors.blue)),
          onPressed: () {
            addContact();
            Navigator.of(widget.dialogContext).pop();
            setState(() {

            });// Dismiss alert dialog
          },
        ),
      ],

    );
  }

  Future<void> addContact() async {
    Contact contact = Contact(firstname: getFirstname(), lastname: getLastname(), emailAddress: getEmailAddress());
    print('[IN] AddContact() : contact.id = ${contact.id}');
    await DatabaseClient.instance.insertContact(contact);
  }



  Card getInputContent() {
    return Card(
        child: Column(
            children: [
              TextField(
                controller: firstnameTextEditingController,
                decoration: const InputDecoration(
                  labelText: 'Prénom: ',
                  hintText: 'Entrez votre prénom.',
                ),
              ),
              TextField(
                controller: lastnameTextEditingController,
                decoration: const InputDecoration(
                  labelText: 'Nom: ',
                  hintText: 'Entrez votre nom.',
                ),
              ),
              TextField(
                controller: emailAddressTextEditingController,
                decoration: const InputDecoration(
                  labelText: 'Email: ',
                  hintText: 'Entrez votre adresse email.',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ]
        )
    );
  }

  String getFirstname() => firstnameTextEditingController.text;

  String getLastname() => lastnameTextEditingController.text;

  String getEmailAddress() => emailAddressTextEditingController.text;
}