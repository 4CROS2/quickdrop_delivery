import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:quickdrop_delivery/src/features/location/cubit/location_cubit.dart';
import 'package:quickdrop_delivery/src/injection/injection_container.dart';

class OrderDetailMap extends StatefulWidget {
  const OrderDetailMap({super.key});

  @override
  State<OrderDetailMap> createState() => _OrderDetailMapState();
}

class _OrderDetailMapState extends State<OrderDetailMap>
    with SingleTickerProviderStateMixin {
  late final MapController _mapController;
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    );
    _animation = Tween<double>(
      begin: 20, // Sin desenfoque al inicio
      end: 0, // Desenfoque notable al final
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      bloc: sl<LocationCubit>(),
      builder: (BuildContext context, LocationState state) {
        if (state is Success) {
          _animationController.forward();
          try {
            final double latitude = state.gps.location.latitude!;
            final double longitude = state.gps.location.longitude!;
            final LatLng position = LatLng(latitude, longitude);
            final double headingInDegrees = state.gps.magnetometer.degree;
            final double rotation = (headingInDegrees * (math.pi / 180));
            return Stack(
              children: <Widget>[
                // El mapa como capa base
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialZoom: 16,
                    initialCenter: position,
                    interactionOptions: InteractionOptions(
                      flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                    ),
                  ),
                  children: <Widget>[
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName:
                          'com.quickdropltda.quickdrop_delivery',
                      retinaMode: true,
                      tileDimension: 256,
                    ),
                    MarkerLayer(
                      markers: <Marker>[
                        Marker(
                          point: position,
                          width: 40,
                          height: 40,
                          child: Transform.rotate(
                            angle: rotation,
                            child: Image.asset(
                              'assets/images/mark/delivery (30).webp',
                              fit: BoxFit.cover,
                              width: 60,
                              height: 60,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Capa de desenfoque animada
                if (!_animationController.isCompleted)
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (BuildContext context, Widget? child) {
                      return Positioned.fill(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: _animation.value,
                            sigmaY: _animation.value,
                          ),
                          child: child,
                        ),
                      );
                    },
                    child: Material(
                      color: Colors.transparent,
                    ),
                  ),
              ],
            );
          } catch (e) {
            return Center(child: Text('Error al cargar el mapa: $e'));
          }
        } else if (state is Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is Error) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Obteniendo ubicación...'),
                CircularProgressIndicator(),
              ],
            ),
          );
        }
      },
    );
  }
}
