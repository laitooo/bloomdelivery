import 'dart:async';

import 'package:bloomdeliveyapp/business_logic/view_models/order/create_order_viewmodel.dart';
import 'package:bloomdeliveyapp/services/service_locator.dart';
import 'package:bloomdeliveyapp/ui/views/map_screen/controller/map_controller.dart';
import 'package:bloomdeliveyapp/ui/views/map_screen/order_creation/adding_steps.dart';
import 'package:bloomdeliveyapp/ui/views/map_screen/order_creation/create_request_dialog.dart';
import 'package:bloomdeliveyapp/ui/views/map_screen/order_creation/delivery_options.dart';
import 'package:bloomdeliveyapp/ui/views/map_screen/order_creation/drop_off_selection.dart';
import 'package:bloomdeliveyapp/ui/views/map_screen/order_creation/goods_selection.dart';
import 'package:bloomdeliveyapp/ui/views/map_screen/order_creation/pickup_selection.dart';
import 'package:bloomdeliveyapp/ui/views/map_screen/order_creation/receiver_info.dart';
import 'package:bloomdeliveyapp/ui/views/map_screen/order_creation/confirming_order.dart';
import 'package:flutter/material.dart';

enum _OrderStep {
  pickupSelection,
  dropOffSelection,
  addingStops,
  receiverInfo,
  deliveryOptions,
  goodsSelection,
  confirmingOrder,
}

const _regularOrderSteps = [
  _OrderStep.pickupSelection,
  _OrderStep.dropOffSelection,
  _OrderStep.addingStops,
  _OrderStep.receiverInfo,
  _OrderStep.deliveryOptions,
  _OrderStep.goodsSelection,
  _OrderStep.confirmingOrder,
];

class BottomSheetNavigator extends StatefulWidget {
  final MapController mapController;
  final Function() onMapChanged;
  final GlobalKey bottomSheetNavigatorKey;

  BottomSheetNavigator({
    Key? key,
    required this.onMapChanged,
    required this.mapController,
    required this.bottomSheetNavigatorKey,
  }) : super(key: key);

  @override
  State<BottomSheetNavigator> createState() => BottomSheetNavigatorState();
}

class BottomSheetNavigatorState extends State<BottomSheetNavigator> {
  final createOrderViewModel = serviceLocator<CreateOrderViewModel>();

  int currentStep = 0;
  _OrderStep get step => _regularOrderSteps[currentStep];

  @override
  void initState() {
    super.initState();
  }

  void _onStepAdded() {
    widget.mapController.addStep();
    widget.onMapChanged();
  }

  void _onNext() async {
    if (currentStep == 0) {
      createOrderViewModel.start = widget.mapController.cameraPosition;
      widget.mapController.addPoint();
      widget.onMapChanged();
    }

    if (currentStep == 1) {
      createOrderViewModel.end = widget.mapController.cameraPosition;
      widget.mapController.addPoint();
      widget.onMapChanged();
    }

    final numSteps = _regularOrderSteps.length;
    if (currentStep + 1 != numSteps) {
      setState(() {
        ++currentStep;
      });
    }
  }

  void _createOrder(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateRequestDialog();
      },
    );
  }

  Future<bool> _bottomSheetOnWillPop() async {
    if (currentStep == 2) {}
    widget.onMapChanged();

    if (currentStep > 0) {
      setState(() {
        --currentStep;
      });
      return false;
    }

    return await _showExitDialog(context);
  }

  Future<bool> _showExitDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          "Exiting app",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        content: Text(
          "Are you sure you want to exit the app",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              "No",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.of(context).pop(true);
              });
            },
            child: Text(
              "Yes",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    ).then((value) => value ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.bottomSheetNavigatorKey,
      // ignore: deprecated_member_use
      child: WillPopScope(
        onWillPop: _bottomSheetOnWillPop,
        child: Stack(
          children: [
            GestureDetector(
              onTap: currentStep == 0 ? _onNext : null,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(32.0),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    currentStep == 5
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(),
                                Center(
                                  child: Container(
                                    width: 64,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(),
                              ],
                            ),
                          ),
                    AnimatedSize(
                      alignment: Alignment.bottomCenter,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 33.0,
                          vertical: currentStep == 5 ? 0 : 18.0,
                        ),
                        child: Builder(
                          builder: (context) {
                            return _buildOrderStep(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderStep(BuildContext context) {
    switch (step) {
      case _OrderStep.pickupSelection:
        return PickupSelection(
          onNext: _onNext,
          currentPlace: widget.mapController.currentPlace,
        );
      case _OrderStep.dropOffSelection:
        return DropOffSelection(
          onNext: _onNext,
          currentPlace: widget.mapController.currentPlace,
        );
      case _OrderStep.addingStops:
        return AddingSteps(
          mapController: widget.mapController,
          onNext: _onNext,
          onPointAdded: _onStepAdded,
          currentPlace: widget.mapController.currentPlace,
        );
      case _OrderStep.receiverInfo:
        return ReceiverInfo(
          onNext: _onNext,
        );
      case _OrderStep.deliveryOptions:
        return DeliveryOptions(
          onNext: _onNext,
        );
      case _OrderStep.goodsSelection:
        return GoodsSelection(
          onNext: _onNext,
        );
      case _OrderStep.confirmingOrder:
        return ConfirmingOrder(
          onNext: () {
            _createOrder(context);
          },
        );
      default:
        return Container(
          width: 400,
          height: 600,
          color: Colors.blue,
          child: Text("ZXCCZXCXZ zxC"),
        );
    }
  }
}
