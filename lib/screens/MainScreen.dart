import 'package:flutter/material.dart';
import 'package:glosary_admin/controllers/controldashboard.dart';
import 'package:glosary_admin/responsive.dart';
import 'package:glosary_admin/screens/dashboard_screen.dart';
import 'package:glosary_admin/widgets/side_menu.dart';
import 'package:provider/src/provider.dart';
class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuDashboard>().getScaffoldkey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(Responsive.isDestop(context))
              const Expanded(
                  child: SideMenu(),
              ),
             const Expanded(
              flex: 5,
              child: Dashboard_screen(),
            )
          ],
        ),
      ),
    );
  }
}
