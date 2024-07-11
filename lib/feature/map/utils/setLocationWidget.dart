import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../chat/presentation/views/chat_screen_view.dart';

class SetLocationWidget extends StatelessWidget {
  final GoogleMapController? googleMapControllerConfirm;
  final VoidCallback onPressed;

  const SetLocationWidget({
    Key? key,
    required this.googleMapControllerConfirm,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 18),
        Text(
          'Set your location',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 21, fontFamily: 'comfortaa', color: Color(0xffffffff)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 29.0),
          child: Divider(color: Color(0xFFFFFFFF)),
        ),
        SizedBox(height: 24),
        // Replace with your custom label widget
        Text("Zagazig University "),
        SizedBox(height: 24),
        Text('Cairo'),
        SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 51,
                  width: 171,
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ElevatedButton(
                    onPressed: onPressed,
                    child: Text('Confirm'),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChatScreenView()),
                    );
                  },
                  child: Text('chat'),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
