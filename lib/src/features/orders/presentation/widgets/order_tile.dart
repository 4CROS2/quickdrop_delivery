import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickdrop_delivery/src/core/constants/constants.dart';
import 'package:quickdrop_delivery/src/features/orders/domain/entity/order_entity.dart';
import 'package:shimmer/shimmer.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({
    required OrderEntity order,
    super.key,
  }) : _order = order;

  final OrderEntity _order;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: Constants.mainBorderRadius,
      clipBehavior: Clip.hardEdge,
      type: MaterialType.card,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: Constants.mainPadding / 2,
          child: Row(
            children: <Widget>[
              Flexible(
                child: Row(
                  children: <Widget>[
                    Material(
                      surfaceTintColor: Constants.primaryColor,
                      elevation: 2,
                      shadowColor: Colors.transparent,
                      borderRadius: Constants.mainBorderRadius / 2,
                      child: SizedBox(
                        width: 70,
                        height: 70,
                        child: ClipRRect(
                          borderRadius: Constants.mainBorderRadius / 2,
                          child: CachedNetworkImage(
                            imageUrl: _order.image,
                            fit: BoxFit.cover,
                            errorWidget: (
                              BuildContext context,
                              String url,
                              Object error,
                            ) {
                              return Center(
                                child: Icon(Icons.error_rounded),
                              );
                            },
                            progressIndicatorBuilder: (
                              BuildContext context,
                              String url,
                              DownloadProgress progress,
                            ) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.white12,
                                child: SizedBox(
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: Constants.mainPadding / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          spacing: Constants.mainPadding.top / 2,
                          children: <Widget>[
                            Text(
                              _order.productName,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            //TODO:otros datos
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                DateFormat('HH:mm').format(_order.createdAt),
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
