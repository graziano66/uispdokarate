import 'package:flutter/material.dart';
import 'package:uispdokarate/drawer.dart';
import 'package:uispdokarate/global.dart';
import 'package:sqlite3/sqlite3.dart' as sql;

class XXXPage extends StatefulWidget {
  const XXXPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<XXXPage> createState() => _XXXPageState();
}

class _XXXPageState extends State<XXXPage> {
  String sqlBrowse = 'SELECT * FROM categorie';
  String sqlDelete = 'DELETE FROM categorie WHERE id=?';
  String routeEdit = '/categorieed';
  String routeBase = '/categorie';
  List<String> browseFields = ['id', 'descrizione', 'anno', 'note'];
  List<int> browseFieldsSize = [100, 100, 100, 100, 100];
  List<String> browseCaption = ['ID', 'DESCRIZIONE', 'ANNO', 'NOTE'];
  List<String> browseDelete = ['descrizione', 'anno', 'note'];
  int selectedIndex = 2;

  @override
  void initState() {
    super.initState();
  }

  List<DataColumn> getDataColumns() {
    List<DataColumn> columns = [];

    columns.add(const DataColumn(label: Text('')));
    columns.add(const DataColumn(label: Text('')));
    for (String s in browseFields) {
      columns.add(DataColumn(label: Text(s)));
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
      String ss = '';
      for (String sss in browseDelete) {
        ss = ss + row[sss].toString() + ' ';
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
                color: Colors.black54,
                onPressed: () => {edit(row['id'].toString())}),
          ),
          DataCell(
            IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.black54,
                onPressed: () => {delete(row['id'].toString(), ss)}),
          ),
        ],
      );
      for (String s in browseFields) {
        r.cells.add(DataCell(Text(row[s].toString()), onTap: () {
          print(row['id'].toString());
        }));
      }
      rows.add(r);
    }
    closeConnection();
    return rows;
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
          contentPadding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
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
            'ID:   '+row['id'].toString() + '     Descrizione:  ' + row['descrizione'].toString(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

          subtitle: Row(
            children: <Widget>[
              //Icon(Icons.delete, color: Colors.yellowAccent),
              Text('Anno:   '+row['anno'].toString() + '     Note:   ' + row['note'].toString(),
                  style: const TextStyle(color: Colors.white))
            ],
          ),
          trailing: const Icon(Icons.keyboard_arrow_right,
              color: Colors.white, size: 30.0));

      Card c = Card(
        elevation: 8.0,
        margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: Container(
          decoration: const BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
          child: l,
        ),
      );

      rows.add(c);
    }
    closeConnection();
    return rows;
  }

  void edit(String id) {
    editID = id;
    Navigator.pushNamedAndRemoveUntil(context, routeEdit, (route) => false);
  }

  void insert() {
    editID = '-1';
    Navigator.pushNamedAndRemoveUntil(context, routeEdit, (route) => false);
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
                insert();
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
              insert();
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
//              child: SingleChildScrollView(
//                padding: const EdgeInsets.all(defaultPadding),
              child: ListView(
                children: getDataLists(),
              ),
            ),
//            ),
*/
            Expanded(
              
              flex: 5,
              
              child: 
 SingleChildScrollView(
//                scrollDirection: Axis.horizontal,
// child: SingleChildScrollView(
//                scrollDirection: Axis.vertical,
//                padding: const EdgeInsets.all(defaultPadding),
              child: 
              DataTable(

                rows: getDataRows(), 
                columns: getDataColumns(),
              ),
            ),
            ),
          ],
        ),
      ),

/*
          child: DataTable(
            columnSpacing: 10,
            columns: getColumns(browseCaption),
            rows: getData(),
          ),
*/
    );
  }
}


/*

ListTile(
  leading:
  trailing:
  title:
  subtitle:


)


*/