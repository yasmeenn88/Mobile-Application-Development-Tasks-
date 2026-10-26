import 'package:flutter/material.dart';
import 'package:task3/pages/details_page.dart';
import 'package:task3/product_widgets.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  int favorites = 0;
  String username = "";
  String cartMessage = "";

  final List<Map<String, dynamic>> products = [
    {"name": "Laptop", "price": 1200, "image": "assets/images/laptop.jpg"},
    {"name": "Phone", "price": 800, "image": "assets/images/phone.jpg"},
    {"name": "Headphones", "price": 150, "image": "assets/images/headphones.jpg"},
    {"name": "Watch", "price": 250, "image": "assets/images/watch.jpg"},
    {"name": "Camera", "price": 600, "image": "assets/images/camera.jpg"},
    {"name": "Keyboard", "price": 90, "image": "assets/images/keyboard.jpg"},
  ];

  @override
  void initState() {
    super.initState();
    print("ProductsPage: initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final size = MediaQuery.sizeOf(context);
    print(
        "ProductsPage: didChangeDependencies -> width: ${size.width}, height: ${size.height}");
    // username sent from Login using pushNamed arguments (dynamic -> cast)
    username = ModalRoute.of(context)!.settings.arguments as String;
  }

  @override
  void deactivate() {
    print("ProductsPage: deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    print("ProductsPage: dispose");
    super.dispose();
  }

  Future<void> openDetails(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsPage(
          name: products[index]["name"],
          price: products[index]["price"],
          image: products[index]["image"],
        ),
      ),
    );
    if (result != null) {
      setState(() {
        cartMessage = result as String;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("ProductsPage: build");
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // ---------- Header ----------
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [Color(0xFF3F51B5), Color(0xFF7986CB)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome, $username",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(
                      backgroundColor: Colors.white,
                      avatar: const Icon(Icons.favorite,
                          color: Colors.red, size: 18),
                      label: Text("Favorites: $favorites"),
                    ),
                    Chip(
                      backgroundColor: Colors.white,
                      avatar: const Icon(Icons.aspect_ratio,
                          color: Colors.indigo, size: 18),
                      label:
                      Text("Screen width: ${width.toStringAsFixed(0)}"),
                    ),
                    if (cartMessage.isNotEmpty)
                      Chip(
                        backgroundColor: Colors.green.shade50,
                        avatar: const Icon(Icons.check_circle,
                            color: Colors.green, size: 18),
                        label: Text(cartMessage),
                      ),
                  ],
                ),
              ],
            ),
          ),
          // ---------- Products ----------
          Expanded(
            child: width < 600
                ? ProductsListView(
              products: products,
              onFavoritePressed: () => setState(() => favorites++),
              onProductTap: openDetails,
            )
                : ProductsGridView(
              products: products,
              onFavoritePressed: () => setState(() => favorites++),
              onProductTap: openDetails,
            ),
          ),
        ],
      ),
    );
  }
}