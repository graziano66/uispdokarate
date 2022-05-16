import 'package:flutter/material.dart';
import 'package:uispdokarate/drawer.dart';
import 'package:uispdokarate/global.dart';
import 'package:uispdokarate/sql.dart';

class DbErrorPage extends StatefulWidget {
  const DbErrorPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<DbErrorPage> createState() => _DbErrorPageState();
}

class _DbErrorPageState extends State<DbErrorPage> {
  @override
  Widget build(BuildContext context) {
//    if (conn!=null) { conn?.close(); }
    return Scaffold(
        drawer: const NavigationDrawer(),
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(dbError.toString() + '-' + dbErrorString),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  'Se è la prima volta che usi il programma va tutto bene'),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  'il database viene creato adesso, altrimenti controlla'),
              const SizedBox(
                height: 10,
              ),
              const Text('se ci sono problemi nei file del programma.'),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                //OutlinedButton(
                onPressed: () {
                  creaDatabase();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                },
                child: const Text('CREA DATABASE'),
              ),
            ],
          ),
        ));
  }
}
