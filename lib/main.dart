import 'package:flutter/material.dart';
import 'package:productsfrontend/Utils/http_connection.dart';
import 'package:productsfrontend/src/pages/edit_product_page.dart';
import 'package:productsfrontend/src/styles/colors_style.dart';
import 'package:productsfrontend/src/styles/text_style.dart';
import 'package:provider/provider.dart';
import 'package:productsfrontend/src/pages/home_page.dart';
import 'package:productsfrontend/src/pages/products_list_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  final _colors = new CustomColors();
  final _textStyles = new TextStyles();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => HttpOperations(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'homepage',
        routes: {
          'homepage': (context) => HomePage(),
          'productslistpage': (context) => ProductsListPage(),
          'editproductpage': (context) => EditProductPage(),
        },
        theme: ThemeData(
          iconTheme: IconThemeData(color: _colors.accent2Color,),
          accentIconTheme: IconThemeData(color: _colors.accent2Color),
          primaryIconTheme: IconThemeData(color: _colors.accent2Color),
          primaryColor: _colors.accent2Color,
          accentColor: _colors.accent2Color,
          scaffoldBackgroundColor: _colors.bgColor,
          buttonColor: _colors.accent2Color,
          hintColor: _colors.accent2Color,
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: _textStyles.textFieldHint.copyWith(color: Colors.blue[100]),
            prefixStyle: _textStyles.textFieldHint,
            suffixStyle: _textStyles.textFieldHint,
            border: OutlineInputBorder(),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: _colors.accent2Color, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: _colors.accent2Color, width: 1.0),
            ),
            labelStyle: _textStyles.textFieldHint
          ),
        ),
      ),
    );
  }
}