import 'package:flutter/material.dart';
class Sign_To_Text extends StatelessWidget {
  const Sign_To_Text({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff003248),
      appBar: AppBar(
        title: Text('Sign To Text',style: TextStyle(fontSize: 25, fontFamily: 'Lato', color: Colors.white),),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin:
                        EdgeInsets.only(right: 22,left: 10),
                        padding: EdgeInsets.all(8),
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xff003248)),
                  ),
                  child: Icon(Icons.image,size: 68, color: Colors.grey,
                  ),
                ),
                SizedBox(
                      height: 10,
                    ),
                Padding(
                  padding: const EdgeInsets.only(right: 23, left: 13),
                  child: Center(child: Image.asset('assets/sign_to_text.png')),
                ),
                SizedBox(
                      height: 10,
                    ),
                Container(
                  margin:
                        EdgeInsets.only(right: 22,left: 10),
                        padding: EdgeInsets.all(8),
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xff003248)),
                  ),
                  child: Text('',
                  style: TextStyle(fontSize: 15,fontFamily: 'Comfortaa', color: Color(0xff003248))),
                ),
                SizedBox(
                      height: 50,
                    ),
                Container(
                  margin:
                        EdgeInsets.only(right: 22,left: 10),
                        //padding: EdgeInsets.all(8),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xff003248),
                    borderRadius: BorderRadius.circular(15)),
                child: MaterialButton(
                    onPressed: (){},
                    child: const Text(
                      "Done",
                      style: TextStyle(fontSize: 22,fontFamily: 'Comfortaa', color: Colors.white),
                    )),
              ),
              ],
            ),
          ),
      ),
    );
  }
}