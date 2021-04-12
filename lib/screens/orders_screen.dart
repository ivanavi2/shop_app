import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';
import '../providers/orders.dart' show OrdersProvider;

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

/*   var _isLoading = false;
  @override
  void initState() {
/*     _isLoading = true;

    Provider.of<OrdersProvider>(context, listen: false).fetchOrders().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState(); */
  }
 */
  @override
  Widget build(BuildContext context) {
    //final orderData = Provider.of<OrdersProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future:
            Provider.of<OrdersProvider>(context, listen: false).fetchOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (dataSnapshot.error != null) {
            //handle error
            return Center(
              child: Text('Something went wrong!'),
            );
          }
          return Consumer<OrdersProvider>(
            builder: (context, orderData, child) {
              return ListView.builder(
                itemCount: orderData.orders.length,
                itemBuilder: (ctx, index) => OrderItem(
                  orderData.orders[index],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
