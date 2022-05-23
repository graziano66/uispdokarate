import 'package:uispdokarate/global.dart';

int testDatabase(int index) {
  dbErrorClear();
  try {
    openConnection();
    var sqlQuery = 'SELECT * FROM controllo';
//    final sql.ResultSet res = db.select(sqlQuery);
    db.select(sqlQuery);
  } catch (e) {
    dbErrorSet('Database non trovato');
    return (98);
  }
  closeConnection();
  return (index);
}

int creaDatabase() {
  try {
    openConnection();
    creaCategorie();
    creaCategorie2();
    creaCinture();
    creaGare();
    creaGare2();
    creaControllo();
  } catch (e) {
    return (-1);
  }
  closeConnection();
  return (0);
}

void creaControllo() {
  dbErrorClear();
  try {
    db.execute('''
      CREATE TABLE controllo (
        id INTEGER NOT NULL PRIMARY KEY,
        descrizione TEXT NOT NULL
      ); 
    ''');

    db.execute('''
      INSERT INTO controllo (id, descrizione) VALUES
	      (1, 'Creazione tabelle anno 2021-2022');
    ''');
  } catch (e) {
    dbErrorSet(e.toString());
  }
}

void creaCategorie() {
  dbErrorClear();
  try {
    db.execute('''
      CREATE TABLE categorie (
        id INTEGER NOT NULL PRIMARY KEY,
        descrizione TEXT NOT NULL,
        anno TEXT NOT NULL,
        note TEXT NOT NULL
      ); 
    ''');

    db.execute('''
      INSERT INTO categorie (id, descrizione, anno, note) VALUES
	      (1, '2021-2022', '2021-2022', 'Regolamento base per la stagione 2021-2022');
    ''');
  } catch (e) {
    dbErrorSet(e.toString());
  }
}

