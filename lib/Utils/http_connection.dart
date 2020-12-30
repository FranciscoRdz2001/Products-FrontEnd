import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:productsfrontend/Models/Products.dart';
import 'package:http/http.dart' as http;

class HttpOperations with ChangeNotifier{


  List<Products> _products;
  List<Products> _productsToShow;
  static const String _url = "http://2f021cc7afd9.ngrok.io";
  static const String _route = "Products";
  String _lastUpdate = "";


  // Providers
  
  // Products data
  List<Products> get productsToShow => _productsToShow;
  set productsToShow (List<Products> value){
    _productsToShow = value;
    notifyListeners();
  }

  // Last Update Data
  String get lastUpdate => _lastUpdate;
  set lastUpdate(String value){
    _lastUpdate = value;
    notifyListeners();
  }

  // Search product in list
  void searchProduct(String name){
    productsToShow = _products.where((Products p) => p.name.toLowerCase().contains(name.toLowerCase())).toList();
    print("Encontrados ${productsToShow.length} de ${_products.length} ");
  }

  // Obtain list of products in BD
  Future getProducts() async{
    print("Getting Products...");
    try {
      
      // Http Pettions
      http.Response response = await http.get("$_url/$_route");
      productsToShow = _products = (json.decode(response.body) as List).map((dynamic e) => Products.fromJson(e)).toList();

      //Status Code
      if (response.statusCode == 200){
        print("Get Products complete, StatusCode: " + response.statusCode.toString() + " data: " + _products.length.toString());
        final now = DateTime.now();
        lastUpdate = "${now.year}-${now.month}-${now.day}, ${now.hour}:${now.minute}".toString();
      }
    } 
    catch (ex) {
      print("Exception Error in Get " + ex.toString());
    }
  }
  
  
  // Create new Product
  Future postProduct(Map<String, dynamic> p) async {
    try{

      // Http Pettions
      http.Response response = await http.post("$_url/$_route", body: jsonEncode(p), headers: {
        'Content-Type': 'application/json-patch+json',
        'accept': 'application/json'
      });

      //Status Codes
      if(response.statusCode == 200){
        print("Product posted, StatusCode: " + response.statusCode.toString());

        // Update changes
        getProducts();
      } else print("ERROR TO POST " + response.statusCode.toString() );
    }
    catch(ex){
      print("Exception Error in Post " + ex.toString());
    }
  }

  // Delete Product
  Future deleteProduct(String name) async {
    try{
      Map<String, String> header = {
        'Content-Type': 'application/json-patch+json',
        'accept': 'application/json'
      };
      http.Response response = await http.delete("$_url/$_route/$name", headers: header);
      if(response.statusCode == 200){
        print("Product deleted, StatusCode: " + response.statusCode.toString());

        // Update changes
        getProducts();
      } else print("ERROR TO DELETE");
    }
    catch(ex){
      print("Exception Error in Delete " + ex.toString());
    }
  }

  // Edit Existen product
  Future putProduct(Map<String, dynamic> p, int id) async {
    try{
      http.Response response = await http.put("$_url/$_route/$id", body: jsonEncode(p), headers: { "Content-Type" : "application/json"});
      if(response.statusCode == 200){
        print("Product edited, StatusCode: " + response.statusCode.toString());

        // Update changes
        getProducts();
      } else print("ERROR TO EDIT PRODUCT " + id.toString() + " " + response.statusCode.toString());
    }
    catch(ex){
      print("Exception Error in Put " + ex.toString());
    }
  }
}