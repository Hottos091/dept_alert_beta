import 'package:dept_alert_beta/bloc/contact_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dept_alert_beta/events/contact_event.dart';
import 'package:dept_alert_beta/model/contact.dart';

class ContactList extends StatelessWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return SingleChildScrollView(
      padding : const EdgeInsets.all(14),
      child: BlocConsumer<ContactBloc, List<Contact>>(
        builder: (context, state) {//state is a List<Contact> 
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(14),
            itemCount: state.length,
            itemBuilder: (context, index) {
              return Card (
                child: ListTile(
                  title: Text(state[index].firstname),
                ),
              );
            },
          );
        },
        listener: (context, state) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Action performed !"),
          duration: Duration(milliseconds: 800),
          ));
        }
      )
    );
  }
}