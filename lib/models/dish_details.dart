import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ServingDetails extends ChangeNotifier{
  String? name;
  String? kCal;
  String? image;
  List<ServingDetails> recipeList = [];


  ServingDetails({this.image, this.name, this.kCal});

  factory ServingDetails.fromJson(dynamic json) {
    return ServingDetails(name: json['name'].toString(), kCal: json['kCal'].toString());
  }

  Future<List<ServingDetails>> getServingDetails() async {
    Response response = await get(Uri.parse('https://recipeappserver.herokuapp.com/getAllRecipes'));
    String responseBody = response.body;
    var dynamicRecipesList = jsonDecode(responseBody)['recipes'] as List;
    recipeList = dynamicRecipesList.map((json) => ServingDetails.fromJson(json)).toList();
    notifyListeners();
    return recipeList;
  }

  void removeItem(int index) {
    recipeList.removeAt(index);
    notifyListeners();
  }

  @override
  String toString() {
    return '{ $name, $kCal }';
  }
}