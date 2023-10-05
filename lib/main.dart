import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:glosary_admin/InnerScreens/UploadProductForm.dart';
import 'package:glosary_admin/controllers/controldashboard.dart';
import 'package:glosary_admin/providers/Theme-provider.dart';
import 'package:glosary_admin/providers/Theme-provider.dart';
import 'package:glosary_admin/providers/Theme-provider.dart';
import 'package:glosary_admin/screens/MainScreen.dart';
import 'package:glosary_admin/screens/dashboard_screen.dart';
import 'package:provider/provider.dart';

import 'conts/ThemeData.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
    options: FirebaseOptions(
      apiKey: "AIzaSyAJEEqtDX_8OHVT6YZ-53R-1pK0G210y3Q",
      appId: "1:617769233735:web:bc72086f8cecadc2aa3062",
      messagingSenderId: "617769233735",
      projectId: "grocery-flutter-store",
        storageBucket: "gs://grocery-flutter-store.appspot.com"
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({Key? key}) : super(key: key);


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  themeProvider themeprovider = themeProvider();
  void gettheme() async{
    themeprovider.setDarktheme =await themeprovider.getDarktheme;
  }
  @override
  void initState() {
    // TODO: implement initState
    gettheme();
    super.initState();
  }
  final Future<FirebaseApp> _firebaseIntialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebaseIntialization,
      builder: (context,snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return MaterialApp(home: Scaffold(body: Center(child: CircularProgressIndicator(),),),);
        }
        else if(snapshot.hasError){
          print(snapshot.error.toString());
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text("An Error Occured"),
              ),
            ),
          );
        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_){
              return MenuDashboard();
            }),
            ChangeNotifierProvider(create: (_){
              return themeprovider;
            })
          ],
          child :Consumer<themeProvider>(
              builder: (context,themeProvider,child) {
                bool  a = themeprovider.getDarktheme;
                return MaterialApp(
                  title: 'MultiStore App',
                  theme: Styles.themeData(a, context),
                  debugShowCheckedModeBanner: false,
                  home: Scaffold(body: MainScreen()),
                  routes: {
                    UploadProductForm.routeName : (context)=> UploadProductForm(),

                  },
                );
              }
          ),
        );
      }
    );
  }
}


