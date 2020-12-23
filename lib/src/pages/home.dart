import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphic_band_names/src/models/band_model.dart';

class HomePage extends StatefulWidget {
  static String routeName = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BandModel> bands = [
    BandModel(id: '1', name: 'Metallica', votes: 3),
    BandModel(id: '2', name: 'Queen', votes: 3),
    BandModel(id: '3', name: 'Extremo duro', votes: 3),
    BandModel(id: '4', name: 'Estopa', votes: 3),
    BandModel(id: '5', name: 'Marea', votes: 10),
    BandModel(id: '6', name: 'Pink!', votes: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    onPressed: () => addBandList(_textController.text)
                )
              ],
            );
          }
      );
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
                    onPressed: () => Navigator.pop(context)
                ),
                CupertinoDialogAction(
                  isDefaultAction: true,
                    child: Text('Add'),
                    onPressed: () => addBandList(_textController.text)
                ),
              ],
            );
          }
      );
    }
  }

  void addBandList(String name) {
    if (name.length > 1) {
      // se agrega la banda a la lista/back y lo que sea
      BandModel model = BandModel(id: DateTime.now().toString(), name: name, votes: 3);
      this.bands.add(model);
      setState(() {});
    }
    Navigator.pop(context);
  }

  ListTile _buildListTile(BandModel band) {
    return ListTile(
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
        print(band);
      },
    );
  }
}
