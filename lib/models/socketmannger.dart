import 'package:geolocator/geolocator.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketIOManager {
  static late final SocketIOManager _instance = SocketIOManager();
  late IO.Socket socket;

  static SocketIOManager get instance {
    return _instance;
  }

  void connect() {
    socket = IO.io('https://mutemotion.onrender.com');
    socket.connect();
    socket.onConnect((_) {
      print('socket onConnect');
    });


    socket.onDisconnect((_) {
      print('socket onDisconnect');
    });
    socket.onError((data) {
      print('Socket onError: $data');

    });
    if (socket.disconnected) {
      socket.connect();
    }
  }

  void disconnect() {
    socket.disconnect();
    socket.close();
  }
  void emitDriverLocation(String driverId,Position position) {
    if (socket.connected) {
      Map messageMap = {
        'driverId': driverId,
        "Lat":position.latitude
        ,"Lon":position.longitude
      };

      socket.emit('updateLocation', messageMap);
    } else {
      print('Error: Socket not connected or initialized');
    }
  }
  void emitDriverconnection(String driverId) {
    if (socket.connected) {
      socket.emit('connectDriver', {'driverId': driverId});
    } else {
      print('Error: Socket not connected or initialized');
    }
  }
  void emitDriverdisconnection(String driverId) {
    if (socket.connected) {
      socket.emit('disconnectDriver', {'driverId': driverId});
    } else {
      print('Error: Socket not connected or initialized');
    }
  }
}
/*
  void emitDriverLocation(String driverId,Position position) {
    if (socket != null && socket!.connected) {
      Map messageMap = {
        'driverId': driverId,
        "Lat":position.latitude
        ,"Lon":position.longitude
      };

      socket!.emit('updateLocation', messageMap);
    } else {
      print('Error: Socket not connected or initialized');
    }
  }
  void emitDriverconnection(String driverId) {
    if (socket != null && socket!.connected) {
      socket!.emit('connectDriver', {'driverId': driverId});
    } else {
      print('Error: Socket not connected or initialized');
    }
  }
  void emitDriverdisconnection(String driverId) {
    if (socket != null && socket!.connected) {
      socket!.emit('disconnectDriver', {'driverId': driverId});
    } else {
      print('Error: Socket not connected or initialized');
    }
  }*/