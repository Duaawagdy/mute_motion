import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mute_motion/feature/feedback/presentation/view/feedback_screen.dart';


import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../chat/presentation/views/chat_screen_view.dart';
import '../../../finishrequest/finishrequest_api.dart';
import '../../../signs/presentation/view/signs.dart';
import 'custembutten.dart';
import 'cutemfield.dart';

class maindisplay extends StatelessWidget {
  const maindisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WidgetSwitcher(null),
      child: displaydetailscontaine(),
    );
  }
}

class displaydetailscontaine extends StatefulWidget {
  const displaydetailscontaine({
    super.key,
  });

  //static final GoogleMapController? googleMapController;

  @override
  State<displaydetailscontaine> createState() => _displaydetailscontaineState();
}

class _displaydetailscontaineState extends State<displaydetailscontaine> {
  //final GoogleMapController? googleMapController;

  _displaydetailscontaineState();
  @override
  Widget build(BuildContext context) {
    return Consumer<WidgetSwitcher>(builder: (context, widgetSwitcher, _) {
      return AnimatedContainer(
        padding: EdgeInsets.only(bottom: 15),
        width: MediaQuery.of(context).size.width,
        child: widgetSwitcher.currentWidget,
        decoration: BoxDecoration(
            color: Color(0xff003248),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            )),
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    });
  }
}

class WidgetSwitcher extends ChangeNotifier {
  late Widget _currentWidget;
  final GoogleMapController? googleMapControllerconfirm;
  WidgetSwitcher(this.googleMapControllerconfirm) {
    _currentWidget = setLocationWidget(
      onPressed: switchToWidget2,
      googleMapControllerconfirm: null,
    );
  }

  Widget get currentWidget => _currentWidget;

  void switchToWidget2() {
    _currentWidget = StartDrive(
      googleMapControllerstartdrive: null,
    );
    notifyListeners();
  }
}

class StartDrive extends StatelessWidget {
  const StartDrive({
    super.key,
    required this.googleMapControllerstartdrive,
  });
  final GoogleMapController? googleMapControllerstartdrive;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 18,
          ),
          Text('1 hr 30 min \(200km\)',
              style: TextStyle(
                  fontSize: 21,
                  fontFamily: 'comfortaa',
                  color: Color(0xffffffff))),
          SizedBox(
            height: 9,
          ),
          Text('Fastest route now due to traffic conditions',
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'comfortaa',
                  color: Color(0xffffffff))),
          SizedBox(
            height: 20,
          ),
          Container(
              decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(15)),
              child: custembuttenWhite(
                googleMapController: googleMapControllerstartdrive,
                text: 'End drive',
                onPressed: () {

          ApiService().completeOrder(context);

          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FeedbackScreen()),
          );
          },
              )),
          SizedBox(
            height: 20,
          ),
          Container(
              decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(15)),
              child:IconButton(
                icon: Icon(Icons.sign_language_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>   signs()),
                  );
                },
              )),




        ],
      ),
    );
  }
}

class setLocationWidget extends StatefulWidget {

  setLocationWidget({
    super.key,
    required this.googleMapControllerconfirm,
    required this.onPressed,
  });
  final GoogleMapController? googleMapControllerconfirm;
  final VoidCallback onPressed;

  @override
  State<setLocationWidget> createState() => _setLocationWidgetState();
}

class _setLocationWidgetState extends State<setLocationWidget> {
  Future<void> setvalues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      cost = prefs.getString('cost');
      print("cost us${cost}");
      startlocationname = prefs.getString('startlocationname');
      endlocationname = prefs.getString('endlocationname');
      print('end $endlocationname');
    });
  }

  String? cost;

  String? startlocationname;

  String? endlocationname;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setvalues();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        const Text('Request details',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 21,
                fontFamily: 'comfortaa',
                color: Color(0xffffffff))),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 29.0),
          child: Divider(
            color: Color(0xFFFFFFFF),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        custemlabel(icon: Icons.location_on_sharp, Place: startlocationname),
        const SizedBox(
          height: 15,
        ),
        custemlabel(
            icon: FontAwesomeIcons.locationArrow,
            Place: endlocationname),
        const SizedBox(
          height: 15,
        ),
         custemlabel(icon: Icons.monetization_on, Place: cost),
        const SizedBox(
          height: 15,
        ),

        //TextField(e),
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
    onPressed: widget.onPressed,
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
