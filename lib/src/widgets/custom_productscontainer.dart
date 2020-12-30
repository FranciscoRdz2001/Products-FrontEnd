import 'package:flutter/material.dart';
import 'package:productsfrontend/Models/Products.dart';
import 'package:productsfrontend/src/pages/edit_product_page.dart';
import 'package:productsfrontend/src/styles/text_style.dart';
import 'package:productsfrontend/src/styles/colors_style.dart';
import 'dart:math';

class CustomProductsContainer extends StatelessWidget {
  final _textStyle = new TextStyles();
  final _colors = new CustomColors();
  final random = new Random();
  bool canEdit;
  Products product;
  CustomProductsContainer({@required this.product, this.canEdit}){
    canEdit = canEdit == null ? false : canEdit;
  }
  
  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    final heightSize = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: GestureDetector(
        onTap: () => canEdit ? Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProductPage(product: product, titlePage: "Editar Producto"))) : null,
        child: Container(
          width: widthSize,
          height: heightSize * 0.25,
          decoration: BoxDecoration(
            color: Colors.grey[50], borderRadius: BorderRadius.circular(25),
            border: Border.all(width: 1, color: !canEdit ? Colors.grey[100] : _colors.productsContainers[random.nextInt(_colors.productsContainers.length - 1)])
          ),
          child: Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("${product.name}", style: _textStyle.productBoxTitle,),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Código: ",
                      style: _textStyle.productBoxProp,
                      children: <TextSpan>[
                        TextSpan(text: "${product.code}", style: _textStyle.productBoxValue)
                      ]
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Precio: ",
                      style: _textStyle.productBoxProp,
                      children: <TextSpan>[
                        TextSpan(text: "${product.price}", style: _textStyle.productBoxValue)
                      ]
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Piezas: ",
                      style: _textStyle.productBoxProp,
                      children: <TextSpan>[
                        TextSpan(text: "${product.pieces}", style: _textStyle.productBoxValue)
                      ]
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Cantidad: ",
                      style: _textStyle.productBoxProp,
                      children: <TextSpan>[
                        TextSpan(text: "${product.quantity}", style: _textStyle.productBoxValue)
                      ]
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Categoria: ",
                      style: _textStyle.productBoxProp,
                      children: <TextSpan>[
                        TextSpan(text: "${product.category}", style: _textStyle.productBoxValue)
                      ]
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Descripción: ",
                      style: _textStyle.productBoxProp,
                      children: <TextSpan>[
                        TextSpan(text: "\n${product.description}", style: _textStyle.productBoxValue)
                      ]
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}