import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quickdrop_delivery/src/core/constants/constants.dart';
import 'package:quickdrop_delivery/src/core/extensions/string_extensions.dart';

class OtherLoginBtn extends StatelessWidget {
  const OtherLoginBtn({
    required String svgImage,
    required String label,
    VoidCallback? onTap,
    super.key,
  })  : _image = svgImage,
        _label = label,
        _onTap = onTap;
  final String _image;
  final String _label;
  final VoidCallback? _onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.12),
            blurRadius: 12.1,
            offset: const Offset(5, 5),
          )
        ],
      ),
      child: Material(
        borderRadius: Constants.mainBorderRadius,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: _onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  _image,
                  height: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  _label.capitalize(),
                  style: const TextStyle(
                    fontFamily: 'Redhat',
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
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
