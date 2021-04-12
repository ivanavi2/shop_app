import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';

import '../providers/products_provider.dart';
import '../widgets/product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavouriteOnly;

  ProductGrid(this.showFavouriteOnly);
  @override
  Widget build(BuildContext context) {
    //Listen to changes in ProductsProvider class
    final productsData = Provider.of<ProductsProvider>(context);
    final products =
        showFavouriteOnly ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) {
        return ChangeNotifierProvider.value(
          //use .value when providing for a single item in a list / grid
          value: products[index],
          /* create: (ctx) => products[index], */
          child: ProductItem(),
        );
      },
      itemCount: products.length,
    );
  }
}
