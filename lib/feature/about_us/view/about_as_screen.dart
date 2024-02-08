import 'package:flutter/material.dart';
import 'package:mute_motion/feature/sidebar/presentation/view/sidebar.dart';

class About_As extends StatelessWidget {
  const About_As({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      backgroundColor: Color(0xff003248),
      appBar: AppBar(
        title: Text(
          'About Us',
          style:
              TextStyle(fontSize: 25, fontFamily: 'Lato', color: Colors.white),
        ),
        //leading: Icon(Icons.menu,color: Colors.white,),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        padding: const EdgeInsets.only(
          top: 20,
          left: 15,
        ),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Let’s introduce ourselves!',
                style: TextStyle(
                    fontSize: 22, fontFamily: 'Lato', color: Color(0xff003248)),
              ),
              SizedBox(
                height: 10,
              ),
              Image.asset('assets/about_us.png'),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(right: 22, left: 10),
                padding: EdgeInsets.all(8),
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xff003248)),
                ),
                child: SingleChildScrollView(
                  child: Text(
                      "The MuteMotion project aims to create an innovative smart taxi service catering specifically to deaf and mute drivers. It involves the development of advanced driver assistance systems (ADAS) using artificial intelligence (AI) and mobile application technologies. By enhancing safety features, communication tools, and convenience, MuteMotion seeks to empower the deaf/mute community with job opportunities and effective interaction platforms.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Comfortaa',
                          color: Color(0xff003248))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
