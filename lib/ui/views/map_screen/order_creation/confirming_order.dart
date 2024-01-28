import 'package:bloomdeliveyapp/business_logic/view_models/order/create_order_viewmodel.dart';
import 'package:bloomdeliveyapp/ui/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ConfirmingOrder extends StatefulWidget {
  final void Function() onNext;
  final void Function() onEditReceiverInformation;
  final void Function() onEditGoods;

  const ConfirmingOrder({
    Key? key,
    required this.onNext,
    required this.onEditReceiverInformation,
    required this.onEditGoods,
  }) : super(key: key);

  @override
  State<ConfirmingOrder> createState() => _ConfirmingOrderState();
}

class _ConfirmingOrderState extends State<ConfirmingOrder> {
  late RideType type;

  submitDeliveryOptions() {
    final viewModel = Provider.of<CreateOrderViewModel>(context, listen: false);
    // TODO: calculate real price instead of fixed price
    viewModel.addDeliveryOption(
      type,
      type == RideType.motorCycle ? 90.75 : 120.50,
    );
    widget.onNext();
  }

  @override
  void initState() {
    final viewModel = Provider.of<CreateOrderViewModel>(context, listen: false);
    type = viewModel.rideType ?? RideType.motorCycle;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CreateOrderViewModel>(context, listen: false);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Confirming order",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: context.theme.bottomSheetTitleColor,
          ),
        ),
        const SizedBox(height: 0.0),
        Text(
          "Available Rides",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            Flexible(
              flex: 1,
              child: _RideTypeButton(
                name: "Moto driver",
                price: "90.75 \$",
                // image: Image(image: NetworkImage('')),
                image: Image.network(
                  "https://thumbs.dreamstime.com/b/scooter-delivering-realistic-motorbike-side-view-d-vehicle-square-box-shipping-restaurant-orders-fast-courier-white-216391649.jpg",
                  height: 50,
                ),
                isSelected: type == RideType.motorCycle,
                onPressed: () {
                  setState(() {
                    type = RideType.motorCycle;
                  });
                },
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              flex: 1,
              child: _RideTypeButton(
                name: "Van driver",
                price: "120.50 \$",
                // image: Image(image: NetworkImage('')),
                image: Image.network(
                  "https://thumbs.dreamstime.com/b/delivery-van-7425887.jpg",
                  height: 50,
                ),
                isSelected: type == RideType.van,
                onPressed: () {
                  setState(() {
                    type = RideType.van;
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 30.0),
        Text(
          "Pickup Contact",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 6.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  viewModel.receiverName!,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
                const Spacer(),
                Text(
                  viewModel.receiverPhoneNumber!,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: widget.onEditReceiverInformation,
                  child: Icon(
                    Icons.edit,
                    size: 16,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              viewModel.deliveryInstructions!,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30.0),
        Text(
          "Paying via",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 6.0),
        Row(
          children: [
            Icon(
              Icons.money_outlined,
              size: 16,
              color: Colors.green,
            ),
            const SizedBox(width: 4.0),
            Text(
              "Cash",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.green,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                // TODO: Implement this
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Not implemented yet'),
                  ),
                );
              },
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Text(
          "Goods type",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 6.0),
        Row(
          children: [
            Expanded(
              child: Text(
                viewModel.goods!,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.green,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: widget.onEditGoods,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Container(
          width: double.infinity, // Fills the width of its parent
          child: ElevatedButton(
            onPressed: widget.onNext,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
            child: Text(
              'Ride now',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class _RideTypeButton extends StatelessWidget {
  const _RideTypeButton({
    Key? key,
    required this.name,
    required this.price,
    required this.image,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  final String name;
  final String price;
  final Widget image;
  final bool isSelected;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          border: Border.all(
            width: isSelected ? 2 : 2,
            color: isSelected ? Colors.green : Colors.grey.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: image),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 12.0),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: context.theme.bottomSheetTextColor,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  price,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: context.theme.bottomSheetTextColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
