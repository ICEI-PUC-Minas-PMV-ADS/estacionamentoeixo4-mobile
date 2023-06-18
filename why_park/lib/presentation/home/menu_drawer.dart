import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:why_park/edge/session_storage/session_storage.dart';

import '../../commons/commons_theme/theme_provider.dart';
import '../../routes_table.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer(this._sessionStorage, [Key? key]) : super(key: key);

  final SessionStorage _sessionStorage;

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  String _userName = '';

  void setUpUserName() async {
    final name = await widget._sessionStorage.retrieveUserName() ?? '';

    setState(() {
      _userName = name;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setUpUserName();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    bool darkTheme = themeChange.darkTheme;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Text(
              _userName,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            title: darkTheme
                ? const Text('Modo claro')
                : const Text('Modo escuro'),
            onTap: () {
              themeChange.darkTheme = !darkTheme;
            },
            leading: darkTheme
                ? const Icon(
                    Icons.light_mode,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.dark_mode,
                    color: Colors.black,
                  ),
          ),
          ListTile(
            title: const Text('Configurações de usuário'),
            leading: Icon(Icons.person,
                color: darkTheme ? Colors.white : Colors.black),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Política de privacidade'),
            leading: Icon(Icons.privacy_tip,
                color: darkTheme ? Colors.white : Colors.black),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Termos de serviço'),
            leading: Icon(Icons.text_snippet_outlined,
                color: darkTheme ? Colors.white : Colors.black),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Avalie-nos'),
            leading: Icon(Icons.star_rate,
                color: darkTheme ? Colors.white : Colors.black),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Sobre'),
            leading: Icon(Icons.info_outline,
                color: darkTheme ? Colors.white : Colors.black),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Logout'),
            leading: Icon(Icons.logout,
                color: darkTheme ? Colors.white : Colors.black),
            onTap: () async {
              await widget._sessionStorage.clear();
              Navigator.of(context).pushNamedAndRemoveUntil(RoutesTable.login,
                  (routes) => routes.settings.name != RoutesTable.login);
            },
          ),
        ],
      ),
    );
  }
}
