import 'package:flutter/material.dart';

class Products {
  int id;
  String code;
  String name;
  String category;
  String description;
  int quantity;
  int pieces;
  double price;
  Products({
    this.id,
    @required this.code,
    @required this.name,
    @required this.category,
    @required this.description,
    @required this.quantity,
    @required this.pieces,
    @required this.price,
  });

  factory Products.fromJson(Map<String, dynamic> productJson) => new Products(
      id: productJson["id"],
      code: productJson["code"],
      name: productJson["name"],
      category: productJson["category"],
      description: productJson["description"],
      quantity: productJson["quantity"].toInt(),
      pieces: productJson["pieces"].toInt(),
      price: productJson["price"].toDouble()
  );
  Map<String, dynamic> toJson() => {
      "code": this.code,
      "name": this.name,
      "category": this.category,
      "description": this.description,
      "quantity": this.quantity,
      "pieces": this.pieces,
      "price": this.price
  };
}