import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mute_motion/feature/sidebar/presentation/view/sidebar.dart';

class signs extends StatelessWidget{
   signs({super.key});
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      backgroundColor: Color(0xff003248),
      appBar: AppBar(
        title: Text('Signs',style: TextStyle(fontSize: 25, fontFamily: 'Lato', color: Colors.white),),
        //leading: IconButton(onPressed:(){} ,icon: Icon(FontAwesomeIcons.bars,color: Colors.white,)),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,

      ),
      body: Container(height: MediaQuery.of(context).size.height,
        width: double.infinity,
        padding:const EdgeInsets.only(
          top: 20,
          left: 15,
        ),
        decoration:const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )
        ),
        child: ListView(children: [
          buildasset('assets/hello.png','sounds/hello.mp3'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Divider(color: Colors.grey,thickness: 2,),
          ),
          buildasset('assets/urwelcome.png','sounds/uarewelcom.mp3'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Divider(color: Colors.grey,thickness: 2,),
          ),
          buildasset('assets/pgo.png','sounds/PuttingGasolineOn.mp3'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Divider(color: Colors.grey,thickness: 2,),
          ),
          buildasset('assets/wwas.png','sounds/wewillarrivesoon.mp3'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Divider(color: Colors.grey,thickness: 2,),
          ),
          buildasset('assets/thu.png','sounds/thankyou.mp3'),

        ],),),
    );

  }

  Widget buildasset(String assset,String sound) {

    return GestureDetector(
      onTap: (){

player.play(AssetSource(sound));
        print('run');
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
            height:195,
            width: 317,
            child: Image.asset(assset)),
      ),
    );
  }

}