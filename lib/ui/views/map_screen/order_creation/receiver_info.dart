import 'package:bloomdeliveyapp/business_logic/view_models/order/create_order_viewmodel.dart';
import 'package:bloomdeliveyapp/ui/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController instructionsController;

  submitReceiverInfo() {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter receiver name'),
        ),
      );
      return;
    }

    // TODO: do phone number validation
    if (phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter receiver phone'),
        ),
      );
      return;
    }

    if (instructionsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter delivery instruction'),
        ),
      );
      return;
    }

    Provider.of<CreateOrderViewModel>(context, listen: false).addReceiverInfo(
      nameController.text,
      phoneController.text,
      instructionsController.text,
    );

    widget.onNext();
  }

  @override
  void initState() {
    final viewModel = Provider.of<CreateOrderViewModel>(context, listen: false);
    nameController = TextEditingController(
      text: viewModel.receiverName,
    );
    phoneController = TextEditingController(
      text: viewModel.receiverPhoneNumber,
    );
    instructionsController = TextEditingController(
      text: viewModel.deliveryInstructions,
    );
    super.initState();
  }

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
            color: context.theme.bottomSheetTitleColor,
          ),
        ),
        const SizedBox(height: 10.0),
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            hintText: 'Name',
            filled: true,
            fillColor: Colors.grey.withOpacity(0.3),
            hintStyle: TextStyle(
              color: Colors.black.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 16.0),
        TextField(
          keyboardType: TextInputType.phone,
          controller: phoneController,
          decoration: InputDecoration(
            hintText: 'Phone number',
            filled: true,
            fillColor: Colors.grey.withOpacity(0.3),
            hintStyle: TextStyle(
              color: Colors.black.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 16.0),
        Container(
          height: 120,
          child: TextField(
            controller: instructionsController,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            expands: true,
            decoration: InputDecoration(
              isDense: true,
              hintText: 'Delivery instructions',
              filled: true,
              fillColor: Colors.grey.withOpacity(0.3),
              hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Container(
          width: double.infinity, // Fills the width of its parent
          child: ElevatedButton(
            onPressed: submitReceiverInfo,
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
