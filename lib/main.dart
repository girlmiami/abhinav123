
import 'package:abhinav123/screens/add_product.dart';
import 'package:abhinav123/screens/cart_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'login_screen.dart';
// import 'package:provider/provider.dart';
// import './screens/products_provider.dart';

FirebaseAuth auth = FirebaseAuth.instance;

double screenHeight = 0;
double screenWidth = 0;
bool isAuthorized = false;
double screenNotificationBarHeight = 0;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    auth.authStateChanges().listen((User user) {
      if (user != null) {
        setState(() {
          isAuthorized = true;
        });
        print(user.uid);
        print('what is the error');
      } else {
        setState(() {
          isAuthorized = false;
        });
        print("in listener no user");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //     textTheme: GoogleFonts.poppinsTextTheme(
      //   Theme.of(context).textTheme,
      // )),
      home: isAuthorized ? HomeScreen() : Login(),
      routes: {
        HomeScreen.routeName: (ctx) => HomeScreen(),
        CartScreen.routeName: (ctx) => CartScreen(),
        AddProduct.routeName: (ctx) => AddProduct(),
        Login.routeName: (ctx) => Login(),
      },
    );
  }
}
