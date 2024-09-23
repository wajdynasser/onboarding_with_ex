import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';




TextFormField textFormField(){
  return TextFormField(
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.black)
          )
      ),
      validator: (value){
        if(value!.contains('#')){
          return 'Error input';
        }
      }//validator


  );
}






class FormScreen extends StatefulWidget{
  @override
  _LoginForm createState() => _LoginForm();
}

class _LoginForm extends State<FormScreen>{

  final formkey=GlobalKey<FormState>();
  String email='';
  String password='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
            title: Text('Login Form'),
            backgroundColor: Colors.blueGrey
        ) ,

        body:
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),

            child:Form(
              key: formkey,


              child: Column(
                children: [
                  Image(image: AssetImage('images/img_3.png'),width: 200,height: 200,),
                  SizedBox(height: 20,),
                  buildEmailForm(),
                  SizedBox(height: 20,),
                  buildPasswordForm(),
                  SizedBox(height: 2),
                  forgetPaa(),
                  buildSubmit(),
                  SizedBox(height: 20,),
                  buildAccount(),


                ],
              ),
            ),
          ),
        )
    );




  }

  //Emailform
  Widget buildEmailForm()=> TextFormField(
    keyboardType: TextInputType.emailAddress,

    decoration: InputDecoration(
        labelText: "Email",
        hintText: 'aliMohammed@gmail.com',
        prefixIcon: Icon(Icons.email),

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(30),

        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.indigo)
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

  //password
  Widget buildPasswordForm() => TextFormField(
    keyboardType: TextInputType.visiblePassword,

    decoration: InputDecoration(
        labelText: "Password",

        prefixIcon: Icon(Icons.lock),
        suffixIcon: Icon(Icons.visibility),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(30),

        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.indigo)
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

//submit
  Widget buildSubmit() =>
      ElevatedButton(onPressed: ()async{
        final pres=await SharedPreferences.getInstance();
        pres.setBool("onboarding",false);
        final isValid=formkey.currentState!.validate();
        if(isValid){
          formkey.currentState!.save();
          final message=
              "User email : $email\n User password : $password \n Data save success";
          final snackBar=
          SnackBar(content: Text(message,style: TextStyle(fontSize: 20),),
            backgroundColor: Colors.blue,


          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

        }
      },
          child: Text('Submit'));
//creat account
  Widget buildAccount() =>
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Already have an account?',style: TextStyle(fontSize: 15),),
          TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Sign up',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),))
        ],
      );
//forget password
  Widget forgetPaa()=>
      Align(
        alignment: Alignment.topRight,
        child: TextButton(onPressed: (){}, child: Text('Forget password?')

        ),
      );
}