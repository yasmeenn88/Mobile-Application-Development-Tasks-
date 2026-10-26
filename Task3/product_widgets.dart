// ============================================================
//  HELPER FILE: Product widgets
// ============================================================
//  Each product is a Map like:
//  {"name": "Laptop", "price": 1200, "image": "assets/images/laptop.png"}

import 'package:flutter/material.dart';

class ProductsListView extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final void Function() onFavoritePressed;
  final void Function(int index) onProductTap;

  ProductsListView({
    required this.products,
    required this.onFavoritePressed,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductTile(
          name: products[index]["name"],
          price: products[index]["price"],
          image: products[index]["image"],
          onFavoritePressed: onFavoritePressed,
          onTap: () {
            onProductTap(index);
          },
        );
      },
    );
  }
}

class ProductsGridView extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final void Function() onFavoritePressed;
  final void Function(int index) onProductTap;

  ProductsGridView({
    required this.products,
    required this.onFavoritePressed,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      itemCount: products.length,
      // at width 600 or more this gives 3+ columns (always at least 2)
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 260,
        childAspectRatio: 0.85,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        return ProductCard(
          name: products[index]["name"],
          price: products[index]["price"],
          image: products[index]["image"],
          onFavoritePressed: onFavoritePressed,
          onTap: () {
            onProductTap(index);
          },
        );
      },
    );
  }
}

// ---------- Row style (used in the list) ----------
class ProductTile extends StatelessWidget {
  final String name;
  final int price;
  final String? image;
  final void Function() onFavoritePressed;
  final void Function() onTap;

  ProductTile({
    required this.name,
    required this.price,
    this.image,
    required this.onFavoritePressed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ProductImage(path: image, size: 84),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text("\$$price",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: cs.primary)),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.favorite),
                color: Colors.red,
                onPressed: onFavoritePressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------- Card style (used in the grid) ----------
class ProductCard extends StatelessWidget {
  final String name;
  final int price;
  final String? image;
  final void Function() onFavoritePressed;
  final void Function() onTap;

  ProductCard({
    required this.name,
    required this.price,
    this.image,
    required this.onFavoritePressed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: ProductImage(path: image)),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text("\$$price",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: cs.primary)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite),
                    color: Colors.red,
                    onPressed: onFavoritePressed,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- Image with a clear fallback + console message ----------
class ProductImage extends StatelessWidget {
  final String? path;
  final double? size;

  const ProductImage({super.key, this.path, this.size});

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      width: size,
      height: size,
      color: Colors.indigo.shade50,
      child: Icon(Icons.image_not_supported_outlined,
          size: (size ?? 80) * 0.4, color: Colors.indigo.shade200),
    );

    if (path == null) return placeholder;

    return Image.asset(
      path!,
      width: size,
      height: size,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        print("IMAGE NOT FOUND: $path  ->  $error");
        return placeholder;
      },
    );
  }
}