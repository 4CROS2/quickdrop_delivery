import 'package:flutter/material.dart';
import 'package:quickdrop_delivery/src/core/constants/constants.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.automaticallyImplyLeading = true,
  });

  final bool automaticallyImplyLeading;

  @override
  State<StatefulWidget> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size(double.infinity, 100);
}

class _CustomAppBarState extends State<CustomAppBar> {
  late double _statusBarHeight;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _statusBarHeight = MediaQuery.of(context).padding.top;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      shadowColor: Colors.transparent,
      surfaceTintColor: Constants.secondaryColor,
      child: SizedBox(
        width: widget.preferredSize.width,
        height: widget.preferredSize.height,
        child: Padding(
          padding: EdgeInsets.only(top: _statusBarHeight),
          child: Center(
            child: Text('adadad'),
          ),
        ),
      ),
    );
  }
}
