import 'package:geolocator/geolocator.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketIOManager {
  static final SocketIOManager _instance = SocketIOManager._internal();
  late IO.Socket socket;

  factory SocketIOManager() {
    return _instance;
  }

  SocketIOManager._internal();

  static SocketIOManager get instance {
    return _instance;
  }

  void connect() {
    socket = IO.io('https://mutemotion.onrender.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.connect();

    socket.onConnect((_) {
      print('socket onConnect');
    });



    socket.onError((data) {
      print('Socket onError: $data');
    });

    socket.onConnectError((data) {
      print('socket onConnectError: $data');
    });


  }

  void disconnect() {
    if (socket.connected) {
      socket.disconnect();

      print('Socket disconnected and closed.');
    }
  }
  void emitDriverLocation(String driverId,Position position) {
    if (socket.connected&& driverId!=null) {


      socket.emit('updateLocation', {'driverId': driverId, 'location': {'latitude': position.latitude, 'longitude': position.longitude}});
      print('driver location send ');
    } else {
      print('Error: Socket not connected or id is null');
    }
  }
  void emitDriverconnection(String? driverId) {
    if (socket.connected&&driverId!=null) {

      socket.emit('connectDriver', {'driverId': driverId});
      print('connected driver');
    } else {
      print('Error: Socket not connected or initialized or id is null');
    }
  }
  void emitDriverdisconnection(String driverId) {
    if (socket.connected) {
      socket.emit('disconnectDriver', {'driverId': driverId});
    } else {
      print('Error: Socket not connected or initialized or id is null');
    }
  }
}