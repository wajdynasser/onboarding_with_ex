import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup_login_onbording/login.dart';







class Signup extends StatefulWidget{
  @override
  _Signup createState() => _Signup();
}

class _Signup extends State<Signup>{

  final formkey=GlobalKey<FormState>();
  String email='';
  String password='';
  String name='';
  String phone='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
            title: Text('Sign up'),
            backgroundColor: Colors.blueAccent,
          actions: [
            TextButton(onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>FormScreen()));}

              ,child: Text("Log in",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),)
          ],
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
                  SizedBox(height: 20),
                  buildNameForm(),
                  SizedBox(height: 20,),
                  buildPhoneForm(),
                  SizedBox(height: 20,),
                  buildEmailForm(),
                  SizedBox(height: 20),
                  buildPasswordForm(),
                  SizedBox(height: 20),
                  buildSubmit(),
                ],
              ),
            ),
          ),
        )
    );

  }
//nameForm
  Widget buildNameForm() => TextFormField(
    keyboardType: TextInputType.text,

    decoration: InputDecoration(
        labelText: "Name",

        prefixIcon: Icon(Icons.person),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(15),

        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.indigo)
        )
    ),
    validator: (value){
      if(value!.length<8){
        return "Name must be contain at least 10 characters ";
      }else {
        return null ;
      }

    },

    onSaved: (value) => setState(() => name = value!),
  );
  //phoneform
  Widget buildPhoneForm()=> TextFormField(


    decoration: InputDecoration(
        labelText: "Phone",
        hintText: '782246886',
        prefixIcon: Icon(Icons.phone),

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(15),

        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.indigo)
        )
    ),
    validator: (value) {

      if (value!.length<10) {
        return 'phone number must be at least 9 numbers.';
      }

      else {
        return null;
      }
    },
    keyboardType: TextInputType.phone,
    onSaved: (value) => setState(() => phone = value!),

  );

  //Emailform
  Widget buildEmailForm()=> TextFormField(


    decoration: InputDecoration(
        labelText: "Email",
        hintText: 'em715476@gmail.com',
        prefixIcon: Icon(Icons.email),

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(15),

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
    keyboardType: TextInputType.emailAddress,
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
          borderRadius: BorderRadius.circular(15),

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
              "User name : $name\n User phone : $phone \n User email : $email \n User password :$password data save success";
          final snackBar=
          SnackBar(content: Text(message,style: TextStyle(fontSize: 20),),
            backgroundColor: Colors.blue,


          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

        }
      },
          child: Text('Submit')
      );


}