import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glosary_admin/responsive.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key,required this.Onpressed,required this.text,required this.BackgroundColor,required this.icon}) : super(key: key);
final VoidCallback Onpressed;
final String text;
final IconData icon;
final Color BackgroundColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: TextButton.styleFrom(
        backgroundColor: BackgroundColor,
        padding: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: Responsive.isDestop(context)? 10:5
        ),

      ),
      onPressed: (){
        Onpressed();
      },
      icon: Icon(icon,size: 20,),
      label: Text(text),
    );
  }
}
