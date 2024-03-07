import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mute_motion/feature/map/view/widgets/custembutten.dart';
import 'package:mute_motion/feature/map/view/widgets/cutemfield.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
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
                child: custembuttenWhite(googleMapController: googleMapControllerconfirm, text: 'Confirm', onPressed: (){
                  server();
                },),
              ),
              SizedBox(width: 20,),
              custembuttensearch()
            ],),
          ),
        )
      ],
    );
  }
  void server()async{
    final url = 'https://router.project-osrm.org/route/v1/car/30.596914863758823,31.475045710400234;30.596244768305716,31.47646756515574?geometries=polyline&annotations=true';
    final response = await http.get(
        Uri.parse(url)    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      // Extract information from the response
      List<dynamic> routes = data['routes'];
      if (routes.isNotEmpty) {
        Map<String, dynamic> route = routes[0];
        print('Distance: ${route['distance']} meters');
        print('Duration: ${route['duration']} seconds');

        // Extract OSM node IDs and coordinates
        List<dynamic> legs = route['legs'];
        for (var leg in legs) {
          List<dynamic> steps = leg['steps'];
          for (var step in steps) {
            List<dynamic> intersections = step['intersections'];
            for (var intersection in intersections) {
              print('OSM Node ID: ${intersection['osm_node_id']}');
              print('Coordinates: ${intersection['location']}');
            }
          }
        }
      }
    } else {
      print('Failed to fetch route details. Status code: ${response.statusCode}');
    }
  }
}
/*Padding(
  padding: EdgeInsetsDirectional.fromSTEB(12, 32, 12, 12),
  child: Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: FlutterFlowTheme.of(context).secondaryBackground,
      boxShadow: [
        BoxShadow(
          blurRadius: 3,
          color: Color(0x33000000),
          offset: Offset(0, 1),
        )
      ],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 4, 10, 4),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              width: 300,
              child: TextFormField(
                controller: _model.textController,
                focusNode: _model.textFieldFocusNode,
                onChanged: (_) => EasyDebounce.debounce(
                  '_model.textController',
                  Duration(milliseconds: 100),
                  () => setState(() {}),
                ),
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'Type something...',
                  hintStyle: FlutterFlowTheme.of(context).bodySmall,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  focusedErrorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                ),
                style: FlutterFlowTheme.of(context).bodyMedium,
                maxLines: 8,
                minLines: 1,
                keyboardType: TextInputType.multiline,
                validator:
                    _model.textControllerValidator.asValidator(context),
              ),
            ),
          ),
          FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.send_rounded,
              color: FlutterFlowTheme.of(context).primary,
              size: 30,
            ),
            showLoadingIndicator: true,
            onPressed: () async {
              setState(() {
                _model.chatHistory = functions.saveChatHistory(
                    _model.chatHistory,
                    functions.convertToJSON(_model.textController.text));
              });
              // Put your API key in the API value below in order to make this a functional app.
              _model.chatGPTResponse =
                  await OpenAIChatGPTGroup.sendFullPromptCall.call(
                apiKey: 'No Key',
                promptJson: _model.chatHistory,
              );
              if ((_model.chatGPTResponse?.succeeded ?? true)) {
                setState(() {
                  _model.chatHistory = functions.saveChatHistory(
                      _model.chatHistory,
                      getJsonField(
                        (_model.chatGPTResponse?.jsonBody ?? ''),
                        r'''$['choices'][0]['message']''',
                      ));
                });
                setState(() {
                  _model.textController?.clear();
                });
              }
              await Future.delayed(const Duration(milliseconds: 800));
              await _model.listViewController?.animateTo(
                _model.listViewController!.position.maxScrollExtent,
                duration: Duration(milliseconds: 100),
                curve: Curves.ease,
              );
              setState(() {});
            },
          ),
        ],
      ),
    ),
  ),
)
*/