import 'package:flutter/material.dart';
import 'package:uispdokarate/constants.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:uispdokarate/pages/homepage.dart';
import 'package:uispdokarate/pages/dberror.dart';

import 'package:uispdokarate/pages/xxx.dart';
import 'package:uispdokarate/pages/categorie.dart';
import 'package:uispdokarate/pages/categorie2.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,

        title: 'UISP DO Karate',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(title: 'D.O. UISP - Gestione gare'),
          '/info': (context) => const HomePage(title: 'D.O. UISP - Gestione gare'),
          '/categorie': (context) =>
              const CategoriePage(title: 'Elenco regole annuali'),
          '/categorie2': (context) =>
              const Categorie2Page(title: 'Elenco categorie'),
          '/browse': (context) => const XXXPage(title: 'BROWSE'),
          '/error': (context) =>
              const DbErrorPage(title: 'Errore sul database'),
/*
          '/categorieed': (context) => const CategorieEditPage(
              title: 'Modifica delle categorie annuali'),
          '/categorie2ed': (context) => const Categorie2EditPage(
              title: 'Modifica della categoria dettaglio'),
          '/cinture': (context) =>
              const CinturePage(title: 'Elenco delle cinture'),
          '/cintureed': (context) =>
              const CintureEditPage(title: 'Modifica della cintura'),
          '/gare': (context) => const GarePage(title: 'Elenco delle gare'),
          '/gareed': (context) =>
              const GareEditPage(title: 'Modifica delle gare'),
          '/gare2': (context) => const Gare2Page(title: 'Dettaglio delle gare'),
          '/gare2ed': (context) =>
              const Gare2EditPage(title: 'Modifica dettaglio della gara'),
*/
        });
  }
}
