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
        onPressed: () {},
        elevation: 2,
      ),
    );
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
