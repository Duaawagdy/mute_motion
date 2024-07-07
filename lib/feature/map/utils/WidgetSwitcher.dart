import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'setLocationWidget.dart';


class WidgetSwitcher extends ChangeNotifier {
  late Widget _currentWidget;
  final GoogleMapController? googleMapControllerconfirm;

  WidgetSwitcher(this.googleMapControllerconfirm) {
    _currentWidget = SetLocationWidget(
      onPressed: switchToWidget2,
      googleMapControllerConfirm: googleMapControllerconfirm,
    );
  }

  Widget get currentWidget => _currentWidget;

  void switchToWidget2() {
    _currentWidget = StartDrive(googleMapControllerstartdrive: googleMapControllerconfirm);
    notifyListeners();
  }
}

class StartDrive extends StatelessWidget {
  final GoogleMapController? googleMapControllerstartdrive;

  const StartDrive({
    Key? key,
    required this.googleMapControllerstartdrive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 18),
          Text(
            '1 hr 10 min (10km)',
            style: TextStyle(fontSize: 21, fontFamily: 'comfortaa', color: Color(0xffffffff)),
          ),
          SizedBox(height: 9),
          Text(
            'Fastest route now due to traffic conditions',
            style: TextStyle(fontSize: 18, fontFamily: 'comfortaa', color: Color(0xffffffff)),
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffffffff),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ElevatedButton(
              onPressed: () {
                // Start drive button action
              },
              child: Text('Start Drive'),
            ),
          ),
        ],
      ),
    );
  }
}
