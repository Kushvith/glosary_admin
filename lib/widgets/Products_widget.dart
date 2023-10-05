import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:glosary_admin/InnerScreens/Editproduct.dart';
import 'package:glosary_admin/services/GobalVariables.dart';
import 'package:glosary_admin/services/utils.dart';
import 'package:glosary_admin/widgets/loadingManager.dart';
import 'package:glosary_admin/widgets/textWidget.dart';
class ProductWidget extends StatefulWidget {
  const ProductWidget({Key? key, required this.id}) : super(key: key);
final String id;
  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}
class _ProductWidgetState extends State<ProductWidget> {
  bool _isLoading = false;
  String title = '';
  String price = '0.0';
  double saleprice = 0.0;
  bool isOnSale = false;
  bool isPeice = false;
  String prodCat ='';
  String imageUrl = '';
  Future<void> getUserData() async{
    setState(() {
      _isLoading = true;
    });
    try{
      final DocumentSnapshot productDoc = await FirebaseFirestore.instance.collection('products').doc(widget.id).get();
      if(productDoc == null) return;
      else{
        title = productDoc.get('title');
        price = productDoc.get('price');
        saleprice = productDoc.get('saleprice');
        isOnSale = productDoc.get('isOnSale');
        isPeice = productDoc.get('isPeiece');
        prodCat =productDoc.get('productCategoryName');
        imageUrl = productDoc.get('imageUrl');

      }
      setState(() {
        _isLoading = false;
      });
    }catch(e){
      setState(() {
        _isLoading = false;
      });
      GlobalVariable.waringDailog(title: 'An Error Occured', subtitle: '$e', fn: (){}, context: context);
    }
  }
  @override
  void initState() {
    getUserData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).Getsize;
    Color color = Utils(context).color;
    return LoadingManager(
      isloading: _isLoading,
      child: Padding(padding: EdgeInsets.all(8),
      child: Material(

        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor.withOpacity(0.6),
        child: InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EditProduct(
              id: widget.id,
              title: title,
              imgUrl: imageUrl,
              isOnSale: isOnSale,
              isPeice: isPeice,
              price: price,
              productCat: prodCat,
              salePrice: saleprice,
            )));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 3,
                      child:  FancyShimmerImage(
                        width: size.width * 0.9,
                        height: size.height* 0.2,
                        imageUrl:
                         imageUrl,
                      ),
                    ),
                    const Spacer(),
                    PopupMenuButton(itemBuilder: (context)=> [
                      PopupMenuItem(
                          onTap:(){},
                          child: Text('Edit'),
                        value: 1,
                      ),
                      PopupMenuItem(
                        onTap:(){},
                        child: Text('Delete',style: TextStyle(
                          color: Colors.red
                        ),),
                        value: 2,
                      ),
                    ])
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    TextWidget(title: isOnSale?"\$${saleprice.toStringAsFixed(2)}":"\$$price", color: color, fontweight: 18),
                    SizedBox(
                      width: 4,
                    ),
                    Visibility(
                        visible: isOnSale,
                        child: Text(
                          "\$$price",
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: color
                          ),
                        ),),
                    Spacer(),
                    TextWidget(title: isPeice?"1 peice": "1 KG", color: color, fontweight: 18),


                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                TextWidget(title: "$title", color: color, fontweight: 24,istitle: true,)
              ],
            ),
          ),
        ),
      ),),
    );
  }
}
