import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mute_motion/feature/map/view/widgets/cutemfield.dart';
import 'package:mute_motion/feature/sidebar/presentation/view/sidebar.dart';

class map extends StatelessWidget{
  const map({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(onTap:(){GoRouter.of(context).push('/chat');},
              child: CircleAvatar(backgroundColor:  Color(0xff003248),radius: 25,child: Icon(Icons.message))),
          SizedBox(height: 10,),
          GestureDetector(onTap: (){GoRouter.of(context).push('/search');},child: CircleAvatar(backgroundColor:  Color(0xff003248),radius: 25,child: Icon(Icons.location_searching)))
        ],
      ),
      drawer: NavDrawer(),
      body: Stack(
        //alignment: AlignmentDirectional.bottomStart,
          children: <Widget>[
        Container(

          child: Image.asset('assets/map 1.png',fit: BoxFit.fill,),

        )
        ,Padding(
          padding: const EdgeInsets.only(top: 560.0),
          child: Container(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 18,),
                Text('Set your loction',textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 21, fontFamily:'comfortaa', color: Color(
                        0xffffffff))),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 29.0),
                  child: Divider(color: Color(0xFFFFFFFF),),
                ),
                SizedBox(height: 24,),
                custemlabel(icon: Icons.location_on_sharp, Place: 'Elzamalk - Egypt'),
                SizedBox(height: 24,),
                custemlabel(icon: FontAwesomeIcons.locationArrow, Place: 'Cairo Festival Mall - Nasr City'),
                SizedBox(height: 24,),
                //TextField(e),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(children: [
                Container(
                  height: 51,
                  width: 181,
                  decoration: BoxDecoration(
                      color: const Color(0xffffffff) ,
                      borderRadius: BorderRadius.circular(15)),
                  child: MaterialButton(
                      onPressed: (){},
                      child: const Text(
                        "Confirm",
                        style: TextStyle(fontSize: 20,fontFamily: 'Comfortaa', color: Color(0xff003248)),
                      )),
                ),
                SizedBox(width: 20,),
                Container(
                  height: 51,
                  width: 181,
                  decoration:ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 2.50, color: Color(0xFFF8F8F8)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: MaterialButton(
                      onPressed: (){GoRouter.of(context).push('/search');},
                      child: const Text(
                        "Search",
                        style: TextStyle(fontSize: 18,fontFamily: 'Comfortaa', color: Colors.white),
                      )),
                )
            ],),
              )
              ],
            ),
            height: 346,

            decoration:const BoxDecoration(
              color: Color(0xff003248),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )
          ),),
        )
      ]
      ),
    );
  }

}