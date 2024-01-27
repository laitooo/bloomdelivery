import 'package:bloomdeliveyapp/ui/views/map_screen/controller/map_controller.dart';
import 'package:flutter/material.dart';

class MapBuilder extends StatefulWidget {
  final MapController Function(BuildContext context) create;
  final Widget Function(BuildContext, MapController) builder;

  const MapBuilder({
    Key? key,
    required this.create,
    required this.builder,
  }) : super(key: key);

  static MapController of(BuildContext context) {
    return context.findAncestorStateOfType<_MapBuilderState>()!.controller;
  }

  @override
  State<MapBuilder> createState() => _MapBuilderState();
}

class _MapBuilderState extends State<MapBuilder> {
  late final MapController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.create(context);
    //controller.moveToCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return widget.builder(context, controller);
      },
    );
  }
}
