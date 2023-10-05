
import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glosary_admin/controllers/controldashboard.dart';
import 'package:glosary_admin/services/GobalVariables.dart';
import 'package:glosary_admin/services/utils.dart';
import 'package:glosary_admin/widgets/ButtonWidget.dart';
import 'package:glosary_admin/widgets/header.dart';
import 'package:glosary_admin/widgets/side_menu.dart';
import 'package:glosary_admin/widgets/textWidget.dart';
import 'package:provider/src/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../responsive.dart';
import '../widgets/loadingManager.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebasestorage;
class UploadProductForm extends StatefulWidget {
  const UploadProductForm({Key? key}) : super(key: key);
  static final String routeName = "UploadProductForm";
  @override
  State<UploadProductForm> createState() => _UploadProductFormState();
}

class _UploadProductFormState extends State<UploadProductForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController,_priceController;
  String _catVal = "Vegtable";
  int _groupValue = 1;
  bool isPeice = false;
  File? _image_file;
  Uint8List webImage = Uint8List(8);
  @override
  void initState() {
    // TODO: implement initState
    _titleController =  TextEditingController();
    _priceController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _priceController.dispose();
    _titleController.dispose();
    super.dispose();
  }
  bool _isloading = false;
  void _uploadForm() async{
    final isValidate = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    var uuid = Uuid();
    String uid = uuid.v4();
    if(isValidate){
      if(_image_file == null){
        Fluttertoast.showToast(
            msg: "Please Pick Image",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
      setState(() {
        _isloading = true;
      });
      _formKey.currentState!.save();
      try{
        firebasestorage.Reference storageReference = firebasestorage.FirebaseStorage.instance.ref();
        firebasestorage.Reference imgpath = storageReference.child('productsImg').child(uid+'jpg');
        if(kIsWeb){
          await imgpath.putData(webImage);
        }else{
          await imgpath.putFile(_image_file!);
        }
        String imageUri= await imgpath.getDownloadURL();
        // final fb.UploadTaskSnapshot uploadTaskSnapshot = await
        // storageReference.put(kIsWeb?webImage:_image_file).future;

        await FirebaseFirestore.instance.collection('products').doc(uid).set({
          'id':uid,
          'title':_titleController.text,
          'price':_priceController.text,
          'saleprice':0.1,
          'imageUrl':imageUri,
          'productCategoryName':_catVal,
          'isOnSale':false,
          'isPeiece': isPeice,
          'createdAt':Timestamp.now()
        });
        setState(() {
          _isloading = false;
        });
        _clearForm();
        Fluttertoast.showToast(
            msg: "Uploaded Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        while(Navigator.canPop(context)){
          Navigator.pop(context);
        }
      }
      on FirebaseException catch(e){
       GlobalVariable.waringDailog(title: 'Error Occured', subtitle: '${e.message}', fn: (){}, context: context);
        setState(() {
          _isloading = false;
        });}
      catch(e){
        GlobalVariable.waringDailog(title: 'Error ocuured', subtitle: '$e', fn: (){}, context: context);
        setState(() {
          _isloading = false;
        });}
    }

  }
  void _clearForm(){
    _priceController.clear();
    _titleController.clear();
     _groupValue = 1;
     isPeice = false;
    setState(() {
      _image_file = null;
      webImage = Uint8List(8);
    });
  }
  @override
  Widget build(BuildContext context) {
    final color = Utils(context).color;
    final _scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    Size size = Utils(context).Getsize;
    var inputDecoration = InputDecoration(
      filled: true,
      fillColor: _scaffoldColor,
      border: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1.0
        )
      )
    );
    return LoadingManager(
      isloading:_isloading,
      child: Scaffold(

        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Expanded(
                flex: 5,
                child: Column(
                  children: [

                   Container(
                     width: size.width > 650 ? 650 : size.width,
                     color: Theme.of(context).cardColor,
                     padding: EdgeInsets.all(16),
                     margin: EdgeInsets.all(16),
                     child: Form(
                       key: _formKey,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         TextWidget(title: "product title", color: color, fontweight: 18,istitle: true,),
                         SizedBox(
                           height: 5,
                         ),
                         TextFormField(
                           controller: _titleController,
                           key: const ValueKey("Title"),
                           validator: (value){
                             if(value!.isEmpty){
                               return "Please Enter title";
                             }
                             return null;
                           },
                           decoration: inputDecoration,
                         ),
                         SizedBox(
                           height: 10,
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Expanded(
                                 flex: 2,
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     TextWidget(title: "price in \$", color: color, fontweight: 18),
                                     SizedBox(
                                       height: 5,
                                     ),
                                     SizedBox(
                                       width: 100,
                                       child: TextFormField(
                                         controller: _priceController,
                                         key: ValueKey("price"),
                                         keyboardType: TextInputType.number,
                                         validator: (value){
                                           if(value!.isEmpty){
                                             return "price required";
                                           }
                                           return null;
                                         },
                                         inputFormatters:<TextInputFormatter>[ FilteringTextInputFormatter.allow(
                                           RegExp(r'[0-9.]')
                                         )],
                                         decoration: inputDecoration,
                                     ),),
                                     SizedBox(
                                       height: 10,
                                     ),
                                     TextWidget(title: "Product category", color: color, fontweight: 18,istitle: true,),
                                     const SizedBox(
                                       height: 10,
                                     ),
                                     CatDropDown(),
                                     const SizedBox(
                                       height: 10,
                                     ),
                                     TextWidget(title: "Measure unit", color: color, fontweight: 18,istitle: true,),
                                     SizedBox(
                                       height: 10,
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Row(
                                         children: [
                                           TextWidget(title: "Kg", color: color, fontweight: 18),
                                           Radio(
                                             value: 1,
                                             groupValue: _groupValue,
                                             onChanged: (val){
                                               setState(() {
                                                 _groupValue = 1;
                                                 isPeice = false;

                                               });
                                             },
                                             activeColor: Colors.green,
                                           ),
                                           TextWidget(title: "Peice", color: color, fontweight: 18),
                                           Radio(
                                             value: 2,
                                             groupValue: _groupValue,
                                             onChanged: (val){
                                               setState(() {
                                                 _groupValue = 2;
                                                 isPeice = true;

                                               });
                                             },
                                             activeColor: Colors.green,
                                           ),
                                         ],
                                       ),
                                     )
                                   ],
                                 ),
                             ),
                           //  image to be picked here
                             Expanded(
                               flex: 4,
                               child: Container(
                                 height: size.width > 650 ? 350 : size.width *0.45,
                                 decoration: BoxDecoration(
                                   color: _scaffoldColor,
                                   borderRadius: BorderRadius.circular(12)
                                 ),
                                  child: _image_file==null? dottedBorder():
                               ClipRRect(
                                 borderRadius: BorderRadius.circular(12),
                                 child:   kIsWeb ? Image.memory(webImage,fit: BoxFit.fill,):
                                 Image.file(_image_file!,fit: BoxFit.fill,),
                               ),
                               ),

                             ),

                             Expanded(
                                 flex: 1,
                                 child: Column(
                                   children: [
                                     TextButton(onPressed: (){
                                       setState(() {
                                         _image_file = null;
                                         webImage = Uint8List(8);
                                       });
                                     }, child: TextWidget(title: "clear",color: Colors.red,fontweight: 16,)),
                                     TextButton(onPressed: (){}, child: TextWidget(title: "upload",color: Colors.black,fontweight: 16,))
                                   ],
                                 ),
                             )
                           ],
                         ), SizedBox(
                           height: 25,
                         ),
                         Padding(padding: EdgeInsets.all(8),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             ButtonWidget(Onpressed: (){
                               _clearForm();
                             }, text: "clear form", BackgroundColor: Colors.red.shade300, icon: IconlyBold.danger),
                             ButtonWidget(Onpressed: (){
                               _uploadForm();
                             }, text: "upload", BackgroundColor: Colors.blue, icon: IconlyBold.upload)
                           ],
                         ),
                         )
                       ],
                     ),
                     ),
                   ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget dottedBorder(){
    final color = Utils(context).color;
 return Padding(
   padding: const EdgeInsets.all(8.0),
   child: DottedBorder(
     dashPattern: [6.7],
     borderType: BorderType.RRect,
     color: color,
     radius: Radius.circular(12),
     child: Center(
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Icon(
             IconlyBold.image,
             color: color,
             size: 50,
           ),
         
           TextButton(onPressed: (){
             _pickImage();
           }, child: TextWidget(title: "choose Image",color: color,fontweight: 15,))

         ],
       ),
     ),

   ),
 );
  }
  Future<void> _pickImage() async{
    if(!kIsWeb){
      final ImagePicker _picker = ImagePicker();
     XFile? image =  await _picker.pickImage(source: ImageSource.gallery) ;
     if(image != null){
       var Selected = File(image.path);
       setState(() {
         _image_file = Selected;
       });
     }else{
       print("No image Selected");
     }
    }
    else if(kIsWeb){
      final ImagePicker _picker = ImagePicker();
      XFile? image = await  _picker.pickImage(source: ImageSource.gallery);
      if(image != null){
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          _image_file = File('a');
        });
      }
    else{
    print("No image Selected");
    }
  }
  }
  Widget CatDropDown(){

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: DropdownButtonHideUnderline(child: DropdownButton<String>(
            onChanged: (val){
              setState(() {
                _catVal = val!;
                print(_catVal);
              });

            },
            items: [
              DropdownMenuItem(child: Text("Vegtable"),value: "Vegtable",),
              DropdownMenuItem(child: Text("Fruits"),value: "Fruits",),
              DropdownMenuItem(child: Text("Grains"),value: "Grains",),
              DropdownMenuItem(child: Text("Nuts"),value: "Nuts",)
            ],
            value: _catVal,
            hint: Text("Select category"),
          )),
        ),
      ),
    );
  }
}



