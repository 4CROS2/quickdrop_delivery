import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:quickdrop_delivery/src/core/constants/constants.dart';
import 'package:quickdrop_delivery/src/features/order_detail/widget/header_button.dart';
import 'package:quickdrop_delivery/src/features/order_detail/widget/order_detail_map.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({required String orderId, super.key});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: CustomScrollView(
        physics: Constants.bouncingScrollPhysics,
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: size.height * .8,
            collapsedHeight: 80,
            elevation: 0,
            pinned: true,
            stretch: true,
            leading: InkWell(
              onTap: () {
                context.pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            actions: <Widget>[
              HeaderButton(
                icon: Icons.qr_code_scanner_rounded,
              )
            ],
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const <StretchMode>[
                StretchMode.blurBackground,
                StretchMode.zoomBackground,
              ],
              background: const OrderDetailMap(),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Container(
                    height: Constants.paddingValue,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(50),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: -5,
                    height: 5,
                    child: Material(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: SizedBox.expand(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: Constants.mainPadding.copyWith(
              top: 10,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  Material(
                    type: MaterialType.card,
                    borderRadius: Constants.mainBorderRadius,
                    child: Padding(
                      padding: Constants.mainPadding,
                      child: Column(
                        spacing: Constants.paddingValue / 2,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            'Información del Domicilio',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),

                          const Text('Dirección: Calle Falsa 123'),
                          const Text('Cliente: Juan Pérez'),
                          Text('Detalles: Entregar en la puerta principal'),
                          // Agrega más widgets según necesites
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList.builder(
            itemBuilder: (BuildContext context, int index) =>
                Text('a la verga'),
            itemCount: 100,
          )
        ],
      ),
    );
  }
}
