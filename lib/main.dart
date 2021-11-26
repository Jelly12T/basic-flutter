import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/order.dart';
import 'package:store_app/screens/cart_screen.dart';
import 'package:store_app/screens/product_overview_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/product_detail_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './screens/oders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Color primaryColor = Color(0xFF193498);
  final Color buttomColor = Color(0xFF113CFC);
  final Color backGroundColor = Color(0xFF69DADB);
  final Color accenColor = Color(0xFF69DADB);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'My shop',
        theme: ThemeData(
          primaryColor: primaryColor,
          accentColor: accenColor,
          buttonColor: buttomColor,
          backgroundColor: backGroundColor,
          appBarTheme: AppBarTheme(
            color: primaryColor,
          ),
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: GoogleFonts.quicksand(
                  textStyle: textTheme.bodyText1,
                  color: Colors.white,
                  fontSize: 17,
                  //  fontWeight: FontWeight.bold,
                ),
                bodyText2: GoogleFonts.lato(
                  textStyle: textTheme.bodyText2,
                  color: Colors.black,
                  //fontWeight: FontWeight.bold,
                ),
                subtitle1: GoogleFonts.oswald(
                  textStyle: textTheme.subtitle1,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
                subtitle2: GoogleFonts.oswald(
                  textStyle: textTheme.subtitle2,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
        ),
        home: ProductOverViewScreen(),
        routes: {
          ProductDeatailScreen.routeName: (ctx) => ProductDeatailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OdersScreen.routeName: (ctx) => OdersScreen(),
          UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
          EditProductScreen.routName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
