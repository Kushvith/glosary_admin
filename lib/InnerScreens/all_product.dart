import 'package:flutter/material.dart';
import 'package:glosary_admin/controllers/controldashboard.dart';
import 'package:glosary_admin/services/utils.dart';
import 'package:glosary_admin/widgets/gridView.dart';
import 'package:glosary_admin/widgets/header.dart';
import 'package:glosary_admin/widgets/side_menu.dart';
import 'package:provider/src/provider.dart';

import '../responsive.dart';
class AllProductScreen extends StatefulWidget {
  const AllProductScreen({Key? key}) : super(key: key);

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).Getsize;
    return Scaffold(
      key: context.read<MenuDashboard>().getgridScffoldkey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(Responsive.isDestop(context))
              const Expanded(
                child: SideMenu(),
              ),
             Expanded(
              flex: 5,
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Header(
                    title: "All products",
                    fct: (){
                      context.read<MenuDashboard>().controlProductMenu();
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      controller: ScrollController(),
                      child: Responsive(destop: gridView(
                        childAspect: size.width>1440?1.1:0.95,
                        crossAxis: 4,
                        IsMain: false,
                      ), mobile:gridView(
                        childAspect: size.width>350 && size.width<600?1:1.4,
                        crossAxis:size.width>380? 2:1,
                        IsMain: false,
                      ) ),
                    ),
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
