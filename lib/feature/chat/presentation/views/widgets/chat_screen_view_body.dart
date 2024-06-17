import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:mute_motion/core/styles.dart';
import 'package:mute_motion/core/utils/constant.dart';
import 'package:mute_motion/feature/chat/controller/chat_controller.dart';
import 'package:mute_motion/feature/chat/model/messages.dart';
import 'package:mute_motion/feature/chat/presentation/views/widgets/message_item.dart';

import 'package:get/get.dart';


import 'chat_Item.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreenViewBody extends StatefulWidget {
  ChatScreenViewBody({super.key});

  @override
  State<ChatScreenViewBody> createState() => _ChatScreenViewBodyState();
}

class _ChatScreenViewBodyState extends State<ChatScreenViewBody> {
  TextEditingController msgController = TextEditingController();
  ChatController chatController = ChatController();
  late IO.Socket socket;
  String Time= '';
  @override
  void initState() {
    // TODO: implement initState
    socket = IO.io(
        'https://mutemotion.onrender.com/',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    socket.connect();
    setUpSocketListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            iconSize: 30,
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios,
              color: borderColor,
            )),
        title: Text(
          'Passenger',
          textAlign: TextAlign.center,
          style: TextStyle(
             fontFamily: 'Lato',
            color: borderColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(
        () => ListView.builder(
            itemCount: chatController.chatMessages.length,
            itemBuilder: (context, index) {
              var currentItem = chatController.chatMessages[index];
             // DateTime now = DateTime.now();
              /* String formattedTime = DateFormat('h:mm a').format(now);
              Time = formattedTime;
              print(formattedTime); */
              return MessageItem(
                sentByMe: currentItem.sentByMe == socket.id,
                message: currentItem.message,
                //time: Time,
              );
            }),
      ),
      bottomSheet: Container(
        color: borderColor,
        height: 160,
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: TextButton(
                        onPressed: () {
                          sendMessage('Hello');
                        },
                        child: Text(
                          'Hello',
                          overflow: TextOverflow.ellipsis,
                          style: Styles.textStyle12,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 40,
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: TextButton(
                        onPressed: () {
                          sendMessage('Where are you?');
                        },
                        child: Text(
                          'Where are you?',
                          overflow: TextOverflow.ellipsis,
                          style: Styles.textStyle12,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 40,
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: TextButton(
                        onPressed: () {
                          sendMessage('Don\'t be late. I\'m waiting for you!');
                        },
                        child: Text(
                          'Don\'t be late. I\'m waiting for you!',
                          overflow: TextOverflow.ellipsis,
                          style: Styles.textStyle12,
                        ),
                      ),
                    ), //
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 40,
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: TextButton(
                        onPressed: () {
                          sendMessage('I\'m coming');
                        },
                        child: Text(
                          'I\'m coming',
                          overflow: TextOverflow.ellipsis,
                          style: Styles.textStyle12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    cursorColor: borderColor,
                    controller: msgController,
                    decoration: InputDecoration(
                      hintText: 'Message',
                      suffixIcon: IconButton(
                          onPressed: () {
                            sendMessage(msgController.text);
                            msgController.text = "";
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.solidPaperPlane,
                            color: borderColor,
                          )),
                      hintStyle: TextStyle(
                         fontFamily: 'Comfortaa',
                        color: Colors.black.withOpacity(0.65),
                        fontSize: 12,
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendMessage(String text) {
    print('dxzxzxzx');
    var messageJson = {"message": text, "sentByMe": socket.id};
    socket.emit('message', messageJson);
    chatController.chatMessages.add(Message.fromJson(messageJson));
    print('sentttt');
  }

  void setUpSocketListener() {
    socket.on('message-receive', (data) {
      print(data);
      chatController.chatMessages.add(Message.fromJson(data));
    });
  }
}
