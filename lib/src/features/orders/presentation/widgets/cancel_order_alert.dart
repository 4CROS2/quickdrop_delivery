import 'package:flutter/material.dart';

class CancelOlderAlert extends StatelessWidget {
  const CancelOlderAlert({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text('Rechazar pedido'),
      content: Text(
        '¿Estás seguro de que deseas rechazar este pedido?',
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            // Lógica para rechazar el pedido
            Navigator.of(context).pop();
          },
          child: Text('Rechazar'),
        ),
      ],
    );
  }
}
