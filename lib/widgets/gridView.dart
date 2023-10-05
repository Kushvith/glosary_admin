import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glosary_admin/services/utils.dart';
import 'package:glosary_admin/widgets/textWidget.dart';

import 'Products_widget.dart';
class gridView extends StatelessWidget {
  const gridView({Key? key, this.childAspect=1, this.crossAxis=4, this.IsMain= true}) : super(key: key);
  final double childAspect;
  final int crossAxis;
  final bool IsMain;
  @override
  Widget build(BuildContext context) {
    final color = Utils(context).color;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if(snapshot.connectionState == ConnectionState.active){
          return snapshot.data!.docs.length == 0 ? Center(
        child: TextWidget(title: 'You didnt added any products yet ', color: color, fontweight: 18,),
        ):
        GridView.builder(
          itemCount:IsMain&& snapshot.data!.docs.length >4 ? 4: snapshot.data!.docs.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: childAspect,
              crossAxisCount: crossAxis,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12
          ),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context,index){
            return ProductWidget(id: snapshot.data!.docs[index]['id'],);
          },
        );
      }
        else{
        return const Center(
        child: Text('store is empty')
        );
        }
        return const Center(
        child: Text('something went wrong...')
        );
      }

    );

  }
}
