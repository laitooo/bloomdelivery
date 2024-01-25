import 'package:flutter/material.dart';

enum RideType {
  motorCycle,
  van,
}

class DeliveryOptions extends StatefulWidget {
  const DeliveryOptions({
    Key? key,
    required this.onNext,
  }) : super(key: key);

  final void Function() onNext;

  @override
  State<DeliveryOptions> createState() => _DeliveryOptionsState();
}

class _DeliveryOptionsState extends State<DeliveryOptions> {
  RideType type = RideType.motorCycle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Delivery options",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.black,
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
                image: Container(
                  width: 50,
                  height: 50,
                  color: Colors.blue,
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
                image: Container(
                  width: 50,
                  height: 50,
                  color: Colors.blue,
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
        const SizedBox(height: 20.0),
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
                  "Ahmed",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
                const Spacer(),
                Text(
                  "+971555555555",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.edit,
                    size: 16,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            const Text(
              "Instructions: Tell me how long will it take",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
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
              onTap: () {},
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Container(
          width: double.infinity, // Fills the width of its parent
          child: ElevatedButton(
            onPressed: widget.onNext,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
            child: Text(
              'Choose Goods Type',
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
            image,
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
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  price,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
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