void creaCategorie2() {
  dbErrorClear();
  try {
    db.execute('''
      CREATE TABLE categorie2 (
        id INTEGER NOT NULL PRIMARY KEY,
        idcategoria INTEGER NOT NULL,
        descrizione TEXT NOT NULL,
        anno1 INTEGER NOT NULL,
        anno2 INTEGER NOT NULL,
        kata INTEGER NOT NULL,
        kumite INTEGER NOT NULL,
        pesoiniziale INTEGER NOT NULL,
        pesofinale INTEGER NOT NULL,
        cinturada INTEGER NOT NULL,
        cinturaa INTEGER NOT NULL,
        sesso TEXT NOT NULL,
        note TEXT NOT NULL
      );
    ''');

    db.execute('''
      INSERT INTO categorie2 (idcategoria, descrizione, anno1, anno2, kata, kumite, pesoiniziale, pesofinale, cinturada, cinturaa, sesso, note) VALUES
        ( 1, 'Fascia Aee', 2016, 2014, 1, 0, 0.00, 0.00, 1, 1, 'M', 'Bianca'),
        ( 1, 'Fascia A', 2016, 2014, 1, 0, 0.00, 0.00, 2, 3, 'M', 'Gialla/Arancio'),
        ( 1, 'Fascia A', 2016, 2014, 1, 0, 0.00, 0.00, 4, 5, 'M', 'Verde/Blu'),
        ( 1, 'Fascia A', 2016, 2014, 1, 0, 0.00, 0.00, 1, 1, 'F', 'Bianca'),
        ( 1, 'Fascia A', 2016, 2014, 1, 0, 0.00, 0.00, 2, 3, 'F', 'Gialla/Arancio'),
        ( 1, 'Fascia A', 2016, 2014, 1, 0, 0.00, 0.00, 4, 5, 'F', 'Verde/Blu'),
        ( 1, 'Fascia B', 2013, 2012, 1, 0, 0.00, 0.00, 1, 1, 'M', 'Bianca'),
        ( 1, 'Fascia B', 2013, 2012, 1, 0, 0.00, 0.00, 2, 3, 'M', 'Gialla/Arancio'),
        ( 1, 'Fascia B', 2013, 2012, 1, 0, 0.00, 0.00, 4, 5, 'M', 'Verde/Blu'),
        ( 1, 'Fascia B', 2013, 2012, 1, 0, 0.00, 0.00, 6, 6, 'M', 'Marrone'),
        ( 1, 'Fascia B', 2013, 2012, 1, 0, 0.00, 0.00, 1, 1, 'F', 'Bianca'),
        ( 1, 'Fascia B', 2013, 2012, 1, 0, 0.00, 0.00, 2, 3, 'F', 'Gialla/Arancio'),
        ( 1, 'Fascia B', 2013, 2012, 1, 0, 0.00, 0.00, 4, 5, 'F', 'Verde/Blu'),
        ( 1, 'Fascia B', 2013, 2012, 1, 0, 0.00, 0.00, 6, 6, 'F', 'Marrone'),
        ( 1, 'Fascia C', 2011, 2010, 1, 0, 0.00, 0.00, 1, 1, 'M', 'Bianca'),
        ( 1, 'Fascia C', 2011, 2010, 1, 0, 0.00, 0.00, 2, 3, 'M', 'Gialla/Arancio'),
        ( 1, 'Fascia C', 2011, 2010, 1, 0, 0.00, 0.00, 4, 5, 'M', 'Verde/Blu'),
        ( 1, 'Fascia C', 2011, 2010, 1, 0, 0.00, 0.00, 6, 7, 'M', 'Marrone/Nera'),
        ( 1, 'Fascia C', 2011, 2010, 1, 0, 0.00, 0.00, 1, 1, 'F', 'Bianca'),
        ( 1, 'Fascia C', 2011, 2010, 1, 0, 0.00, 0.00, 2, 3, 'F', 'Gialla/Arancio'),
        ( 1, 'Fascia C', 2011, 2010, 1, 0, 0.00, 0.00, 4, 5, 'F', 'Verde/Blu'),
        ( 1, 'Fascia C', 2011, 2010, 1, 0, 0.00, 0.00, 6, 7, 'F', 'Marrone/Nera'),
        ( 1, 'Esordienti dal 13mo al 14mo anno', 2009, 2008, 1, 0, 0.00, 0.00, 1, 1, 'M', 'Bianca'),
        ( 1, 'Esordienti dal 13mo al 14mo anno', 2009, 2008, 1, 0, 0.00, 0.00, 2, 3, 'M', 'Gialla/Arancio'),
        ( 1, 'Esordienti dal 13mo al 14mo anno', 2009, 2008, 1, 0, 0.00, 0.00, 4, 5, 'M', 'Verde/Blu'),
        ( 1, 'Esordienti dal 13mo al 14mo anno', 2009, 2008, 1, 0, 0.00, 0.00, 6, 7, 'M', 'Marrone/Nera'),
        ( 1, 'Esordienti dal 13mo al 14mo anno', 2009, 2008, 1, 0, 0.00, 0.00, 1, 1, 'F', 'Bianca'),
        ( 1, 'Esordienti dal 13mo al 14mo anno', 2009, 2008, 1, 0, 0.00, 0.00, 2, 3, 'F', 'Gialla/Arancio'),
        ( 1, 'Esordienti dal 13mo al 14mo anno', 2009, 2008, 1, 0, 0.00, 0.00, 4, 5, 'F', 'Verde/Blu'),
        ( 1, 'Esordienti dal 13mo al 14mo anno', 2009, 2008, 1, 0, 0.00, 0.00, 6, 7, 'F', 'Marrone/Nera'),
        ( 1, 'Cadetti dal 15mo al 16mo anno', 2007, 2006, 1, 0, 0.00, 0.00, 1, 1, 'M', 'Bianca'),
        ( 1, 'Cadetti dal 15mo al 16mo anno', 2007, 2006, 1, 0, 0.00, 0.00, 2, 3, 'M', 'Gialla/Arancio'),
        ( 1, 'Cadetti dal 15mo al 16mo anno', 2007, 2006, 1, 0, 0.00, 0.00, 4, 5, 'M', 'Verde/Blu'),
        ( 1, 'Cadetti dal 15mo al 16mo anno', 2007, 2006, 1, 0, 0.00, 0.00, 6, 6, 'M', 'Marrone'),
        ( 1, 'Cadetti dal 15mo al 16mo anno', 2007, 2006, 1, 0, 0.00, 0.00, 7, 7, 'M', 'Nera'),
        ( 1, 'Cadetti dal 15mo al 16mo anno', 2007, 2006, 1, 0, 0.00, 0.00, 1, 1, 'F', 'Bianca'),
        ( 1, 'Cadetti dal 15mo al 16mo anno', 2007, 2006, 1, 0, 0.00, 0.00, 2, 3, 'F', 'Gialla/Arancio'),
        ( 1, 'Cadetti dal 15mo al 16mo anno', 2007, 2006, 1, 0, 0.00, 0.00, 4, 5, 'F', 'Verde/Blu'),
        ( 1, 'Cadetti dal 15mo al 16mo anno', 2007, 2006, 1, 0, 0.00, 0.00, 6, 6, 'F', 'Marrone'),
        ( 1, 'Cadetti dal 15mo al 16mo anno', 2007, 2006, 1, 0, 0.00, 0.00, 7, 7, 'F', 'Nera'),
        ( 1, 'Speranze dal 17mo al 19mo anno', 2005, 2003, 1, 0, 0.00, 0.00, 1, 1, 'M', 'Bianca'),
        ( 1, 'Speranze dal 17mo al 19mo anno', 2005, 2003, 1, 0, 0.00, 0.00, 2, 3, 'M', 'Gialla/Arancio'),
        ( 1, 'Speranze dal 17mo al 19mo anno', 2005, 2003, 1, 0, 0.00, 0.00, 4, 5, 'M', 'Verde/Blu'),
        ( 1, 'Speranze dal 17mo al 19mo anno', 2005, 2003, 1, 0, 0.00, 0.00, 6, 6, 'M', 'Marrone'),
        ( 1, 'Speranze dal 17mo al 19mo anno', 2005, 2003, 1, 0, 0.00, 0.00, 7, 7, 'M', 'Nera'),
        ( 1, 'Speranze dal 17mo al 19mo anno', 2005, 2003, 1, 0, 0.00, 0.00, 1, 1, 'F', 'Bianca'),
        ( 1, 'Speranze dal 17mo al 19mo anno', 2005, 2003, 1, 0, 0.00, 0.00, 2, 3, 'F', 'Gialla/Arancio'),
        ( 1, 'Speranze dal 17mo al 19mo anno', 2005, 2003, 1, 0, 0.00, 0.00, 4, 5, 'F', 'Verde/Blu'),
        ( 1, 'Speranze dal 17mo al 19mo anno', 2005, 2003, 1, 0, 0.00, 0.00, 6, 6, 'F', 'Marrone'),
        ( 1, 'Speranze dal 17mo al 19mo anno', 2005, 2003, 1, 0, 0.00, 0.00, 7, 7, 'F', 'Nera'),
        ( 1, 'Juniores dal 20mo al 23mo anno', 2002, 1999, 1, 0, 0.00, 0.00, 1, 1, 'M', 'Bianca'),
        ( 1, 'Juniores dal 20mo al 23mo anno', 2002, 1999, 1, 0, 0.00, 0.00, 2, 3, 'M', 'Gialla/Arancio'),
        ( 1, 'Juniores dal 20mo al 23mo anno', 2002, 1999, 1, 0, 0.00, 0.00, 4, 5, 'M', 'Verde/Blu'),
        ( 1, 'Juniores dal 20mo al 23mo anno', 2002, 1999, 1, 0, 0.00, 0.00, 6, 6, 'M', 'Marrone'),
        ( 1, 'Juniores dal 20mo al 23mo anno', 2002, 1999, 1, 0, 0.00, 0.00, 7, 7, 'M', 'Nera'),
        ( 1, 'Juniores dal 20mo al 23mo anno', 2002, 1999, 1, 0, 0.00, 0.00, 1, 1, 'F', 'Bianca'),
        ( 1, 'Juniores dal 20mo al 23mo anno', 2002, 1999, 1, 0, 0.00, 0.00, 2, 3, 'F', 'Gialla/Arancio'),
        ( 1, 'Juniores dal 20mo al 23mo anno', 2002, 1999, 1, 0, 0.00, 0.00, 4, 5, 'F', 'Verde/Blu'),
        ( 1, 'Juniores dal 20mo al 23mo anno', 2002, 1999, 1, 0, 0.00, 0.00, 6, 6, 'F', 'Marrone'),
        ( 1, 'Juniores dal 20mo al 23mo anno', 2002, 1999, 1, 0, 0.00, 0.00, 7, 7, 'F', 'Nera'),
        ( 1, 'Seniores kata dal 24mo al 38mo anno', 1998, 1984, 1, 0, 0.00, 0.00, 1, 1, 'M', 'Bianca'),
        ( 1, 'Seniores kata dal 24mo al 38mo anno', 1998, 1984, 1, 0, 0.00, 0.00, 2, 3, 'M', 'Gialla/Arancio'),
        ( 1, 'Seniores kata dal 24mo al 38mo anno', 1998, 1984, 1, 0, 0.00, 0.00, 4, 5, 'M', 'Verde/Blu'),
        ( 1, 'Seniores kata dal 24mo al 38mo anno', 1998, 1984, 1, 0, 0.00, 0.00, 6, 6, 'M', 'Marrone'),
        ( 1, 'Seniores kata dal 24mo al 38mo anno', 1998, 1984, 1, 0, 0.00, 0.00, 7, 7, 'M', 'Nera'),
        ( 1, 'Seniores kata dal 24mo al 38mo anno', 1998, 1984, 1, 0, 0.00, 0.00, 1, 1, 'F', 'Bianca'),
        ( 1, 'Seniores kata dal 24mo al 38mo anno', 1998, 1984, 1, 0, 0.00, 0.00, 2, 3, 'F', 'Gialla/Arancio'),
        ( 1, 'Seniores kata dal 24mo al 38mo anno', 1998, 1984, 1, 0, 0.00, 0.00, 4, 5, 'F', 'Verde/Blu'),
        ( 1, 'Seniores kata dal 24mo al 38mo anno', 1998, 1984, 1, 0, 0.00, 0.00, 6, 6, 'F', 'Marrone'),
        ( 1, 'Seniores kata dal 24mo al 38mo anno', 1998, 1984, 1, 0, 0.00, 0.00, 7, 7, 'F', 'Nera'),
        ( 1, 'Amatori A dal 39mo al 50mo anno', 1983, 1972, 1, 0, 0.00, 0.00, 1, 3, 'M', 'Bianca/Gialla/Arancio'),
        ( 1, 'Amatori A dal 39mo al 50mo anno', 1983, 1972, 1, 0, 0.00, 0.00, 4, 6, 'M', 'Verde/Blu/Marrone'),
        ( 1, 'Amatori A dal 39mo al 50mo anno', 1983, 1972, 1, 0, 0.00, 0.00, 7, 7, 'M', 'Nera'),
        ( 1, 'Amatori A dal 39mo al 50mo anno', 1983, 1972, 1, 0, 0.00, 0.00, 1, 3, 'F', 'Bianca/Gialla/Arancio'),
        ( 1, 'Amatori A dal 39mo al 50mo anno', 1983, 1972, 1, 0, 0.00, 0.00, 4, 6, 'F', 'Verde/Blu/Marrone'),
        ( 1, 'Amatori A dal 39mo al 50mo anno', 1983, 1972, 1, 0, 0.00, 0.00, 7, 7, 'F', 'Nera'),
        ( 1, 'Amatori B dal 51mo anno', 1971, 1900, 1, 0, 0.00, 0.00, 1, 3, 'M', 'Bianca/Gialla/Arancio'),
        ( 1, 'Amatori B dal 51mo anno', 1971, 1900, 1, 0, 0.00, 0.00, 4, 6, 'M', 'Verde/Blu/Marrone'),
        ( 1, 'Amatori B dal 51mo anno', 1971, 1900, 1, 0, 0.00, 0.00, 7, 7, 'M', 'Nera'),
        ( 1, 'Amatori B dal 51mo anno', 1971, 1900, 1, 0, 0.00, 0.00, 1, 3, 'F', 'Bianca/Gialla/Arancio'),
        ( 1, 'Amatori B dal 51mo anno', 1971, 1900, 1, 0, 0.00, 0.00, 4, 6, 'F', 'Verde/Blu/Marrone'),
        ( 1, 'Amatori B dal 51mo anno', 1971, 1900, 1, 0, 0.00, 0.00, 7, 7, 'F', 'Nera'),
        ( 1, 'Esordienti dal 13mo al 14mo anno', 2009, 2008, 0, 1, 0.00, 50.00, 4, 5, 'M', ''),
        ( 1, 'Esordienti dal 13mo al 14mo anno', 2009, 2008, 0, 1, 50.00, 99.00, 4, 5, 'M', ''),
        ( 1, 'Esordienti dal 13mo al 14mo anno', 2009, 2008, 0, 1, 0.00, 45.00, 4, 5, 'F', ''),
        ( 1, 'Esordienti dal 13mo al 14mo anno', 2009, 2008, 0, 1, 45.00, 99.00, 4, 5, 'F', ''),
        ( 1, 'Esordienti dal 13mo al 14mo anno', 2009, 2008, 0, 1, 0.00, 50.00, 6, 7, 'M', ''),
        ( 1, 'Esordienti dal 13mo al 14mo anno', 2009, 2008, 0, 1, 50.00, 99.00, 6, 7, 'M', ''),
        ( 1, 'Esordienti dal 13mo al 14mo anno', 2009, 2008, 0, 1, 0.00, 45.00, 6, 7, 'F', ''),
        ( 1, 'Esordienti dal 13mo al 14mo anno', 2009, 2008, 0, 1, 45.00, 99.00, 6, 7, 'F', ''),
        ( 1, 'Cadetti dal 15mo al 16mo anno', 2007, 2006, 0, 1, 50.00, 65.00, 4, 5, 'M', ''),
        ( 1, 'Cadetti dal 15mo al 16mo anno', 2007, 2006, 0, 1, 65.00, 99.00, 4, 5, 'M', ''),
        ( 1, 'Cadetti dal 15mo al 16mo anno', 2007, 2006, 0, 1, 40.00, 99.00, 4, 5, 'F', ''),
        ( 1, 'Speranze dal 17mo al 19mo anno', 2005, 2003, 0, 1, 55.00, 65.00, 4, 5, 'M', ''),
        ( 1, 'Speranze dal 17mo al 19mo anno', 2005, 2003, 0, 1, 65.00, 99.00, 4, 5, 'M', ''),
        ( 1, 'Speranze dal 17mo al 19mo anno', 2005, 2003, 0, 1, 45.00, 99.00, 4, 5, 'F', ''),
        ( 1, 'Juniores dal 20mo al 23mo anno', 2002, 1999, 0, 1, 55.00, 70.00, 4, 5, 'M', ''),
        ( 1, 'Juniores dal 20mo al 23mo anno', 2002, 1999, 0, 1, 70.00, 99.00, 4, 5, 'M', ''),
        ( 1, 'Juniores dal 20mo al 23mo anno', 2002, 1999, 0, 1, 45.00, 99.00, 4, 5, 'F', ''),
        ( 1, 'Seniores dal 24mo al 35mo anno', 1998, 1987, 0, 1, 55.00, 70.00, 4, 5, 'M', ''),
        ( 1, 'Seniores dal 24mo al 35mo anno', 1998, 1987, 0, 1, 70.00, 99.00, 4, 5, 'M', ''),
        ( 1, 'Seniores dal 24mo al 35mo anno', 1998, 1987, 0, 1, 45.00, 99.00, 4, 5, 'F', ''),
        ( 1, 'Cadetti dal 15mo al 16mo anno', 2007, 2006, 0, 1, 50.00, 65.00, 6, 6, 'M', ''),
        ( 1, 'Cadetti dal 15mo al 16mo anno', 2007, 2006, 0, 1, 65.00, 99.00, 6, 6, 'M', ''),
        ( 1, 'Cadetti dal 15mo al 16mo anno', 2007, 2006, 0, 1, 40.00, 99.00, 6, 6, 'F', ''),
        ( 1, 'Speranze dal 17mo al 19mo anno', 2005, 2003, 0, 1, 55.00, 65.00, 6, 6, 'M', ''),
        ( 1, 'Speranze dal 17mo al 19mo anno', 2005, 2003, 0, 1, 65.00, 99.00, 6, 6, 'M', ''),
        ( 1, 'Speranze dal 17mo al 19mo anno', 2005, 2003, 0, 1, 45.00, 99.00, 6, 6, 'F', ''),
        ( 1, 'Juniores dal 20mo al 23mo anno', 2002, 1999, 0, 1, 55.00, 65.00, 6, 6, 'M', ''),
        ( 1, 'Juniores dal 20mo al 23mo anno', 2002, 1999, 0, 1, 65.00, 75.00, 6, 6, 'M', ''),
        ( 1, 'Juniores dal 20mo al 23mo anno', 2002, 1999, 0, 1, 75.00, 99.00, 6, 6, 'M', ''),
        ( 1, 'Juniores dal 20mo al 23mo anno', 2002, 1999, 0, 1, 45.00, 55.00, 6, 6, 'F', ''),
        ( 1, 'Juniores dal 20mo al 23mo anno', 2002, 1999, 0, 1, 55.00, 99.00, 6, 6, 'F', ''),
        ( 1, 'Seniores dal 24mo al 35mo anno', 1998, 1987, 0, 1, 55.00, 65.00, 6, 6, 'M', ''),
        ( 1, 'Seniores dal 24mo al 35mo anno', 1998, 1987, 0, 1, 65.00, 75.00, 6, 6, 'M', ''),
        ( 1, 'Seniores dal 24mo al 35mo anno', 1998, 1987, 0, 1, 75.00, 99.00, 6, 6, 'M', ''),
        ( 1, 'Seniores dal 24mo al 35mo anno', 1998, 1987, 0, 1, 45.00, 55.00, 6, 6, 'F', ''),
        ( 1, 'Seniores dal 24mo al 35mo anno', 1998, 1987, 0, 1, 55.00, 99.00, 6, 6, 'F', ''),
        ( 1, 'Cadetti dal 15mo al 16mo anno', 2007, 2006, 0, 1, 50.00, 65.00, 7, 7, 'M', ''),
        ( 1, 'Cadetti dal 15mo al 16mo anno', 2007, 2006, 0, 1, 65.00, 99.00, 7, 7, 'M', ''),
        ( 1, 'Cadetti dal 15mo al 16mo anno', 2007, 2006, 0, 1, 40.00, 99.00, 7, 7, 'F', ''),
        ( 1, 'Speranze dal 17mo al 19mo anno', 2005, 2003, 0, 1, 55.00, 65.00, 7, 7, 'M', ''),
        ( 1, 'Speranze dal 17mo al 19mo anno', 2005, 2003, 0, 1, 65.00, 99.00, 7, 7, 'M', ''),
        ( 1, 'Speranze dal 17mo al 19mo anno', 2005, 2003, 0, 1, 45.00, 99.00, 7, 7, 'F', ''),
        ( 1, 'Juniores dal 20mo al 23mo anno', 2002, 1999, 0, 1, 55.00, 65.00, 7, 7, 'M', ''),
        ( 1, 'Juniores dal 20mo al 23mo anno', 2002, 1999, 0, 1, 65.00, 75.00, 7, 7, 'M', ''),
        ( 1, 'Juniores dal 20mo al 23mo anno', 2002, 1999, 0, 1, 75.00, 99.00, 7, 7, 'M', ''),
        ( 1, 'Seniores dal 24mo al 35mo anno', 1998, 1987, 0, 1, 55.00, 65.00, 7, 7, 'M', ''),
        ( 1, 'Seniores dal 24mo al 35mo anno', 1998, 1987, 0, 1, 65.00, 75.00, 7, 7, 'M', ''),
        ( 1, 'Seniores dal 24mo al 35mo anno', 1998, 1987, 0, 1, 75.00, 99.00, 7, 7, 'M', ''),
        ( 1, 'Juniores & Seniores dal 20mo al 35mo anno', 2002, 1987, 0, 1, 45.00, 55.00, 7, 7, 'F', ''),
        ( 1, 'Juniores & Seniores dal 20mo al 35mo anno', 2002, 1987, 0, 1, 55.00, 99.00, 7, 7, 'F', '');
    ''');
  } catch (e) {
    dbErrorSet(e.toString());
  }
}

