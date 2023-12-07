 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/res/constants.dart';
import 'package:todo/view/home/components/custom_app_bar.dart';
import 'package:todo/view/sign%20up/sign_up.dart';
import 'package:todo/view_model/controller/home_controller.dart';

import '../home/components/back_decoration.dart';

class ProfilePage extends StatelessWidget {
    ProfilePage({super.key});
    final controller=Get.put(HomeController());
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: Stack(
         fit: StackFit.expand,
         children: [
           const BackColors(),
           Positioned.fill(child: SafeArea(
             child: Column(children: [
               SizedBox(height: 20,),
               CustomAppBar(),
               SizedBox(height: 20,),
               Center(
                 child: CircleAvatar(
                   radius: 60,
                   backgroundColor: Colors.grey.withOpacity(.1),
                   child: Center(
                     child: Icon(Icons.person,color: Colors.white,size: 70,),
                   ),
                 ),
               ),
               SizedBox(height: 20,),
               Obx(() => Text(controller.name.value,style: TextStyle(
                 fontSize: 20,
                 fontWeight: FontWeight.bold,
                 color: Colors.black
               ),)),
               Obx(() => Text(controller.userData['EMAIL'],style: TextStyle(
                   fontSize: 14,

                   color: Colors.grey
               ),)),
               SizedBox(height: 50,),
               CustomProfileButton(icon: Icons.person,text: 'Account',),
               CustomProfileButton(icon: Icons.privacy_tip_outlined,text: 'Privacy',),
               CustomProfileButton(icon: Icons.security,text: 'Security',),
               CustomProfileButton(icon: Icons.note_alt_outlined,text: 'License',),
               GestureDetector(
                   onTap: () async {
                     FirebaseAuth.instance.signOut();
                     SharedPreferences pref=await SharedPreferences.getInstance();
                     pref.clear();
                     Get.offAll(SignUp());
                   },
                   child: CustomProfileButton(icon: Icons.logout_sharp,text: 'Logout',)),
             ],),
           ))
         ],
       ),
     );
   }
 }

class CustomProfileButton extends StatelessWidget {
  const CustomProfileButton({super.key, required this.text, required this.icon});
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.sizeOf(context).width-210,
      decoration: BoxDecoration(
        color: darkOrange,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,color: Colors.white,),
          SizedBox(width: 10,),
          Text(text,style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),)
        ],
      ),
    );
  }
}
