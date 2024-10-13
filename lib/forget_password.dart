import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup_login_onbording/login.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formkey=GlobalKey<FormState>();
  String email='';
  String password='';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              child: Icon(Icons.person, size: 100),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  buildEmailForm(),
                  const SizedBox(height: 20),
                  buildPasswordForm(),
                  const SizedBox(height: 20,),
                  buildResetPassword(),
                ],
              ),
            ),
            const SizedBox(height: 20),

          ],
        ),
      ),
    );


  }
  //email form build
  Widget buildEmailForm()=> TextFormField(
    keyboardType: TextInputType.emailAddress,

    decoration: InputDecoration(
        labelText: "Email",
        hintText: 'aliMohammed@gmail.com',
        prefixIcon: const Icon(Icons.email),

        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(30),

        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.indigo)
        )
    ),
    validator: (value) {
      const pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
      final regExp = RegExp(pattern);
      if (value!.isEmpty) {
        return 'Enter an email';
      }
      else if (!regExp.hasMatch(value))
      {
        return 'Enter a valid email';
      }
      else {
        return null;
      }
    },

    onSaved: (value) => setState(() => email = value!),

  );
  //password form
  Widget buildPasswordForm() => TextFormField(
    keyboardType: TextInputType.visiblePassword,

    decoration: InputDecoration(
        labelText: "New password",

        prefixIcon: const Icon(Icons.lock),
        suffixIcon: const Icon(Icons.visibility),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(30),

        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.indigo)
        )
    ),
    validator: (value){
      if(value!.length<8){
        return "Password must be contain at least 8 characters ";
      }else {
        return null ;
      }

    },
    onSaved: (value) => setState(() => password = value!),
    obscureText: true,
    obscuringCharacter: '#',
  );


  //reset password
  Widget buildResetPassword() => ElevatedButton(
      onPressed: () async {
        final pres = await SharedPreferences.getInstance();
        pres.setBool("onboarding", false);
        final isValid = _formkey.currentState!.validate();
        if (isValid) {
          _formkey.currentState!.save();
          final message =
              "User email : $email\n User password : $password \n Data save success";
          Navigator.push(context,MaterialPageRoute(builder: (context)=>FormScreen()));
          final snackBar = SnackBar(
            content: Text(
              message,
              style: const TextStyle(fontSize: 20),
            ),
            backgroundColor: Colors.blue,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: const Text('reset password'));

  }

