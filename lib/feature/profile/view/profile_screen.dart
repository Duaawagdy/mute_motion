import 'package:flutter/material.dart';
import 'package:mute_motion/core/utils/constant.dart';
import 'package:mute_motion/feature/resgisterscreen/view/widget/custombutton.dart';
import 'package:mute_motion/feature/sidebar/presentation/view/sidebar.dart';
class Profile_Screen extends StatelessWidget {
  const Profile_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
      backgroundColor: Color(0xff003248),
      appBar: AppBar(

        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        //alignment: Alignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 80),
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
                  SizedBox(height: 70,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.amber,size: 20,),
                      Icon(Icons.star, color: Colors.amber,size: 20,),
                      Icon(Icons.star, color: Colors.amber,size: 20,),
                      Icon(Icons.star, color: Colors.amber,size: 20,),
                      Icon(Icons.star, color: Colors.amber,size: 20,),
                    ],
                  ),
                  Text('128 Reviews',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,

                  ),),
                  Container(
                   margin: EdgeInsets.only(top: 30,
                   left: 10,
                   right: 22,
                   bottom: 20),
                    height: 110,
                    width: 390,
                    padding:const EdgeInsets.only(
                      top: 20,
                      left: 15,
                    ),
                    decoration:const BoxDecoration(
                        color: borderColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)
                        )
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[Text('Car Type:', style: TextStyle(
                        fontSize: 18, fontFamily: 'Lato', color: Colors.white),),
                            SizedBox(height: 6,),
                            Text('color:       Model:   ', style: TextStyle(
                                fontSize: 18, fontFamily: 'Lato', color: Colors.white),),
                            SizedBox(height: 6,),
                            Text('(automatic-comfort-4 seats)', style: TextStyle(
                                fontSize: 14, fontFamily: 'Lato', color: Colors.white),),
                          ]

                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Image.asset('assets/car 1.png'),
                        )
                      ],

                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0),
                    height:MediaQuery.of(context).size.height,
                    width: double.infinity,
                    padding:const EdgeInsets.only(
                      top: 20,
                      left: 15,
                    ),
                    decoration:const BoxDecoration(
                        color:Colors.white,

                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[Text(
                          'Name',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.699999988079071),
                            fontSize: 16,
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.w600,

                            letterSpacing: 0.40,
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15,bottom: 8,),
                        child: TextFormField(
                          validator: (data){
                            if(data!.isEmpty){
                              return 'value is wrong';
                            }
                          },

                          decoration:
                          InputDecoration(
                            labelText: '',
                            hintStyle: TextStyle(

                              color: borderColor,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),

                          ),
                        ),
                      ),
                          SizedBox(height: 6,),
                          Text(
                            'Email',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.699999988079071),
                              fontSize: 16,
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.w500,

                              letterSpacing: 0.40,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15,bottom: 8,),
                            child: TextFormField(
                              validator: (data){
                                if(data!.isEmpty){
                                  return 'value is wrong';
                                }
                              },

                              decoration:
                              InputDecoration(
                                labelText: '',
                                hintStyle: TextStyle(

                                  color: borderColor,
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),

                              ),
                            ),
                          ),
                          SizedBox(height: 6,),
                          Text(
                            'Phone',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.699999988079071),
                              fontSize: 16,
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.w500,

                              letterSpacing: 0.40,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15,bottom: 8),
                            child: TextFormField(
                              validator: (data){
                                if(data!.isEmpty){
                                  return 'value is wrong';
                                }
                              },

                              decoration:
                              InputDecoration(
                                labelText: '',
                                hintStyle: TextStyle(

                                  color: borderColor,
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),

                              ),
                            ),
                          ),
                          SizedBox(height: 6,),
                          Text(
                            'Age',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.699999988079071),
                              fontSize: 16,
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.w500,

                              letterSpacing: 0.40,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: TextFormField(
                              validator: (data){
                                if(data!.isEmpty){
                                  return 'value is wrong';
                                }
                              },

                              decoration:
                              InputDecoration(
                                labelText: '',
                                hintStyle: TextStyle(

                                  color: borderColor,
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),


                              ),
                            ),
                          ),
                          SizedBox(height: 18,),
                          Padding(
                            padding: const EdgeInsets.only(top: 15,right: 15,),
                            child: CustomButon(text: 'Save',
                              onTap: () {},),
                          ),

                        ]

                    ),
                  ),

                ],
              ),
            ),
          ),
          Positioned(
                        top: 0,
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.white,
                          backgroundImage:AssetImage('assets/man.png') ,
                        )
                        ),
          Positioned(
                        top: 115,
                        right: 130,
                        child: Container(
                        width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color(0xff003248),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.camera,color: Colors.white, size: 25,),

                        ),
                        
                        )
        ],

      ),
    );
  }
}