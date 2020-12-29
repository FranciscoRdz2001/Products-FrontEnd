import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:productsfrontend/Models/Products.dart';
import 'package:http/http.dart' as http;

class HttpOperations with ChangeNotifier{


  List<Products> _products = new List<Products>();
  List<Products> _productsToShow = new List<Products>();
  static const String _url = "http://a22dd138ffcc.ngrok.io";
  static const String _route = "Products";
  bool _searchMode = false;
  Function() updateChanges;

  HttpOperations({@required this.updateChanges});

  List<Products> get products => _products;
  set products (List<Products> value){
    _products = value;
  }

  List<Products> get productsToShow => _productsToShow;
  set productsToShow (List<Products> value)=> _productsToShow = value;

  // Search product in list
  searchProduct(String name){
    _searchMode = name == "" || name == null ? false : true;
    productsToShow = _products.where((Products p) => p.name.toLowerCase().contains(name.toLowerCase())).toList();
    print("Encontrados ${productsToShow.length} de ${products.length} ");
  }

  // Obtain list of products in BD
  Future<List<Products>> getProducts() async{
    try {
      if(!_searchMode){
        http.Response response = await http.get("$_url/$_route");
        productsToShow = products = (json.decode(response.body) as List).map((dynamic e) => Products.fromJson(e)).toList();
        if (response.statusCode == 200) 
          print("Get Products complete, StatusCode: " + response.statusCode.toString() + " data: " + products.length.toString());
      }
      return productsToShow;
    } catch (ex) {
      print("Exception Error in Get");
      return null;
    }
  }
  
  
  // Create new Product
  Future postProduct(Map<String, dynamic> p) async {
    try{
      Map<String, String> header = {
        'Content-Type': 'application/json-patch+json',
        'accept': 'application/json'
      };
      http.Response response = await http.post("$_url/$_route", body: jsonEncode(p), headers: header);
      if(response.statusCode == 200){
        print("Product posted, StatusCode: " + response.statusCode.toString());
        await getProducts;
        _searchMode = false;
        updateChanges();
      } else print("ERROR TO POST " + response.statusCode.toString() );
    }
    catch(Ex){
      print("Exception Error in Post");
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
        await getProducts;
        _searchMode = false;
        updateChanges();
      } else print("ERROR TO DELETE");
    }
    catch(Ex){
      print("Exception Error in Delete");
    }
  }

  // Edit Existen product
  Future putProduct(Map<String, dynamic> p, int id) async {
    try{
      http.Response response = await http.put("$_url/$_route/$id", body: jsonEncode(p), headers: { "Content-Type" : "application/json"});
      if(response.statusCode == 200){
        print("Product edited, StatusCode: " + response.statusCode.toString());
        await getProducts;
        _searchMode = false;
        updateChanges();
      } else print("ERROR TO EDIT PRODUCT " + id.toString() + " " + response.statusCode.toString());
    }
    catch(Ex){
      print("Exception Error in Put");
    }
  }

}