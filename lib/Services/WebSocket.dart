import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../Model/DriverLocTripModel.dart';
import '../Model/TripDriverData.dart';

class SocketService {
  final String companyId;
  late IO.Socket _socket;

  SocketService(this.companyId);
  final StreamController<List<Drivers>> _driverController = StreamController.broadcast();
  Stream<List<Drivers>> get driverStream => _driverController.stream;

  final StreamController<List<Trips>> _driverTripController = StreamController.broadcast();
  Stream<List<Trips>> get driverDataStream => _driverTripController.stream;



  void init() {
    _socket = IO.io(
      'https://vr-safetrips.onrender.com',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .build(),
    );

    _socket.onConnect((_) {
      print('✅ Connected to Socket.IO server');

      // Emit get-drivers once (static data)
      _socket.emit('get-drivers', {'companyId': companyId});

      // Emit get-drivers-data initially
      _socket.emit('get-drivers-data', {'companyId': companyId});

      // 🔁 Emit get-drivers-data every 10 seconds
      Timer.periodic(Duration(seconds: 10), (_) {
        if (_socket.connected) {
          _socket.emit('get-drivers', {'companyId': companyId});
        }
      });
      // Timer.periodic(Duration(seconds: 10), (_) {
      //   if (_socket.connected) {
      //     _socket.emit('get-drivers-data', {'companyId': companyId});
      //   }
      // });
    });

    _socket.on('company-drivers', (data) {
      print('📡 Received company-drivers event');

      try {
        if (data['drivers'] != null &&
            data['drivers'] is List &&
            data['drivers'].isNotEmpty &&
            data['drivers'][0]['tripId'] != null) {
          final parsedTrips = TripsDriverData.fromJson(data);
          _driverController.add(parsedTrips.drivers!);

          print('📋 Trip data parsed');
        } else if (data['trips'] != null &&
            data['trips'] is List &&
            data['trips'].isNotEmpty &&
            data['trips'][0]['driver'] != null ) {
          final parsedLocations = DriverLoc.fromJson(data);
          _driverTripController.add(parsedLocations.trips!);
        }
      } catch (e) {
        print('❗ Error parsing company-drivers data: $e');
      }
    });

    _socket.onConnectError((err) => print('❌ Connect Error: $err'));
    _socket.onError((err) => print('⚠️ Socket Error: $err'));
    _socket.onDisconnect((_) => print('🔌 Disconnected from server'));
  }


  void dispose() {
    _socket.dispose();
  }
}
