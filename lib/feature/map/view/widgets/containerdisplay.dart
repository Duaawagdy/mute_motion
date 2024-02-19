import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mute_motion/feature/map/view/widgets/custembutten.dart';
import 'package:mute_motion/feature/map/view/widgets/cutemfield.dart';
import 'package:provider/provider.dart';

class maindisplay extends StatelessWidget {
  //final GoogleMapController? googleMapControllermap;
  

  const maindisplay({super.key, });
  @override
  Widget build(BuildContext context) {
    return
       ChangeNotifierProvider(
        create: (context) => WidgetSwitcher(null),
        child: displaydetailscontaine( ),

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
    return Consumer<WidgetSwitcher>(
        builder: (context, widgetSwitcher, _) {
          return
            AnimatedContainer(
            padding: EdgeInsets.only(bottom: 15),
            width:MediaQuery
                .of(context)
                .size
                .width,
            child:widgetSwitcher.currentWidget
            /* setLocationWidget(
              googleMapControllerconfirm: googleMapController,
              onPressed: WidgetSwitcher,),
            //height: 346,

            */

            ,decoration: const BoxDecoration(
                color: Color(0xff003248),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )
            ), duration: Duration(seconds: 1),curve: Curves.fastOutSlowIn,
            )
          ;
        })
    ;
  }
}
class WidgetSwitcher extends ChangeNotifier {
  late Widget _currentWidget;
  final GoogleMapController? googleMapControllerconfirm;
  WidgetSwitcher(this.googleMapControllerconfirm) {
    _currentWidget =
        setLocationWidget(
          onPressed: switchToWidget2,
          googleMapControllerconfirm:null ,);
  }

  Widget get currentWidget => _currentWidget;

  void switchToWidget2() {
    _currentWidget = StartDrive(googleMapControllerstartdrive: null,);
    notifyListeners();
  }
}
class StartDrive extends StatelessWidget{
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
        SizedBox(height: 18,),
        Text('1 hr 10 min \(10km\)',style: TextStyle(
            fontSize: 21, fontFamily:'comfortaa', color: Color(
            0xffffffff))),
        SizedBox(height: 9,),
        Text('Fastest route now due to traffic conditions',style: TextStyle(
            fontSize: 18, fontFamily:'comfortaa', color: Color(
            0xffffffff))),
        SizedBox(height: 20,),
        Container(decoration: BoxDecoration(
            color: const Color(0xffffffff) ,
            borderRadius: BorderRadius.circular(15)),child: custembuttenWhite(googleMapController: googleMapControllerstartdrive, text: 'Start Drive', onPressed: () {  },))
      ],),
    );
  }

}
class setLocationWidget extends StatelessWidget {
  const setLocationWidget({
    super.key,
    required this.googleMapControllerconfirm, required this.onPressed,
  });

  final GoogleMapController? googleMapControllerconfirm;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 18,),
        Text('Set your loction',textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 21, fontFamily:'comfortaa', color: Color(
                0xffffffff))),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 29.0),
          child: Divider(color: Color(0xFFFFFFFF),),
        ),
        SizedBox(height: 24,),
        custemlabel(icon: Icons.location_on_sharp, Place: 'Elzamalk - Egypt'),
        SizedBox(height: 24,),
        custemlabel(icon: FontAwesomeIcons.locationArrow, Place: 'Cairo Festival Mall - Nasr City'),
        SizedBox(height: 24,),
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
                    color: const Color(0xffffffff) ,
                    borderRadius: BorderRadius.circular(15)),
                child: custembuttenWhite(googleMapController: googleMapControllerconfirm, text: 'Confirm', onPressed: onPressed,),
              ),
              SizedBox(width: 20,),
              custembuttensearch()
            ],),
          ),
        )
      ],
    );
  }
}