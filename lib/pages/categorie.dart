import 'package:flutter/material.dart';
import 'package:uispdokarate/drawer.dart';
import 'package:uispdokarate/global.dart';
import 'package:sqlite3/sqlite3.dart' as sql;

class CategoriePage extends StatefulWidget {
  const CategoriePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<CategoriePage> createState() => _PageState();
}

class _PageState extends State<CategoriePage> {
  String sqlBrowse = 'SELECT * FROM categorie';
  String sqlDelete = 'DELETE FROM categorie WHERE id=?';
  String sqlDelete2 = 'DELETE FROM categorie2 WHERE idcategoria=?';
  String sqlInsert =
      'INSERT INTO CATEGORIE (DESCRIZIONE,ANNO,NOTE) VALUES(?,?,?)';
  String sqlEdit = 'UPDATE CATEGORIE SET DESCRIZIONE=?,ANNO=?,NOTE=? WHERE ID=';
  String routeBase = '/categorie';
//  List<String> browseFields = ['id', 'descrizione', 'anno', 'note'];
//  List<int> browseFieldsSize = [100, 100, 100, 100, 100];
//  List<String> browseCaption = ['ID', 'DESCRIZIONE', 'ANNO', 'NOTE'];
  List<String> browseDelete = ['descrizione', 'anno', 'note'];
//  int selectedIndex = 2;

  @override
  void initState() {
    super.initState();
  }

  List<Widget> getDataLists() {
    List<Widget> rows = [];
    rows.clear();
    openConnection();
    final sql.ResultSet res = db.select(sqlBrowse);

    // Ciclo che carica i dati nella lista
    for (final sql.Row row in res) {
      // ss contiene la scritta per il delete
      String ss = '';
      for (String sss in browseDelete) {
        ss = ss + row[sss].toString() + ' ';
      }

      ListTile l = ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
        leading: SizedBox(
          width: 80,
          child: Row(
            children: [
              IconButton(
                  //padding: EdgeInsets.all(8),
                  icon: const Icon(Icons.edit),
                  color: Colors.green,
                  onPressed: () => {edit(row['id'].toString())}),
              IconButton(
                  //padding: EdgeInsets.all(8),
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () => {delete(row['id'].toString(), ss)}),
            ],
          ),
        ),
        title: Text(
          'ID:   ' +
              row['id'].toString() +
              '     Descrizione:  ' +
              row['descrizione'].toString(),
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Row(
          children: <Widget>[
            //Icon(Icons.delete, color: Colors.yellowAccent),
            Text(
                'Anno:   ' +
                    row['anno'].toString() +
                    '     Note:   ' +
                    row['note'].toString(),
                style: const TextStyle(color: Colors.white))
          ],
        ),
        trailing: IconButton(
            //padding: EdgeInsets.all(8),
            icon: const Icon(Icons.keyboard_arrow_right),
            color: Colors.green,
            onPressed: () {
              categorie2id = row['id'].toString();
              categorie2title= row['descrizione'].toString()+' / '+row['note'].toString();
              print(categorie2id);
              Navigator.pushNamedAndRemoveUntil(
                  context, '/categorie2', (route) => false);
            }),
      );

      Card c = Card(
        elevation: 8.0,
        margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: Container(
          decoration:
              const BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
          child: l,
        ),
      );

      rows.add(c);
    }
    closeConnection();
    return rows;
  }

  void edit(String id) {
    final TextEditingController _id = TextEditingController();
    final TextEditingController _descrizione = TextEditingController();
    final TextEditingController _anno = TextEditingController();
    final TextEditingController _note = TextEditingController();

    var titolo = 'Errore nel recupero dei dati';
    if (id == '-1') {
      titolo = 'Nuova categoria';
      _id.text = '-1';
      _descrizione.text = '';
      _anno.text = '';
      _note.text = '';
    } else {
      titolo = 'Modifica Categoria';
      openConnection();
      final sql.ResultSet res =
          db.select('SELECT * FROM CATEGORIE WHERE ID= ?', [id]);
      for (final sql.Row row in res) {
        _id.text = row['id'].toString();
        _descrizione.text = row['descrizione'].toString();
        _anno.text = row['anno'].toString();
        _note.text = row['note'].toString();
      }
      closeConnection();
    }

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.blueGrey,
        title: Text(titolo),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                createSizedEditText('DESCRIZIONE', _descrizione, 400),
                createSizedEditText('ANNO', _anno, 160),
              ],
            ),
            createSizedEditText('NOTE', _note, 560),
          ],
        ),
        actions: <Widget>[
          // CONFERMA DIALOGO
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              var sql = '';
              if (_id.text == '-1') {
                sql = sqlInsert;
              } else {
                sql = sqlEdit + _id.text;
              }
              openConnection();
              db.execute(sql, [_descrizione.text, _anno.text, _note.text]);
              closeConnection();
              Navigator.pushNamedAndRemoveUntil(
                  context, routeBase, (route) => false);
            },
          ),
          // ANNULLA DIALOGO
          ElevatedButton(
            child: const Text('ANNULLA'),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context, routeBase, (route) => false),
          ),
        ],
      ),
    );
  }

  void delete(String id, String nome) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.redAccent,
        title: const Text('CONFERMA LA CANCELLAZIONE'),
        content: Text('Cancello il record ' + id + ' ' + nome + ' ?'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => deleteOk(id),
            child: const Text('OK'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context, routeBase, (route) => false),
            child: const Text('ANNULLA'),
          ),
        ],
      ),
    );
  }

  void deleteOk(String id) async {
    openConnection();
    db.execute(sqlDelete2, [id]);
    db.execute(sqlDelete, [id]);
    closeConnection();
    Navigator.pushNamedAndRemoveUntil(context, routeBase, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawer(),
      appBar: AppBar(
        title: Row(
          children: [
            Text(widget.title + ' '),
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'NUOVA',
              onPressed: () {
                edit('-1');
              },
            ),
            IconButton(
              icon: const Icon(Icons.print),
              tooltip: 'STAMPA',
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('PRINT')));
              },
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'NUOVA CATEGORIA',
            onPressed: () {
              edit('-1');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Row(
          children: [
            if (isDesktop(context))
              const Expanded(
                // flex: 1, (default)
                child: NavigationDrawer(),
              ),

            Expanded(
              flex: 5,
//              child: SingleChildScrollView(
//                padding: const EdgeInsets.all(defaultPadding),
              child: ListView(
                children: getDataLists(),
              ),
            ),
//            ),
          ],
        ),
      ),
    );
  }
}
