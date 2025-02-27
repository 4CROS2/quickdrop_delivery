import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:quickdrop_delivery/src/core/constants/constants.dart';

class OrderInformation extends StatelessWidget {
  const OrderInformation({
    required String data,
    IconData? iconData,
    double size = 20,
    Color? textColor,
    super.key,
  })  : _data = data,
        _iconData = iconData,
        _size = size,
        _textColor = textColor;

  final String _data;
  final IconData? _iconData;
  final double _size;
  final Color? _textColor;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: <InlineSpan>[
          if (_iconData != null)
            WidgetSpan(
              child: Icon(
                _iconData,
                color: Constants.primaryColor,
                size: _size,
              ),
            ),
          TextSpan(
            text: _data.capitalize(),
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: _size,
              color: _textColor,
            ),
          ),
        ],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
