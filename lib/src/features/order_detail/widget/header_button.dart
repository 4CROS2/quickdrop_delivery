import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quickdrop_delivery/src/core/constants/constants.dart';

class HeaderButton extends StatelessWidget {
  const HeaderButton({
    required IconData icon,
    Color? colorIcon = Colors.black,
    this.padding,
    super.key,
    VoidCallback? onTap,
  })  : _icon = icon,
        _colorIcon = colorIcon,
        _onTap = onTap;

  final IconData _icon;
  final Color? _colorIcon;
  final VoidCallback? _onTap;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50, // Tamaño fijo para el botón
      height: 50,
      child: ClipRRect(
        borderRadius: Constants.mainBorderRadius / 2,
        child: Material(
          color: Colors.black45,
          child: InkWell(
            onTap: _onTap,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 30,
                sigmaY: 30,
              ),
              child: padding != null
                  ? Padding(
                      padding: padding!,
                      child: Icon(
                        _icon,
                        color: _colorIcon,
                      ),
                    )
                  : Icon(
                      _icon,
                      color: _colorIcon,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
