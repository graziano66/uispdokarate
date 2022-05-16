import 'package:flutter/material.dart';
import 'package:uispdokarate/drawer.dart';
//import 'package:uispdokarate/constants.dart';
import 'package:uispdokarate/global.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawer(),
      appBar: AppBar(
        title: Text(widget.title),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png'),
                  ],
                ),
              ),
//            ),
          ],
        ),
      ),

/*        
        
          */
    );
  }
}
