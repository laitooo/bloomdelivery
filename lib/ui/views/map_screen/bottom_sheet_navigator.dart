import 'dart:async';
import 'dart:ui';

import 'package:bloomdeliveyapp/ui/views/map_screen/order_creation/delivery_options.dart';
import 'package:bloomdeliveyapp/ui/views/map_screen/order_creation/drop_off_selection.dart';
import 'package:bloomdeliveyapp/ui/views/map_screen/order_creation/goods_selection.dart';
import 'package:bloomdeliveyapp/ui/views/map_screen/order_creation/pickup_selection.dart';
import 'package:bloomdeliveyapp/ui/views/map_screen/order_creation/receiver_info.dart';
import 'package:flutter/material.dart';

enum _OrderStep {
  pickupSelection,
  dropOffSelection,
  receiverInfo,
  deliveryOptions,
  goodsSelection,
  addingStops,
  confirmingOrder,
}

const _regularOrderSteps = [
  _OrderStep.pickupSelection,
  _OrderStep.dropOffSelection,
  _OrderStep.receiverInfo,
  _OrderStep.deliveryOptions,
  _OrderStep.goodsSelection,
  _OrderStep.confirmingOrder,
];

class BottomSheetNavigator extends StatelessWidget {
  // final MapController mapController;
  final Function(bool showRandomIcon) onMapChanged;
  final GlobalKey bottomSheetNavigatorKey;

  const BottomSheetNavigator({
    Key? key,
    // required this.mapController,
    required this.onMapChanged,
    required this.bottomSheetNavigatorKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheetNavigatorBuilder(
      key: bottomSheetNavigatorKey,
      // mapController: mapController,
      onMapChanged: onMapChanged,
    );
  }
}

class BottomSheetNavigatorBuilder extends StatefulWidget {
  // final MapController mapController;
  final Function(bool showRandomIcon) onMapChanged;

  const BottomSheetNavigatorBuilder({Key? key, required this.onMapChanged})
      : super(key: key);

  @override
  State<BottomSheetNavigatorBuilder> createState() =>
      BottomSheetNavigatorBuilderState();
}

class BottomSheetNavigatorBuilderState
    extends State<BottomSheetNavigatorBuilder> {
  int currentStep = 0;
  _OrderStep get step => _regularOrderSteps[currentStep];

  @override
  void initState() {
    super.initState();
  }

  void _onNext() async {
    final numSteps = _regularOrderSteps.length;
    if (currentStep + 1 == numSteps) {
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (_) => OrderCompletionPage(
      //       orderBuilderBloc: context.read<OrderBuilderBloc>(),
      //     ),
      //   ),
      // );
    } else {
      setState(() {
        ++currentStep;
      });
    }
  }

  Future<bool> _bottomSheetOnWillPop() async {
    if (currentStep == 2) {
      // context.read<OrderBuilderBloc>().add(
      //       ClearDonationCentersSelection(),
      //     );
    } else if (currentStep == 3) {
      // context.read<OrderBuilderBloc>().add(
      //       ClearDonationOptions(),
      //     );
    }
    widget.onMapChanged(currentStep == 3);

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
        // backgroundColor: context.theme.backgroundColor,
        title: Text(
          "t.exit",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            // color: context.theme.primaryTextColor,
          ),
        ),
        content: Text(
          "t.youSureYouWantToExit",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            // color: context.theme.primaryTextColor,
          ),
        ),
        actions: <Widget>[
          // ignore: deprecated_member_use
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              "t.no",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          // ignore: deprecated_member_use
          TextButton(
            onPressed: () {
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.of(context).pop(true);
              });
            },
            child: Text(
              "t.yes",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                // color: context.theme.primaryTextColor,
              ),
            ),
          ),
        ],
      ),
    ).then((value) => value ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _bottomSheetOnWillPop,
      child: Stack(
        children: [
          // if (requestedDetailsDonationCenter != null)
          //   Positioned.fill(
          //     child: BackdropFilter(
          //       filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          //       child: const SizedBox(),
          //     ),
          //   ),
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
                  currentStep == 4 ? SizedBox() : Padding(
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
                        vertical: currentStep == 4 ? 0 : 18.0,
                      ),
                      child: Builder(
                        builder: (context) {
                          // if (requestedDetailsDonationCenter != null) {
                          //   return BlocProvider(
                          //     create: (_) =>
                          //         FilterDataBloc()..add(LoadFilterData()),
                          //     child: DonationCenterDetails(
                          //         donationCenter:
                          //             requestedDetailsDonationCenter!),
                          //   );
                          // } else {
                          return _buildOrderStep(context);
                          // }
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
    );
  }

  Widget _buildOrderStep(BuildContext context) {
    switch (step) {
      case _OrderStep.pickupSelection:
        return PickupSelection(
          onNext: _onNext,
        );
      case _OrderStep.dropOffSelection:
        return DropOffSelection(
          onNext: _onNext,
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
        return DeliveryOptions(
          onNext: _onNext,
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
