import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:glosary_admin/InnerScreens/OrderPage.dart';
import 'package:glosary_admin/InnerScreens/all_product.dart';
import 'package:glosary_admin/providers/Theme-provider.dart';
import 'package:glosary_admin/services/utils.dart';
import 'package:glosary_admin/widgets/textWidget.dart';
import 'package:provider/provider.dart';
class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<themeProvider>(context);
    final color = Utils(context).color;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Image.asset(
            "assets/images/groceries.png"
          ),
          ),
        DrawerListTile(press: (){}, title: "Main", icon: IconlyBold.home),
        DrawerListTile(press: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AllProductScreen()));
        }, title: "View all products", icon: Icons.store),
          DrawerListTile(press: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> OrderPage()));
          }, title: "View all Orders", icon: IconlyBold.bag2),
          SwitchListTile(value: theme.getDarktheme, onChanged: (value){
            setState(() {

              theme.setDarktheme = value;
            });
          },
          title: TextWidget(title: "Theme",color: color,fontweight: 18,),
            secondary: Icon(
                theme.getDarktheme ? Icons.dark_mode_outlined : Icons.light_mode_outlined
            ),
          )
        ],
      ),
    );
  }
}
class DrawerListTile extends StatelessWidget{
  const DrawerListTile({Key? key,
  required this.press, required this.title, required this.icon,

  }): super(key: key);
  final VoidCallback press;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context){
    final color = Utils(context).color;
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0,
      leading: Icon(
        icon,size: 18,
      ),
      title: TextWidget(
        title: title,
        color: color,
        fontweight: 18,
      ),

    );
  }
}