import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:quickdrop_delivery/src/core/constants/constants.dart';

class OrderTuleButton extends StatelessWidget {
  const OrderTuleButton({
    required String text,
    Color? color,
    Color? surfaceColor,
    Color? textColor,
    VoidCallback? onTap,
    super.key,
  })  : _text = text,
        _color = color,
        _surfaceColor = surfaceColor,
        _textColor = textColor,
        _onTap = onTap;

  final String _text;
  final Color? _color;
  final Color? _surfaceColor;
  final Color? _textColor;
  final VoidCallback? _onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        elevation: 5,
        shadowColor: Colors.transparent,
        borderRadius: Constants.mainBorderRadius / 2,
        surfaceTintColor: _surfaceColor,
        type: MaterialType.card,
        color: _color,
        child: InkWell(
          onTap: _onTap,
          borderRadius: Constants.mainBorderRadius / 2,
          child: Center(
            child: Text(
              _text.capitalize(),
              style: TextStyle(
                color: _textColor,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