void creaCinture() {
  dbErrorClear();
  try {
    db.execute('''
CREATE TABLE cinture (
  id INTEGER NOT NULL PRIMARY KEY,
  descrizione TEXT NOT NULL,
  note TEXT NOT NULL
);
    ''');

    db.execute('''
      INSERT INTO cinture ( descrizione,  note) VALUES
	('Bianca', ''),
	('Gialla', ''),
	('Arancio', ''),
	('Verde', ''),
	('Blu', ''),
	('Marrone', ''),
	('Nera', '');
    ''');
  } catch (e) {
    dbErrorSet(e.toString());
  }
}

void creaGare() {
  dbErrorClear();
  try {
    db.execute('''
CREATE TABLE gare (
  id INTEGER NOT NULL PRIMARY KEY,
  idcategoria INTEGER NOT NULL,
  descrizione TEXT NOT NULL,
  data TEXT NOT NULL,
  luogo TEXT NOT NULL,
  note TEXT NOT NULL
  );
    ''');

    db.execute('''

INSERT INTO gare (id, idcategoria, descrizione, data, luogo, note) VALUES
	(1, 1, 'Campionati regionali 2022', '2022-04-10', 'Castiglione Olona', 'note varie');


    ''');
  } catch (e) {
    dbErrorSet(e.toString());
  }
}

