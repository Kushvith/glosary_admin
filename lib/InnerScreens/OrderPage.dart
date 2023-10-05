import 'package:flutter/material.dart';
import 'package:glosary_admin/controllers/controldashboard.dart';
import 'package:glosary_admin/services/utils.dart';
import 'package:glosary_admin/widgets/gridView.dart';
import 'package:glosary_admin/widgets/header.dart';
import 'package:glosary_admin/widgets/order_list.dart';
import 'package:glosary_admin/widgets/side_menu.dart';
import 'package:provider/src/provider.dart';

import '../responsive.dart';
class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPage();
}

class _OrderPage extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).Getsize;
    return Scaffold(
      key: context.read<MenuDashboard>().getaddorderkey,
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
                    title:"All Orders",
                    fct: (){
                      context.read<MenuDashboard>().controlAddOrder();
                    },
                  ),

                  SizedBox(height: 25,),
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      controller: ScrollController(),
                      child: Padding(
                          padding: EdgeInsets.all(8),
                          child: OrderList()),
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
