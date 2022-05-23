import 'package:flutter/material.dart';
import 'package:uispdokarate/constants.dart';
import 'package:uispdokarate/sql.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  //final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        //color: Colors.green,
        child: ListView(
          //padding: padding,
          children: [
            const SizedBox(
              height: 8,
            ),
            drawerMenuItem(
              text: 'UISP Home',
              icon: Icons.home,
              onClicked: () => selectedItem(context, 0),
            ),
            const Divider(color: Colors.white70),
            drawerMenuItem(
              text: 'Categorie',
              icon: Icons.people,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(
              height: 8,
            ),
            drawerMenuItem(
              text: 'Cinture',
              icon: Icons.edit,
              onClicked: () => selectedItem(context, 3),
            ),
            const SizedBox(
              height: 8,
            ),
            drawerMenuItem(
              text: 'Gare',
              icon: Icons.edit,
              onClicked: () => selectedItem(context, 4),
            ),
            const SizedBox(
              height: 8,
            ),
            drawerMenuItem(
              text: 'INFORMAZIONI',
              icon: Icons.info,
              onClicked: () => selectedItem(context, 99),
            ),
          ],
        ),
      ),
    );
  }
}

Widget drawerMenuItem({
  required String text,
  required IconData icon,
  VoidCallback? onClicked,
}) {
  const color = drawerColor;
  const hoverColor = drawerHoverColor;

  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ),
    title: Text(text, style: const TextStyle(color: color)),
    hoverColor: hoverColor,
    onTap: onClicked,
  );
}

void selectedItem(BuildContext context, int index) {
  index = testDatabase(index);
  switch (index) {
    case 0:
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      break;
    case 1:
      Navigator.pushNamedAndRemoveUntil(
          context, '/categorie', (route) => false);
      break;
    case 3:
      Navigator.pushNamedAndRemoveUntil(context, '/cinture', (route) => false);
      break;
    case 4:
      Navigator.pushNamedAndRemoveUntil(context, '/gare', (route) => false);
      break;
    case 5:
      Navigator.pushNamedAndRemoveUntil(context, '/gare2', (route) => false);
      break;
    case 98:
      Navigator.pushNamedAndRemoveUntil(context, '/error', (route) => false);
      break;
    case 99:
      Navigator.pushNamedAndRemoveUntil(context, '/info', (route) => false);
      break;
  }
}
