import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphic_band_names/src/models/band_model.dart';
import 'package:graphic_band_names/src/services/socket_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static String routeName = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BandModel> bands = [];

  @override
  void initState() {
    final _socketService = Provider.of<SocketService>(context, listen: false);
    _socketService.socket.on('active_bands', _handleActiveBands);
    super.initState();
  }

  _handleActiveBands (dynamic payload) {
    this.bands =
        (payload as List).map((band) => BandModel.fromMap(band)).toList();
    setState(() {});
  }

  @override
  void dispose() {
    final _socketService = Provider.of<SocketService>(context, listen: false);
    _socketService.socket.off('active_bands');
    // _socketService.socket.dispose();
    // _socketService.socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
              margin: EdgeInsets.only(right: 10),
              // child: Icon(Icons.check_circle, color: Colors.green,),
              child: _getIcon(_socketService.serverStatus))
        ],
        title: Text(
          'Bands',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (BuildContext context, int index) =>
              _buildListTile(bands[index])),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: addNewBand,
        elevation: 2,
      ),
    );
  }

  Icon _getIcon(ServerStatus status) {
    if (status == ServerStatus.Online) {
      return Icon(
        Icons.check_circle,
        color: Colors.green,
      );
    } else if (status == ServerStatus.Offline) {
      return Icon(
        Icons.offline_bolt,
        color: Colors.red,
      );
    } else {
      return Icon(
        Icons.refresh,
        color: Colors.grey,
      );
    }
  }

  void addNewBand() {
    final _textController = TextEditingController();

    if (Platform.isAndroid) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('New band name:'),
              content: TextField(
                controller: _textController,
              ),
              actions: [
                MaterialButton(
                    child: Text('Add'),
                    elevation: 5,
                    textColor: Colors.blue,
                    onPressed: () => addBandList(_textController.text))
              ],
            );
          });
    } else {
      showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text('New band name:'),
              content: CupertinoTextField(
                controller: _textController,
              ),
              actions: [
                CupertinoDialogAction(
                    isDestructiveAction: false,
                    child: Text('Cancel'),
                    onPressed: () => Navigator.pop(context)),
                CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text('Add'),
                    onPressed: () => addBandList(_textController.text)),
              ],
            );
          });
    }
  }

  void addBandList(String name) {
    if (name.length > 1) {
    final _socketService = Provider.of<SocketService>(context, listen: false);
      _socketService.socket.emit('add_new_band', { 'name': name });
    }
    Navigator.pop(context);
  }

  Dismissible _buildListTile(BandModel band) {
    final _socketService = Provider.of<SocketService>(context, listen: false);
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      background: Container(
          padding: EdgeInsets.only(left: 8),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Deleting ...',
                style: TextStyle(color: Colors.white),
              )),
          color: Colors.red),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.id);
          _socketService.socket.emit('vote_band', {'id': band.id});
        },
      ),
      onDismissed: (direction) {
        _socketService.socket.emit('delete_band', {'id': band.id});
      },
    );
  }
}
