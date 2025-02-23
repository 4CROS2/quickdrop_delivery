import 'package:apptoastification/apptoastification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_delivery/src/core/constants/constants.dart';
import 'package:quickdrop_delivery/src/features/active_switch/presentation/cubit/active_switch_cubit.dart';
import 'package:quickdrop_delivery/src/features/location/cubit/location_cubit.dart';
import 'package:quickdrop_delivery/src/injection/injection_container.dart';

class ActiveSwitch extends StatefulWidget {
  const ActiveSwitch({super.key});

  @override
  State<ActiveSwitch> createState() => _ActiveSwitchState();
}

class _ActiveSwitchState extends State<ActiveSwitch>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Constants.animationTransition,
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActiveSwitchCubit, ActiveSwitchState>(
      listener: (BuildContext context, ActiveSwitchState state) async {
        if (state.activeState == ActiveState.error) {
          AppToastification.showError(
            context: context,
            message: state.message,
          );
        }

        if (state.isActive) {
          await sl<LocationCubit>().getLocation();
        } else {
          sl<LocationCubit>().stopLocationStream();
        }
      },
      builder: (BuildContext context, ActiveSwitchState state) {
        return Row(
          children: <Widget>[
            AnimatedBuilder(
              animation: _animation,
              builder: (BuildContext context, Widget? child) {
                return FadeTransition(
                  opacity: _animation,
                  child: child,
                );
              },
              child: Text('Disponible'),
            ),
            Switch(
              value: state.isActive,
              padding: const EdgeInsets.only(right: 20.0),
              onChanged: (bool? value) =>
                  sl<ActiveSwitchCubit>().changeStatus(),
            ),
          ],
        );
      },
    );
  }
}
