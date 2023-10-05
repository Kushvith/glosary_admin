import 'package:flutter/material.dart';
import 'package:glosary_admin/InnerScreens/UploadProductForm.dart';
import 'package:glosary_admin/controllers/controldashboard.dart';
import 'package:glosary_admin/responsive.dart';
import 'package:glosary_admin/services/GobalVariables.dart';
import 'package:glosary_admin/services/utils.dart';
import 'package:glosary_admin/widgets/ButtonWidget.dart';
import 'package:glosary_admin/widgets/Products_widget.dart';
import 'package:glosary_admin/widgets/gridView.dart';
import 'package:glosary_admin/widgets/header.dart';
import 'package:glosary_admin/widgets/order_list.dart';
import 'package:glosary_admin/widgets/textWidget.dart';
import 'package:provider/src/provider.dart';
class Dashboard_screen extends StatelessWidget {
  const Dashboard_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).Getsize;
    Color color = Utils(context).color;

    return SafeArea(child: SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        children: [
          Header(
            title: "Dashboard",
            fct: (){
             context.read<MenuDashboard>().controlDashboardMenu();
            },
          ),
          TextWidget(title: "Latest products", color: color, fontweight: 18),
          SizedBox(height: 3,),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ButtonWidget(Onpressed: (){}, text: "View all", BackgroundColor: Colors.blue  , icon: Icons.store),
                Spacer(),
                ButtonWidget(Onpressed: (){
                  GlobalVariable.routeTo(context: context, routeName: UploadProductForm.routeName);
                }, text: "Add more", BackgroundColor: Colors.blue, icon: Icons.add)
              ],
            ),
          ),
          SizedBox(height: 3,),
          Row(
            children: [
              Expanded(child: Column(
                children: [
                  Responsive(destop: gridView(
                    childAspect: size.width>1440?1.1:0.95,
                    crossAxis: 4,
                  ), mobile:gridView(
                    childAspect: size.width>350 && size.width<600?1:1.4,
                    crossAxis:size.width>380? 2:1,
                  ) ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OrderList(),
                  ),

                ],
              ))
            ],
          )

        ],
      ),
    ));
  }
}
