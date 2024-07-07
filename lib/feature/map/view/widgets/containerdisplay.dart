import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utils/WidgetSwitcher.dart';


class maindisplay extends StatelessWidget {
  final GoogleMapController? googleMapController;

  const maindisplay({Key? key, this.googleMapController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WidgetSwitcher>(
      create: (context) => WidgetSwitcher(googleMapController),
      child: displaydetailscontaine(),
    );
  }
}

class displaydetailscontaine extends StatefulWidget {
  const displaydetailscontaine({Key? key}) : super(key: key);

  @override
  State<displaydetailscontaine> createState() => _displaydetailscontaineState();
}

class _displaydetailscontaineState extends State<displaydetailscontaine> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WidgetSwitcher>(
      builder: (context, widgetSwitcher, _) {
        return AnimatedContainer(
          padding: EdgeInsets.only(bottom: 15),
          width: MediaQuery.of(context).size.width,
          child: widgetSwitcher.currentWidget,
          decoration: const BoxDecoration(
            color: Color(0xff003248),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
        );
      },
    );
  }
}
