import 'package:flutter/material.dart';
import 'package:productsfrontend/Models/Products.dart';
import 'package:productsfrontend/Utils/http_connection.dart';
import 'package:productsfrontend/src/pages/edit_product_page.dart';
import 'package:productsfrontend/src/widgets/custom_header.dart';
import 'package:productsfrontend/src/widgets/custom_productscontainer.dart';
import 'package:provider/provider.dart';

class ProductsListPage extends StatefulWidget {
  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  TextEditingController controller = new TextEditingController();
  
  void updateData(){
    print("Data Updated");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _httpOperations = Provider.of<HttpOperations>(context);
    _httpOperations.updateChanges = updateData;

    final widthSize = MediaQuery.of(context).size.width;
    final heightSize = MediaQuery.of(context).size.height;


    void _editProduct(Products product){
      controller.clear();
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => EditProductPage(product: product, titlePage: "Editar Producto")));
    }

    void _createProduct(){
      controller.clear();
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => EditProductPage(product: null, titlePage: "Crear Producto")));
    }

    void _searchProduct(String name) => setState( () => _httpOperations.searchProduct(name)); 

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () => _createProduct(), foregroundColor: Colors.black,),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
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
                  title: "Lista de Productos",
                  widhtSize: widthSize,
                ),
                SizedBox(height: heightSize * 0.025,),
                TextField(
                  decoration: InputDecoration(labelText: "Producto", hintText: "Producto a buscar..."),
                  onChanged: (value) => _searchProduct(value),
                  controller: controller,
                ),
                FutureBuilder<List<Products>>(
                  future: _httpOperations.getProducts(),
                  builder: (_, AsyncSnapshot<List<Products>> data){
                    switch(data.connectionState){
                      case ConnectionState.none:
                        print("Connection Error");
                        break;
                      case ConnectionState.waiting:
                        return CircularProgressIndicator();
                        break;
                      case ConnectionState.active:
                        break;
                      case ConnectionState.done:
                        if(data.hasData){
                          if(data.data.isEmpty) return Column(
                            children: [
                              Icon(Icons.error_outline_outlined, color: Colors.red[200], size: 50,),
                              Text("NO HAY DATOS EN LA BD.", style: new TextStyle(fontSize: 25, fontWeight: FontWeight.w900), textAlign: TextAlign.center,)
                            ],
                          );
                          else return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: data.data.length,
                            itemBuilder: (context, index) => CustomProductsContainer(product: data.data[index], onSelect: _editProduct,),
                          );
                        }
                        else if(data.data == null) return Column(
                          children: [
                            Icon(Icons.error_outline_outlined, color: Colors.red[200], size: 50,),
                            Text("ERROR AL CONECTARSE.", style: new TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
                          ],
                        );
                        break;
                    }
                    return Column(
                      children: [
                        Icon(Icons.error_outline_outlined, color: Colors.red[200], size: 50,),
                        Text("ERROR, NO HAY DATOS.", style: new TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
                      ],
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
