
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mute_motion/feature/OTP/presentation/view/widget/custemOTPbar.dart';
import 'package:mute_motion/feature/OTP/presentation/view/widget/custembutten.dart';
import 'package:mute_motion/feature/OTP/presentation/view/widget/custemcodefield.dart';
class OTP extends StatelessWidget{
  const OTP({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(body: 
   SingleChildScrollView(
     child: Container(
       height: MediaQuery.of(context).size.height,
       width: double.infinity,
       child: Column(


         children: [
         SizedBox(height:40,),

         custemOTPbar(),
         SizedBox(height: 56,),
         Text("Please enter the 4-digit code sent via SMS on\n +20 012875576766",
           style: TextStyle(color: Color(0xff003248),fontFamily: 'Comfortaa',fontSize: 15),),
         SizedBox(height: 19,),
         Padding(
           padding: const EdgeInsets.only(left: 24,right: 160),
           child: TextButton( onPressed: () {  }, child: Text("Edit your mobile number",
             style: TextStyle(color: Color(0xff003248),fontFamily: 'Comfortaa',fontSize: 16,fontWeight: FontWeight.bold),),),
         ),
           SizedBox(height: 71,),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               custemcodefield(),
                  custemcodefield(),
               custemcodefield(),
               custemcodefield()],
           ),
           SizedBox(height: 79,),
             custembutten(onPressed: (){GoRouter.of(context).push('/navbar');},)
           ,
           SizedBox(height: 30,),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text("Haven’t received OTP code? ",
                   style: TextStyle(
                     fontSize: 15,fontFamily: 'Comfortaa',
                   )),
               TextButton(
                   onPressed: () {GoRouter.of(context).push('/OTP');},
                   child: const Text(
                     "Resend OTP",
                     style:
                     TextStyle(color:Color(0xff003248),fontSize: 16,fontFamily: 'Comfortaa',fontWeight: FontWeight.bold),
                   )),
             ],
           ),
       ],),
     ),
   ),);
  }
}