void creaGare2() {
  dbErrorClear();
  try {
    db.execute('''
CREATE TABLE IF NOT EXISTS gare2 (
  id INTEGER NOT NULL PRIMARY KEY,
  idgara INTEGER NOT NULL,
  societa TEXT NOT NULL,
  societacf TEXT NOT NULL,
  cognome TEXT NOT NULL,
  nome TEXT NOT NULL,
  sesso TEXT NOT NULL,
  cintura TEXT NOT NULL,
  anno TEXT NOT NULL,
  kata TEXT NOT NULL,
  kumite TEXT NOT NULL,
  peso TEXT NOT NULL,
  cf TEXT NOT NULL,
  tessera TEXT NOT NULL,
  note TEXT NOT NULL
  );
    ''');
  } catch (e) {
    dbErrorSet(e.toString());
  }
}


/*
  print('Using sqlite3 ${sql.sqlite3.version}');

  db.execute('''
    CREATE TABLE artists (
      id INTEGER NOT NULL PRIMARY KEY,
      name TEXT NOT NULL
    );
  ''');

  final stmt = db.prepare('INSERT INTO artists (name) VALUES (?)');
  stmt
    ..execute(['The Beatles'])
    ..execute(['Led Zeppelin'])
    ..execute(['The Who'])
    ..execute(['Nirvana']);

  stmt.dispose();

  final sql.ResultSet resultSet =
      db.select('SELECT * FROM artists WHERE name LIKE ?', ['The %']);

  resultSet.forEach((element) {
    print(element);
  });
  for (final sql.Row row in resultSet) {
    print('Artist[id: ${row['id']}, name: ${row['name']}]');
  }

  // Register a custom function we can invoke from sql:
  db.createFunction(
    functionName: 'dart_version',
    argumentCount: const sql.AllowedArgumentCount(0),
    function: (args) => Platform.version,
  );
  print(db.select('SELECT dart_version()'));

*/
