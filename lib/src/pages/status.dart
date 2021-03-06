import 'package:flutter/material.dart';
import 'package:graphic_band_names/src/services/socket_service.dart';
import 'package:provider/provider.dart';

class StatusPage extends StatelessWidget {
  static String routeName = 'status_page';

  @override
  Widget build(BuildContext context) {
    final _socketService = Provider.of<SocketService>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Estatus ${_socketService.serverStatus}')],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: () {
          //tarea
          // al tocar el botn emitir un evento

          //   {
          //     nombre: 'Flutter',
          //   message: 'Hola desde la app de flutter'
          // }
          _socketService.socket.emit('new_message', {'name': 'Flutter', 'message': 'Hola desde la app de flutter'});
        },
      ),
    );
  }
}
