import 'package:core/core.dart';
import 'package:flutter/material.dart';

class HomeNotifier extends ChangeNotifier {
  DrawerItem _selectedDrawerItem = DrawerItem.Movie;

  DrawerItem get selectedDrawerItem => _selectedDrawerItem;

  void setSelectedDrawerItem(DrawerItem newItem) {
    this._selectedDrawerItem = newItem;
    notifyListeners();
  }
}
