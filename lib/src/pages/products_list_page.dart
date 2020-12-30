import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:productsfrontend/Utils/http_connection.dart';
import 'package:productsfrontend/src/pages/edit_product_page.dart';
import 'package:productsfrontend/src/widgets/custom_button.dart';
import 'package:productsfrontend/src/widgets/custom_header.dart';
import 'package:productsfrontend/src/widgets/custom_productscontainer.dart';
import 'package:provider/provider.dart';

class ProductsListPage extends StatefulWidget {
  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  TextEditingController controller = new TextEditingController();
  @override
  void initState() => SchedulerBinding.instance.addPostFrameCallback((_) => Provider.of<HttpOperations>(context).getProducts());
  @override
  Widget build(BuildContext context) {
    final _httpOperations = Provider.of<HttpOperations>(context);

    final widthSize = MediaQuery.of(context).size.width;
    final heightSize = MediaQuery.of(context).size.height;

    void _createProduct(){
      controller.clear();
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => EditProductPage(product: null, titlePage: "Crear Producto")));
    }

    Widget dataToShow() {
      return _httpOperations.productsToShow == null ? Column(
        children: [
          Icon(Icons.wifi, color: Colors.red[200], size: 50,),
          Text("ERROR AL CONECTARSE.", style: new TextStyle(fontSize: 25, fontWeight: FontWeight.w900), textAlign: TextAlign.center,)
        ],
      )
      : _httpOperations.productsToShow.length == 0 ? Column(
        children: [
          Icon(Icons.error_outline_outlined, color: Colors.red[200], size: 50,),
          Text("NO HAY DATOS EN LA BD.", style: new TextStyle(fontSize: 25, fontWeight: FontWeight.w900), textAlign: TextAlign.center,)
        ],
      )
      : ListView.builder(
          shrinkWrap: true,
          itemCount: _httpOperations.productsToShow.length,
          itemBuilder: (context, index) => CustomProductsContainer(
            product: _httpOperations.productsToShow[index],
            canEdit: true,
          ),
        );
    }

    return Scaffold(
      floatingActionButton: CustomButton(
        function: _createProduct,
        heightSize: heightSize,
        widhtSize: widthSize,
        text: "Agregar",
        icon: Icons.add,
        color: Colors.green,
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.only(
            top: heightSize * 0.1,
            left: widthSize * 0.1,
            right: widthSize * 0.1,
            bottom: heightSize * 0.1
          ),
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
                  autofocus: false,
                  decoration: InputDecoration(labelText: "Producto", hintText: "Producto a buscar..."),
                  onChanged: (value) => setState( () => _httpOperations.searchProduct(value)),
                  controller: controller,
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
                ),
                CustomButton(
                  heightSize: heightSize,
                  widhtSize: widthSize,
                  text: "Actualizar",
                  icon: Icons.update,
                  color: Colors.blue,
                  function: () async{
                    FocusScope.of(context).unfocus();
                    controller.clear();
                    await _httpOperations.getProducts();
                  }
                ),
                SizedBox(height: heightSize * 0.005,),
                Text("Ultima actualización:", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w900)),
                Text("${_httpOperations.lastUpdate}", textAlign: TextAlign.center,),
                dataToShow(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
