import 'package:flutter/material.dart';

class MenuDashboard extends ChangeNotifier{
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _gridScffoldkey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _addorderkey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _addprodkey = GlobalKey<ScaffoldState>();
   GlobalKey<ScaffoldState> get getScaffoldkey => _scaffoldkey;
    GlobalKey<ScaffoldState> get getgridScffoldkey => _gridScffoldkey;
    GlobalKey<ScaffoldState> get getaddorderkey => _addorderkey;
GlobalKey<ScaffoldState> get getaddprodkey => _addprodkey;
  void controlDashboardMenu()
  {
    if(!_scaffoldkey.currentState!.isDrawerOpen)
      {
        _scaffoldkey.currentState!.openDrawer();
      }
  }
  void controlProductMenu()
  {
    if(!_gridScffoldkey.currentState!.isDrawerOpen)
      {
        _gridScffoldkey.currentState!.openDrawer();
      }
  }

  void controlAddOrder()
  {
    if(!_addorderkey.currentState!.isDrawerOpen)
    {
      _addorderkey.currentState!.openDrawer();
    }
  }
 void controlAddProd()
 {
   if(!_addprodkey.currentState!.isDrawerOpen)
     {
       _addprodkey.currentState!.openDrawer();
     }
 }
}