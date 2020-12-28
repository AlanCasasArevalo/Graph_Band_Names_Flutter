import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  SocketService() {
    _setupConfig();
  }

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;

  void _setupConfig() {
    String url = 'http://localhost:3000';

    // Dart client
    _socket = IO.io(url, {
      'transports': ['websocket'],
      'autoConnect': true
    });
    _socket.onConnect((_) {
      print('connect');
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    // socket.on('new_message', (payload) => {
    //   print('nombre: ${payload.containsKey('name') ? payload['name'] : ''}'),
    //   print('message: ${payload.containsKey('message') ? payload['message'] : ''}')
    // });

    _socket.onDisconnect((_) {
      print('disconnect');
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }
}
