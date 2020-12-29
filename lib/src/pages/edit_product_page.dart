import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productsfrontend/Models/Products.dart';
import 'package:productsfrontend/Utils/http_connection.dart';
import 'package:productsfrontend/src/widgets/custom_button.dart';
import 'package:productsfrontend/src/widgets/custom_header.dart';
import 'package:productsfrontend/src/widgets/custom_productscontainer.dart';
import 'package:provider/provider.dart';


class EditProductPage extends StatefulWidget {
  @override
  _EditProductPageState createState() => _EditProductPageState();
  Products product;
  String titlePage;
  bool _productExist;
  EditProductPage({this.product, this.titlePage}){
    if(this.product == null){
      _productExist = false;
      this.product = new Products(code: "", name: "", category: "", description: "", quantity: 0, pieces: 0, price: 0);
    } else _productExist = true;
  }
}

class _EditProductPageState extends State<EditProductPage> {

  @override
  Widget build(BuildContext context) {
    final _httpOperations = Provider.of<HttpOperations>(context);

    void deleteProduct(Products product) =>
      _httpOperations.deleteProduct(product.name);

    void editComplete(Products product) =>
      _httpOperations.putProduct(product.toJson(), product.id);

    void createComplete(Products product) =>
      _httpOperations.postProduct(product.toJson());

    final widthSize = MediaQuery.of(context).size.width;
    final heightSize = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(
              top: heightSize * 0.1,
              left: widthSize * 0.1,
              right: widthSize * 0.1,
              bottom: heightSize * 0.1),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomHeader(
                  title: "${widget.titlePage}",
                  widhtSize: widthSize,
                ),
                SizedBox(height: heightSize * 0.05),
                CustomProductsContainer(product: widget.product, onSelect: null),
                SizedBox(height: heightSize * 0.05),
                TextField(
                  decoration: InputDecoration(labelText: "Nombre", hintText: "Ingresa el nombre..."),
                  onChanged: (value) => setState((() => widget.product.name = value)),
                ),
                SizedBox(height: heightSize * 0.025),
                TextField(
                  decoration: InputDecoration(labelText: "Código", hintText: "Ingresa el código..."),
                  onChanged: (value) => setState((() => widget.product.code = value)),
                ),
                SizedBox(height: heightSize * 0.025),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Precio", hintText: "Ingresa el Precio..."),
                  onChanged: (value) => setState((() => widget.product.price = double.tryParse(value))),
                ),
                SizedBox(height: heightSize * 0.025),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Piezas", hintText: "Ingresa las Piezas..."),
                  onChanged: (value) => setState((() => widget.product.pieces = int.tryParse(value))),
                ),
                SizedBox(height: heightSize * 0.025),
                TextField(
                  decoration: InputDecoration(labelText: "Categoria", hintText: "Ingresa la categoria..."),
                  onChanged: (value) => setState((() => widget.product.category = value)),
                ),
                SizedBox(height: heightSize * 0.025),
                TextField(
                  decoration: InputDecoration(labelText: "Descripción", hintText: "Ingresa la descripción..."),
                  onChanged: (value) => setState((() => widget.product.description = value)),
                ),
                CustomButton(
                  color: Colors.green[100],
                  function: (){
                    widget._productExist ? editComplete(widget.product) : createComplete(widget.product);
                    Navigator.pop(context);
                  },
                  text: "Aceptar",
                  icon: Icons.check_box,
                  heightSize: heightSize,
                  widhtSize: widthSize,
                ),
                // Cancel or Delete Product
                CustomButton(
                  color: Colors.red[100],
                  function: (){
                    if(widget._productExist) deleteProduct(widget.product);
                    Navigator.pop(context);
                  },
                  text: widget._productExist ? "Eliminar Producto" : "Cancelar",
                  icon: Icons.check_box,
                  heightSize: heightSize,
                  widhtSize: widthSize,
                ),
              ],
            )
          )
        ),
      ),
    );
  }
}