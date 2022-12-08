import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:practica1/models/places_model.dart';

class PlacesFirebase {
  late FirebaseFirestore? _firestore;
  CollectionReference? _placesCollection;

  PlacesFirebase() {
    _firestore = FirebaseFirestore.instance;
    _placesCollection = _firestore!.collection('places');
  }

  Future<void> insPlace(PlacesModel objPlace) {
    return _placesCollection!.add(objPlace.toMap());
  }

  Future<void> delPlace(String idPlace) {
    return _placesCollection!.doc(idPlace).delete();
  }

  Future<void> updPlace(PlacesModel objPlace, String idPlace) {
    return _placesCollection!.doc(idPlace).update(objPlace.toMap());
  }

  Stream<QuerySnapshot> getAllPlaces() {
    return _placesCollection!.snapshots();
  }
}
