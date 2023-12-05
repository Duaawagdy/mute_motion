import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mute_motion/feature/sidebar/presentation/view/sidebar.dart';

class Chat_Screen extends StatefulWidget {
  const Chat_Screen({super.key});

  @override
  State<Chat_Screen> createState() => _Chat_ScreenState();
}

class _Chat_ScreenState extends State<Chat_Screen> {
  List messages = [
    "Where are you? ",
    "I’m arriving soon",
    "I’m here",
    "Don’t be late, I’m waiting you",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color:  Color(0xff003248)),
        title: Text(
          'Yara Afifi',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Lato',
              color: Color(0xff003248)),
        ),
        //leading: Icon(Icons.menu, color: Color(0xff003248), size: 30,),
        actions: [Padding(padding: const EdgeInsets.only(right: 7), child: IconButton(iconSize: 25, onPressed: () {}, icon: Icon(FontAwesomeIcons.phone, color: Color(0xff003248),)),),],
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      bottomSheet: Container(
        height: 160,
        color: Color(0xff003248),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                height: 55,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Center(
                          child: Text(
                            messages[index],
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  IconButton(
                      iconSize: 30,
                      onPressed: () {},
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      )),
                  Container(
                    height: 45,
                    width: 235,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Message...",
                        //border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      iconSize: 30,
                      onPressed: () {},
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      )),
                  IconButton(
                      iconSize: 25,
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.paperPlane,
                        color: Colors.white,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
