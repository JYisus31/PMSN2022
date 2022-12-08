import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase/places_firebase.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({Key? key}) : super(key: key);

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  PlacesFirebase? _palacesFirebase;

  @override
  void initState() {
    super.initState();
    _palacesFirebase = PlacesFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Streambuilder Firebase'),
      ),
      body: StreamBuilder(
          stream: _palacesFirebase!.getAllPlaces(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var place = snapshot.data!.docs[index];
                    return ListTile(
                      leading: Image.network(place.get('imgPlace')),
                      title: Text(place.get('titlePlace')),
                      subtitle: Text(place.get('dscPlace')),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  _palacesFirebase!.delPlace(place.id);
                                },
                                icon: Icon(Icons.delete)),
                          ],
                        ),
                      ),
                    );
                  });

              //Text(snapshot.data!.docs.first.get('titlePlace'));
            } else {
              if (snapshot.hasError) {
                return Center(
                  child: Text("ERROR"),
                );
              } else {
                return const CircularProgressIndicator();
              }
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/addplace'),
        child: Icon(Icons.add),
      ),
    );
  }
}
