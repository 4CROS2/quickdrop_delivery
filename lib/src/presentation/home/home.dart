import 'package:flutter/material.dart';
import 'package:quickdrop_delivery/src/domain/entity/order_entity.dart';
import 'package:quickdrop_delivery/src/presentation/home/widgets/active_switch/active_switch.dart';
import 'package:quickdrop_delivery/src/presentation/home/widgets/orders/orders.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String image =
      'https://www.saborusa.com/ni/wp-content/uploads/sites/19/2019/11/Calma-tus-antojos-con-deliciosas-y-rapidas-recetas-Foto-destacada.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        elevation: 2,
        actions: <Widget>[
          ActiveSwitch(),
        ],
      ),
      body: Orders(
        orders: <OrderEntity>[
          /* OrderEntity(
            image: 'laptop.png',
            productName: 'Laptop',
            address: 'Calle Principal 123',
            createdAt: DateTime.now(),

          ), */
         /*  OrderEntity(
            image: 'smartphone.png',
            productName: 'Smartphone',
            address: 'Avenida Secundaria 456',
            createdAt: DateTime.now().subtract(
              const Duration(
                days: 1,
              ),
            ),
          ),
          OrderEntity(
            image: 'tablet.png',
            productName: 'Tablet',
            address: 'Calle Terciaria 789',
            createdAt: DateTime.now().subtract(
              const Duration(
                days: 2,
              ),
            ),
          ) */
        ],
      ),
    );
  }
}
