import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/order.dart';
import 'package:store_app/providers/product.dart';
import 'package:store_app/screens/auth_screen.dart';
import 'package:store_app/screens/await_screen.dart';
import 'package:store_app/screens/cart_screen.dart';
import 'package:store_app/screens/product_overview_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/product_detail_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './screens/oders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';
import 'providers/auth.dart';

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
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (context) => Products(
              Provider.of<Auth>(context, listen: false).token!,
              Provider.of<Auth>(context, listen: false).userId),
          update: (context, value, previous) =>
              Products(value.token ?? '', value.userId),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (context) =>
              Orders(Provider.of<Auth>(context, listen: false).token!),
          update: (context, value, previous) => Orders(value.token!),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
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
                    color: Colors.black,
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
          home: auth.isAuth
              ? ProductOverViewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, value) =>
                      value.connectionState == ConnectionState.waiting
                          ? AwaitScreen()
                          : AuthScreen(),
                ),
          routes: {
            ProductDeatailScreen.routeName: (ctx) => ProductDeatailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OdersScreen.routeName: (ctx) => OdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
