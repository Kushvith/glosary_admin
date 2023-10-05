import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glosary_admin/services/utils.dart';
import 'package:glosary_admin/widgets/textWidget.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).theme;
    Color color = theme?Colors.white:Colors.black;
    Size size = Utils(context).Getsize ;

    return Padding(
        padding: EdgeInsets.all(16),
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).cardColor.withOpacity(0.4),
        child: Row(
          children: [
            Flexible(
              flex: 8,
              child: Image.network(

                "https://media.istockphoto.com/photos/red-apple-picture-id184276818?k=20&m=184276818&s=612x612&w=0&h=QxOcueqAUVTdiJ7DVoCu-BkNCIuwliPEgtAQhgvBA_g=",
              fit: BoxFit.fill,
              width: size.width *0.10,
              height: size.height * 0.15,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextWidget(title: "12X for \$19.9", color: color, fontweight: 18,istitle: true,),
                  SizedBox(
                    height: 2,
                  ),
                 FittedBox(
                   child: Row(
                     children: [
                       TextWidget(title: "By ", color: Colors.blue, fontweight: 18,istitle:true),
                       TextWidget(title: "Kushvith", color: color, fontweight: 18)
                     ],
                   ),
                 ),
                  SizedBox(
                    height: 2,
                  ),
                  Text("20/3/2023")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
