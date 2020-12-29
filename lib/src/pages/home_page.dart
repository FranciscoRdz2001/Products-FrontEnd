import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:productsfrontend/src/widgets/custom_button.dart';
import 'package:productsfrontend/src/widgets/custom_header.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    final heightSize = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(top: heightSize * 0.1, left: widthSize * 0.1, right: widthSize * 0.1, bottom: heightSize * 0.1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomHeader(
                title: "Productos",
                widhtSize: widthSize,
              ),
              SizedBox(height: heightSize * 0.05,),
              Expanded(
                child: Container(
                  width: widthSize,
                  height: heightSize * 0.55,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(25)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        heightSize: heightSize,
                        widhtSize: widthSize,
                        color: Colors.blue[200],
                        text: "Lista de Productos",
                        icon: Icons.list,
                        function: () => Navigator.pushNamed(context, "productslistpage"),
                      ),
                      CustomButton(
                        heightSize: heightSize,
                        widhtSize: widthSize,
                        color: Colors.purple[200],
                        text: "Buscar Producto",
                        icon: Icons.search,
                        function: null,
                      ),
                      CustomButton(
                        heightSize: heightSize,
                        widhtSize: widthSize,
                        color: Colors.green[200],
                        text: "Ajustes",
                        icon: Icons.settings,
                        function: null,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
