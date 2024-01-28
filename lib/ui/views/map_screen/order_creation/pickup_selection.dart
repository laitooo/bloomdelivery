import 'package:bloomdeliveyapp/ui/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class PickupSelection extends StatefulWidget {
  final String? currentPlace;
  final void Function() onNext;

  const PickupSelection({
    Key? key,
    this.currentPlace,
    required this.onNext,
  }) : super(key: key);

  @override
  State<PickupSelection> createState() => _PickupSelectionState();
}

class _PickupSelectionState extends State<PickupSelection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Where is your pickup?",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: context.theme.bottomSheetTitleColor,
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.location_pin,
                  size: 30,
                  color: context.theme.bottomSheetIconColor,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                widget.currentPlace ?? "Loading...",
                style: TextStyle(
                  color: context.theme.bottomSheetTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          width: double.infinity, // Fills the width of its parent
          child: ElevatedButton(
            onPressed: widget.onNext,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
            child: Text(
              'Confirm Pickup',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
