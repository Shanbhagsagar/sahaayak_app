import 'package:flutter/cupertino.dart';

class MenuItem {
  String title;
  IconData icon;
  Function func;
  MenuItem(this.title, this.icon, this.func);
}