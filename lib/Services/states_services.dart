import 'dart:convert';

import 'package:covid_19_tracker_app/Model/worldstatesmodel.dart';
import 'package:covid_19_tracker_app/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class Statesservices {
  Future<WorldStatesModel> worldstates() async {
    final responce = await http.get(Uri.parse(Appurl.worldStatesApi));

    if (responce.statusCode == 200) {
      var data = jsonDecode(responce.body.toString());
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countriesList() async {
    var data;
    final responce = await http.get(Uri.parse(Appurl.countriesList));

    if (responce.statusCode == 200) {
      data = jsonDecode(responce.body.toString());
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
