import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;

  SocketService() {
    _setupConfig();
  }

  get serverStatus => this._serverStatus;

  void _setupConfig() {
    String url = 'http://localhost:3000';

    // Dart client
    IO.Socket socket = IO.io(url, {
      'transports': ['websocket'],
      'autoConnect': true
    });
    socket.onConnect((_) {
      print('connect');
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    socket.on('new_message', (payload) => {
      print('nombre: ${payload.containsKey('name') ? payload['name'] : ''}'),
      print('message: ${payload.containsKey('message') ? payload['message'] : ''}')
    });

    socket.onDisconnect((_) {
      print('disconnect');
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }
}
