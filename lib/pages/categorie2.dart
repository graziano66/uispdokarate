import 'package:flutter/material.dart';
import 'package:uispdokarate/constants.dart';
import 'package:uispdokarate/drawer.dart';
import 'package:uispdokarate/global.dart';
import 'package:sqlite3/sqlite3.dart' as sql;

class Categorie2Page extends StatefulWidget {
  const Categorie2Page({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<Categorie2Page> createState() => _PageState();
}

class _PageState extends State<Categorie2Page> {
  String sqlBrowse =
      'SELECT a.id,a.descrizione,a.anno1,a.anno2,a.kata,a.kumite,a.pesoiniziale,a.pesofinale,b.descrizione as cinturada,c.descrizione as cinturaa,a.sesso FROM categorie2 as a left join cinture as b on a.cinturada=b.id left join cinture as c on a.cinturaa=c.id';
  String sqlDelete = 'DELETE FROM categorie2 WHERE id=?';
  String sqlInsert =
      'INSERT INTO CATEGORIE2 (idcategoria,descrizione,anno1,anno2,kata,kumite,pesoiniziale,pesofinale,cinturada,cinturaa,sesso,note) VALUES(?,?,?,?,?,?,?,?,?,?,?,?);';
  String sqlEdit =
      'UPDATE CATEGORIE2 SET idcategoria=?,descrizione=?,anno1=?,anno2=?,kata=?,kumite=?,pesoiniziale=?,pesofinale=?,cinturada=?,cinturaa=?,sesso=?,note=?, WHERE ID=';

  String routeBase = '/categorie2';
  List<String> browseFields = [
    'id',
    'descrizione',
    'anno1',
    'anno2',
    'kata',
    'kumite',
    'pesoiniziale',
    'pesofinale',
    'cinturada',
    'cinturaa',
    'sesso',
//    'note',
  ];
/*
  List<int> browseFieldsSize = [
    50,
    50,
    100,
    100,
    100,
    100,
    100,
    100,
    100,
    100,
    100,
    100,
    100,
    100,
    100,
    100,
    100,
    100,
    100,
    100,
  ];
*/
  List<String> browseCaption = [
    'ID',
    'DESCRIZIONE',
    'DAL',
    'AL',
    'KATA',
    'KUMITE',
    'KG da',
    'KG a',
    'CINTURA DA',
    'CINTURA A',
    'SESSO',
//    'NOTE',
  ];
  List<bool> browseNumeric = [
    false,
    false,
    false,
    false,
    true,
    true,
    true,
    true,
    false,
    false,
    false,
//    false,
  ];
  List<String> browseDelete = ['descrizione', 'note'];
  //int selectedIndex = 2;
  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();
  final double verticalWidth = 20;
  final double horizontalWidth = 20;

  @override
  void initState() {
    super.initState();
  }

  List<DataColumn> getDataColumns() {
    List<DataColumn> columns = [];

    columns.add(const DataColumn(label: Text('')));
    columns.add(const DataColumn(label: Text('')));

    for (var i = 0; i < browseCaption.length; i++) {
      columns.add(
          DataColumn(label: Text(browseCaption[i]), numeric: browseNumeric[i]));
    }
    return columns;
  }

  List<DataRow> getDataRows() {
    List<DataRow> rows = [];
    rows.clear();
    openConnection();
    final sql.ResultSet res = db.select(sqlBrowse);
    var i = 0;
    for (final sql.Row row in res) {
//      print(row);
      String ss = '';
      for (String sss in browseDelete) {
        ss = '$ss ${row[sss].toString()} ';
      }

      DataRow r = DataRow(
        color: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          i++;
          if (i.isEven) {
            return Colors.grey.withOpacity(0.3);
          }
          return null; // Use default value for other states and odd rows.
        }),
        cells: <DataCell>[
          DataCell(
            IconButton(
                icon: const Icon(Icons.edit),
                color: tableButtonColor,
                onPressed: () => {edit(row['id'].toString())}),
          ),
          DataCell(
            IconButton(
                icon: const Icon(Icons.delete),
                color: tableButtonDeleteColor,
                onPressed: () => {delete(row['id'].toString(), ss)}),
          ),
        ],
      );
      for (String s in browseFields) {
        r.cells.add(DataCell(Text(row[s].toString())));
      }
      rows.add(r);
    }
    closeConnection();
    return rows;
  }

  void edit(String id) {
    final TextEditingController idc = TextEditingController();
    final TextEditingController descrizione = TextEditingController();
    final TextEditingController anno = TextEditingController();
    final TextEditingController note = TextEditingController();

    var titolo = 'Errore nel recupero dei dati';
    if (id == '-1') {
      titolo = 'Nuova categoria';
      idc.text = '-1';
      descrizione.text = '';
      anno.text = '';
      note.text = '';
    } else {
      titolo = 'Modifica Categoria';
      openConnection();
      final sql.ResultSet res =
          db.select('SELECT * FROM CATEGORIE WHERE ID= ?', [id]);
      for (final sql.Row row in res) {
        idc.text = row['id'].toString();
        descrizione.text = row['descrizione'].toString();
        anno.text = row['anno'].toString();
        note.text = row['note'].toString();
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
                createSizedEditText('DESCRIZIONE', descrizione, 400),
                createSizedEditText('ANNO', anno, 160),
              ],
            ),
            createSizedEditText('NOTE', note, 560),
          ],
        ),
        actions: <Widget>[
          // CONFERMA DIALOGO
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              var sql = '';
              if (idc.text == '-1') {
                sql = sqlInsert;
              } else {
                sql = sqlEdit + idc.text;
              }
              openConnection();
              db.execute(sql, [descrizione.text, anno.text, note.text]);
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
        content: Text('Cancello il record $id - $nome ?'),
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
//    db.execute(sqlDelete2, [id]);
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
            Text(widget.title),
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
/*
            Expanded(
              flex: 5,
              child: InteractiveViewer(
                constrained: false,
                child: DataTable(
                  rows: getDataRows(),
                  columns: getDataColumns(),
                ),
              ),
            ),
*/
            Expanded(
              flex: 5,
              child: Scrollbar(
                controller: verticalScroll,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  controller: verticalScroll,
                  child: Scrollbar(
                    scrollbarOrientation: ScrollbarOrientation.bottom,
                    thumbVisibility: true,
                    controller: horizontalScroll,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: horizontalScroll,
                      child: DataTable(
                        columnSpacing: 8,
                        dataRowHeight: 40,
                        headingRowHeight: 40,
//                        headingRowColor: Colors.red,
                        rows: getDataRows(),
                        columns: getDataColumns(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
