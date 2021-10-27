
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/src/provider.dart';
import 'package:sahaayak_app/Shared/screens/Update.dart';
import 'package:sahaayak_app/authentication_service.dart';
import '../../constants.dart';
import 'MenuItem.dart';
import 'package:sahaayak_app/Customer/screens/Dashboard.dart';
import 'package:sahaayak_app/Customer/screens/HiredTransactions.dart';
import 'package:sahaayak_app/Customer/screens/PaymentHistory.dart';


class MainMenu extends StatefulWidget {
  static const String id = 'main_menu';
  final String? displayName;
  final String? uid;
  const MainMenu (this.displayName,this.uid);
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  late Widget _appBarTitle;
  late MenuItem _selectedMenuItem;
  late List<MenuItem> _menuItems;
  List<Widget> _menuOptionWidgets = [];

  @override
  initState() {
    super.initState();
     _menuItems = createMenuItems(context,widget.uid);
    _selectedMenuItem = _menuItems.first;
     _appBarTitle = new Text(
      _menuItems.first.title,
      style: TextStyle(fontFamily: 'Ruluko'),
    );
  }

  _getMenuItemWidget(MenuItem menuItem) {
    return menuItem.func();
  }

  _onSelectItem(MenuItem menuItem) {
    setState(() {
      _selectedMenuItem = menuItem;
      _appBarTitle = new Text(
        menuItem.title,
        style: TextStyle(fontFamily: 'Ruluko'),
      );
    });
    Navigator.of(context).pop(); // close side menu
  }

  @override
  Widget build(BuildContext context) {
    _menuOptionWidgets = [];

    for (var menuItem in _menuItems) {
      _menuOptionWidgets.add(
        new Container(
          decoration: new BoxDecoration(
              color: menuItem == _selectedMenuItem
                  ? Colors.grey[200]
                  : Colors.white),
          child: new ListTile(
            leading: Icon(
              menuItem.icon,
              color: menuItem == _selectedMenuItem
                  ? HexColor("#01274a")
                  : Colors.grey,
            ),
            onTap: () => _onSelectItem(menuItem),
            title: Text(
              menuItem.title,
              style: new TextStyle(
                  fontFamily: 'Ruluko',
                  color: HexColor("#01274a"),
                  fontSize: 20.0,
                  fontWeight: menuItem == _selectedMenuItem
                      ? FontWeight.bold
                      : FontWeight.w300),
            ),
          ),
        ),
      );
      _menuOptionWidgets.add(
        new SizedBox(
          child: new Center(
            child: new Container(
              margin: new EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
              height: 0.3,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: new AppBar(
        title: _appBarTitle,
        backgroundColor: HexColor("#01274a"),
        centerTitle: true,
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new Container(
                child: new ListTile(
                    title: Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Text((widget.displayName).toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: kFontFamily1,
                          fontWeight: FontWeight.bold,
                          color: HexColor("#01274a")
                        ),
                      ),
                    )),
                margin: new EdgeInsetsDirectional.only(top: 20.0),
                color: Colors.white,
                constraints: BoxConstraints(maxHeight: 90.0, minHeight: 90.0)),
            new SizedBox(
              child: new Center(
                child: new Container(
                  margin:
                  new EdgeInsetsDirectional.only(start: 10.0, end: 10.0),
                  height: 0.3,
                  color: Colors.black,
                ),
              ),
            ),
            new Container(
              color: Colors.white,
              child: new Column(children: _menuOptionWidgets),
            ),
          ],
        ),
      ),
      body: _getMenuItemWidget(_selectedMenuItem),
    );
  }
}

List<MenuItem> createMenuItems(BuildContext context, String? muid) {
  final menuItems = [
    new MenuItem("Dashboard", Icons.dashboard_outlined, () => new Dashboard()),
    //new MenuItem("Book Services", Icons.bookmark_add_outlined, () => new BookServices()),
    new MenuItem("Hired Transactions", Icons.receipt_long_outlined,
            () => new HiredTransactions()),
    new MenuItem(
        "Payment History", Icons.history_outlined, () => new PaymentHistory()),
    new MenuItem("Update Info", Icons.info_outlined, () => new UpdatePage(muid)),
    new MenuItem("Logout", Icons.logout_outlined, () {
      context.read<AuthenticationService>().signOut();
    }),
  ];
  return menuItems;
}
