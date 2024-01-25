import 'package:flutter/material.dart';

class ReceiverInfo extends StatefulWidget {
  const ReceiverInfo({
    Key? key,
    required this.onNext,
  }) : super(key: key);

  final void Function() onNext;

  @override
  State<ReceiverInfo> createState() => _ReceiverInfoState();
}

class _ReceiverInfoState extends State<ReceiverInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Receiver Info",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10.0),
        TextField(
          decoration: InputDecoration(
            hintText: 'Name',
          ),
        ),
        SizedBox(height: 16.0),
        TextField(
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: 'Phone number',
          ),
        ),
        SizedBox(height: 16.0),
        TextField(
          maxLines: null, // Allows for multiple lines of input
          decoration: InputDecoration(
            hintText: 'Delivery instructions',
          ),
        ),
        SizedBox(height: 16.0),
        Container(
          width: double.infinity, // Fills the width of its parent
          child: ElevatedButton(
            onPressed: widget.onNext,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
            child: Text(
              'Confirm information',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
