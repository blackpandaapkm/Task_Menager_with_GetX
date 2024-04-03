import 'package:flutter/material.dart';
import 'package:task_menager_with_getx/screen/onboarding/emailVerificationScreen.dart';
import 'package:task_menager_with_getx/screen/onboarding/loginScreen.dart';
import 'package:task_menager_with_getx/screen/onboarding/pinVerificationScreen.dart';
import 'package:task_menager_with_getx/screen/onboarding/registrationScreen.dart';
import 'package:task_menager_with_getx/screen/onboarding/setPasswordScreen.dart';
import 'package:taskmenager/screen/onboarding/emailVerificationScreen.dart';
import 'package:taskmenager/screen/onboarding/loginScreen.dart';
import 'package:taskmenager/screen/onboarding/pinVerificationScreen.dart';
import 'package:taskmenager/screen/onboarding/registrationScreen.dart';
import 'package:taskmenager/screen/onboarding/setPasswordScreen.dart';
import 'package:taskmenager/screen/onboarding/splashScreen.dart';
import 'package:taskmenager/screen/task/homeScreen.dart';
import 'package:taskmenager/screen/task/taskCreateScreen.dart';
import 'package:taskmenager/utility/utility.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? token = await ReadUserData('token');
  if (token == null) {
    runApp(MyApp('/login'));
  }
  else {
    runApp(MyApp('/homeScreen'));
    // runApp(MyApp('/taskCreateScreen'));
  }
}
class MyApp extends StatelessWidget {
  final String FirstRoute;
  MyApp(this.FirstRoute);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Task Menager",
      initialRoute: FirstRoute,
      routes: {

        // '/':(context)=>splashScreen(),
        '/login':(context)=>loginScreen(),
        '/pinVerification':(context)=>pinVerificationScreen(),
        '/registration':(context)=>registrationScreen(),
        '/emailVerificationScreen':(context)=>emailVerificationScreen(),
        '/setPassword':(context)=>setPasswordScreen(),
        '/homeScreen':(context)=>homeScreen(),
        '/taskCreateScreen':(context)=>taskCreateScreen(),


      },


    );
  }
}