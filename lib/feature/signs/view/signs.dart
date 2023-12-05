import 'package:flutter/material.dart';
import 'package:mute_motion/feature/sidebar/presentation/view/sidebar.dart';

class signs extends StatelessWidget{
  const signs({super.key});

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
        buildasset('assets/hello.png'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Divider(color: Colors.grey,thickness: 2,),
        ),
        buildasset('assets/urwelcome.png'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Divider(color: Colors.grey,thickness: 2,),
        ),
        buildasset('assets/pgo.png'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Divider(color: Colors.grey,thickness: 2,),
        ),
        buildasset('assets/wwas.png'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Divider(color: Colors.grey,thickness: 2,),
        ),
        buildasset('assets/thu.png'),
      ],),),
    );

  }

  Padding buildasset(String assset) {

    return Padding(
        padding: const EdgeInsets.only(left: 54.0,right: 60),
        child: SizedBox(
            height:195,
            width: 317,
            child: Image.asset(assset)),
      );
  }

}