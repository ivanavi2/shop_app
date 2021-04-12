import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/products_provider.dart';
import '../widgets/product_grid.dart';
import '../widgets/badge.dart';
import '../widgets/app_drawer.dart';
import '../screens/cart_screen.dart';

enum FilterOptions {
  Favourites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _isShowOnlyFavourites = false;
  var _isLoading = false;
  var _isInit = true;

  @override
  void initState() {
    // TODO: implement initState
    //o(context) methods dont work(usually) in initState()
    //provider can be used here if listen:false is set
    //do not use async in initState()
/*     setState(() {
      _isLoading = true;
    }); */
/*     Provider.of<ProductsProvider>(context, listen: false)
        .fetchProducts()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
 */
//OR
/*     Future.delayed(Duration.zero).then((_) {
      Provider.of<ProductsProvider>(context).fetchProducts();
    }); */

//OR do it in didChangeDependencies()
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies\ if (_isInit) {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context).fetchProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("rebuilding productoverviewscreen");
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favourites) {
                  _isShowOnlyFavourites = true;
                } else {
                  _isShowOnlyFavourites = false;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favourites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
            icon: Icon(
              Icons.more_vert,
            ),
          ),
          Consumer<CartProvider>(
            builder: (context, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ProductGrid(_isShowOnlyFavourites),
    );
  }
}
