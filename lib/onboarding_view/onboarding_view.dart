import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup_login_onbording/main.dart';
import 'package:signup_login_onbording/onboarding_view/onboarding_item.dart';
import 'package:signup_login_onbording/sign_up.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller=OnboardingItem();
  final pageController=PageController();

  bool isLastPage=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child:isLastPage? getStarted(): Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: ()=> pageController.jumpToPage(controller.items.length-1), child: Text("skip")),



            //indicator
            SmoothPageIndicator(controller: pageController, count: controller.items.length,
            onDotClicked: (index)=>pageController.animateToPage(index,duration: Duration(microseconds: 800),curve: Curves.easeIn),
            effect: WormEffect(
              dotHeight: 12,
              dotWidth: 12,
              activeDotColor: Colors.purple
            ),
            ),
            TextButton(onPressed: ()=>pageController.nextPage(duration: Duration(microseconds: 800),curve: Curves.easeIn), child: Text("next")),
          ],
        ),
      ),
      
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 100),
        child: PageView.builder(
          onPageChanged: (index)=>setState(()=> isLastPage=controller.items.length-1 ==index ),
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context,index){
            return Column(
              children: [
                Image.asset(controller.items[index].images),
                SizedBox(height: 15,),
                Text(controller.items[index].title,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                SizedBox(height: 15,),
                Text(controller.items[index].descriptions,style: TextStyle(color: Colors.grey),textAlign: TextAlign.center,),

              ],
            );


            }



        ),
      ),
    );
  }
  //get started botton
Widget getStarted(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blueAccent
      ),
      width: MediaQuery.of(context).size.width * .9,
      height: 55,
      child: TextButton(onPressed: ()async{
        final pres=await SharedPreferences.getInstance();
        pres.setBool("onboarding",true);
        if(!mounted)return;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Signup()));

      },child: Text('Get start',style: TextStyle(color: Colors.white),),),
    );
}
}
