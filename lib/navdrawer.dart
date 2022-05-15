import 'package:flutter/material.dart';
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
            title: const Text('Profile'),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(Icons.border_color),
            title: const Text('Feedback'),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Lock'),
            onTap: () => {
              Navigator.popUntil(context, (route) => true),
              Navigator.pushNamed(context, 'pin'),
              lock(),
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
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
}
