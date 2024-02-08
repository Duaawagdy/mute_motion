import 'package:flutter/material.dart';
import 'package:mute_motion/feature/sidebar/presentation/view/sidebar.dart';
class Translator_Screen extends StatelessWidget {
  const Translator_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      backgroundColor: Color(0xff003248),
      appBar: AppBar(
        title: Text(
          'Translator',
          style:
              TextStyle(fontSize: 25, fontFamily: 'Lato', color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
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
          child: Padding(
            padding: const EdgeInsets.only(right:20, top: 40, bottom:20, left: 10),
            child: Column(
              children: [
                Image.asset('assets/translator.png'),
                Text(
                  'Sign To Text',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold,
                      color: Color(0xff003248)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Please start translator and open your camera to translate your sign language to text',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Comfortaa',
                      color: Color(0xff003248)),
                ),
                SizedBox(
                  height: 100,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0xff003248),
                      borderRadius: BorderRadius.circular(15)),
                  child: MaterialButton(
                      onPressed: (){},
                      child: const Text(
                        "Start Translator",
                        style: TextStyle(fontSize: 22,fontFamily: 'Comfortaa', color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
