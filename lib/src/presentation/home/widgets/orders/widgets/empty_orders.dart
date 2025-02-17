import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quickdrop_delivery/src/core/constants/constants.dart';

class EmptyOrders extends StatefulWidget {
  const EmptyOrders({super.key});

  @override
  State<EmptyOrders> createState() => _EmptyOrdersState();
}

class _EmptyOrdersState extends State<EmptyOrders> {
  final List<String> emptyMessages = <String>[
    '🚀 No hay pedidos pendientes en este momento. ¡Mantente atento, más pedidos están en camino!',
    '🎉 No hay pedidos pendientes en este momento. ¡Disfruta de un pequeño descanso mientras llegan nuevos pedidos!',
    '🙌 Gracias por tu excelente trabajo.Actualmente no hay pedidos pendientes. Estaremos notificándote cuando lleguen nuevos pedidos.',
    '🕒 No hay pedidos pendientes por ahora. Aprovecha este tiempo para revisar tu equipo y estar listo para la siguiente entrega.',
  ];

  late String _messageSelected;

  @override
  void initState() {
    super.initState();
    _messageSelected =
        emptyMessages[Random.secure().nextInt(emptyMessages.length)];
  }

  @override
  Widget build(BuildContext context) {
    // Divide el mensaje en dos partes: antes y después del punto.
    final List<String> parts = _messageSelected.split('. ');

    return Center(
      child: Padding(
        padding: Constants.mainPadding * 2,
        child: Material(
          borderRadius: Constants.mainBorderRadius,
          child: Padding(
            padding: Constants.mainPadding / 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${parts[0]}. ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  parts.length > 1 ? parts[1] : '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
