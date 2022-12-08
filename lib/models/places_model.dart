import 'package:flutter/foundation.dart';

class PlacesModel {
  String? titlePlace;
  String? imgPlace;
  double? latPlace;
  double? lonPlace;
  String? dscPlaces;

  PlacesModel(
      {this.titlePlace,
      this.imgPlace,
      this.latPlace,
      this.lonPlace,
      this.dscPlaces});

  Map<String, dynamic> toMap() {
    return {
      'titlePlace': this.titlePlace,
      'imgPlace': this.imgPlace,
      'latPlace': this.latPlace,
      'lonPlace': this.lonPlace,
      'dscPlaces': this.dscPlaces
    };
  }
}
