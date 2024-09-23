
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup_login_onbording/onboarding_view/onboarding_view.dart';
import 'package:signup_login_onbording/sign_up.dart';



void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  final presf=await SharedPreferences.getInstance();
  final onboarding=presf.getBool("onboarding")??false;
  runApp(Onboarding(onboarding: onboarding));
}



class Onboarding extends StatelessWidget {
  final bool onboarding;
  const Onboarding({super.key,this.onboarding=false});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,

      home:onboarding? Signup() : OnboardingView(),
    );
  }
}

