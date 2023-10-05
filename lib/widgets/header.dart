import 'package:flutter/material.dart';
import 'package:glosary_admin/responsive.dart';
import 'package:glosary_admin/services/utils.dart';
import 'package:glosary_admin/widgets/textWidget.dart';
class Header extends StatelessWidget {
  const Header({Key? key,
  required Function this.fct,required this.title,this.searchfield = true}) : super(key: key);
final Function fct;
final String title;
final bool searchfield;
  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).theme;
    final color = Utils(context).color;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if(!Responsive.isDestop(context))
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: (){
              fct();
            },
          ),
        if(Responsive.isDestop(context))
          Padding(padding: EdgeInsets.all(20),
          child: TextWidget(title: title,color: color,fontweight: 24,),
          ),
        if(Responsive.isDestop(context))
          Spacer(flex: 2,),
        !searchfield ? Container():
        Expanded(child: TextField(
          decoration: InputDecoration(
            hintText: "Search",
            hintStyle: TextStyle(color: color),
            fillColor: Theme.of(context).cardColor,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(12.0)),

            ),

            suffixIcon: InkWell(
              onTap: (){

              },
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(12.0))
                ),
                child: Icon(Icons.search,color: color,
                size: 18,),
              ),
            )
          ),

        ))
      ],
    );
  }
}


