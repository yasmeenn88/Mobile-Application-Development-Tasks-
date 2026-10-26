// ===================== Answers (Part 1, Q5) =====================
// a) Which methods run when a page opens for the first time?
//    initState -> didChangeDependencies -> build
//
// b) Which method runs again after I press the heart button?
//    Only build, because setState marks the widget as dirty and
//    Flutter rebuilds it.
//
// c) Which methods run when I leave a page and go back?
//    - Products -> Details (push): Details runs initState ->
//      didChangeDependencies -> build. Products is NOT disposed (it stays
//      in the navigator stack, so no deactivate/dispose), but it runs
//      didChangeDependencies -> build once, because it reads
//      ModalRoute.of(context) and the route is no longer the current one.
//    - Details -> Products (pop): Products runs didChangeDependencies ->
//      build again (it is the current route again, and the rebuild also
//      shows the cart message from setState). Then Details runs
//      deactivate -> dispose when the transition ends.
//    - Login stays in the stack under Products, so it prints nothing.
//
// d) Which methods run when I resize the browser window, and why?
//    didChangeDependencies -> build. The page reads
//    MediaQuery.sizeOf(context), so it depends on MediaQuery. When the
//    window size changes, that dependency changes, so Flutter calls
//    didChangeDependencies and then rebuilds the page.
// =================================================================

import 'package:flutter/material.dart';
import 'package:task3/pages/login_page.dart';
import 'package:task3/pages/products_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Product Catalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/products': (context) => const ProductsPage(),
      },
    );
  }
}