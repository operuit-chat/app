import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:operuit_flutter/languages.dart';
import 'package:operuit_flutter/login.dart';
import 'package:operuit_flutter/pin.dart';
import 'package:operuit_flutter/util/localdata.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: Text(
              'Operuit',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Color.fromRGBO(31, 37, 46, 1),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(Languages.getText("menu.profile")),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(Languages.getText("menu.settings")),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(Icons.border_color),
            title: Text(Languages.getText("menu.feedback")),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: Text(Languages.getText("menu.lock")),
            onTap: () => {
              Navigator.popUntil(context, (route) => true),
              Navigator.pushNamed(context, 'pin'),
              lock(),
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(Languages.getText("menu.language")),
            onTap: () => {
              changeLang(context)
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: Text(Languages.getText("menu.logout")),
            onTap: () => {
              Navigator.popUntil(context, (route) => true),
              Navigator.pushNamed(context, 'login'),
              logout(),
            },
          ),
        ],
      ),
    );
    ;
  }

  logout() {
    LocalData.deleteAuth();
  }

  lock() {
    MyPin.secure = "";
  }

  changeLang(BuildContext context) {
    Languages.current_language = Languages.current_language == "EN" ? "DE" : "EN";
    Navigator.pop(context);
    Navigator.pushNamed(context, "welcome");
  }
}
