import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mute_motion/core/utils/constant.dart';
import 'package:mute_motion/core/utils/theming/styles.dart';
import 'package:mute_motion/feature/chat/controller/chat_controller.dart';
import 'package:mute_motion/feature/chat/model/messages.dart';
import 'package:mute_motion/feature/chat/presentation/views/widgets/message_item.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'chat_Item.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

/* class ChatScreenViewBody extends StatefulWidget {
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
      body: Padding(
        padding: const EdgeInsets.only(bottom: 160),
        child: Obx(
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
      ),
      bottomSheet: Container(
        color: borderColor,
        height: 160,
        width: double.infinity,
        child: SingleChildScrollView(
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
 */
class ChatScreenViewBody extends StatefulWidget {
  ChatScreenViewBody({super.key});

  @override
  State<ChatScreenViewBody> createState() => _ChatScreenViewBodyState();
}

class _ChatScreenViewBodyState extends State<ChatScreenViewBody> {
  TextEditingController msgController = TextEditingController();
  ChatController chatController = Get.put(ChatController());
  late IO.Socket socket;
  bool isPassengerTyping = false;
  String driverId = '';
  String passengerId = '';
 void fetchIds() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    driverId= prefs.getString('userId')!;
    passengerId = prefs.getString('passengerId')!;
     connectDriver();  
     fetchChatHistory();
 }
  @override
  void initState() {
    fetchIds();
    super.initState();
    socket = IO.io(
        'https://mutemotion.onrender.com/',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    socket.connect();
    setUpSocketListener();
   
  
  }

  @override
  void dispose() {
    disconnectDriver();  
    super.dispose();
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
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 160),
            child: Obx(
              () => ListView.builder(
                  itemCount: chatController.chatMessages.length,
                  itemBuilder: (context, index) {
                    var currentItem = chatController.chatMessages[index];
                    return MessageItem(
                      sentByMe: currentItem.senderId == driverId,
                      message: currentItem.message,
                      //time: currentItem.time,
                    );
                  }),
            ),
          ),
          if (isPassengerTyping)
            Positioned(
              top: 10,
              left: MediaQuery.of(context).size.width * 0.5 - 60,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Passenger is typing...",
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomSheet: Container(
        color: borderColor,
        height: 160,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      _buildQuickReplyButton('Hello'),
                      SizedBox(width: 5),
                      _buildQuickReplyButton('Where are you?'),
                      SizedBox(width: 5),
                      _buildQuickReplyButton('Don\'t be late. I\'m waiting for you!'),
                      SizedBox(width: 5),
                      _buildQuickReplyButton('I\'m coming'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    cursorColor: borderColor,
                    controller: msgController,
                    onChanged: (text) {
                      sendTypingEvent();
                    },
                    onFieldSubmitted: (text) {
                      sendStopTypingEvent();
                    },
                    decoration: InputDecoration(
                      hintText: 'Message',
                      suffixIcon: IconButton(
                        onPressed: () {
                          sendMessage(msgController.text);
                          msgController.clear();
                          sendStopTypingEvent();
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.solidPaperPlane,
                          color: borderColor,
                        ),
                      ),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickReplyButton(String text) {
    return Container(
      height: 40,
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: TextButton(
        onPressed: () {
          sendMessage(text);
        },
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: Styles.textStyle12,
        ),
      ),
    );
  }

  void sendMessage(String text) {
    var messageJson = {
      "senderId": driverId,
      "receiverId": passengerId,  
      "message": text,
      "senderType": 'driver'
    };
    socket.emit('message', messageJson);
    chatController.chatMessages.add(Message.fromJson(messageJson));
  }

  void sendTypingEvent() {
    socket.emit('typing', {
      'senderId': driverId,
      'receiverId': passengerId, 
      'senderType': 'driver'
    });
  }

  void sendStopTypingEvent() {
    socket.emit('stop-typing', {
      'senderId': driverId,
      'receiverId': passengerId, 
      'senderType': 'driver'
    });
  }

  void setUpSocketListener() {
    socket.on('message-receive', (data) {
      chatController.chatMessages.add(Message.fromJson(data));
    });

    socket.on('typing', (data) {
      if (data['senderType'] == 'passenger') {
        setState(() {
          isPassengerTyping = true;
        });
      }
    });

    socket.on('stop-typing', (data) {
      if (data['senderType'] == 'passenger') {
        setState(() {
          isPassengerTyping = false;
        });
      }
    });
  }

  void connectDriver() {
    socket.emit('connectDriver', {'driverId': driverId}); 
  }

  void disconnectDriver() {
    socket.emit('disconnectDriver', {'driverId': driverId});  
  }

  void fetchChatHistory() async {
    try {
      var response = await http.get(
        Uri.parse(
          'https://mutemotion.onrender.com/chat-history?senderId=$driverId&receiverId=$passengerId',
        ),
      );
      if (response.statusCode == 200) {
        var messages = jsonDecode(response.body);
        for (var message in messages) {
          chatController.chatMessages.add(Message.fromJson(message));
        }
      }
    } catch (e) {
      print('Error fetching chat history: $e');
    }
  }
}



