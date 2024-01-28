import 'package:bloomdeliveyapp/ui/views/map_screen/controller/map_controller.dart';
import 'package:flutter/material.dart';

class AddingSteps extends StatefulWidget {
  final String? currentPlace;
  final void Function() onNext;
  final void Function() onPointAdded;
  final MapController mapController;

  const AddingSteps({
    Key? key,
    this.currentPlace,
    required this.mapController,
    required this.onNext,
    required this.onPointAdded,
  }) : super(key: key);

  @override
  State<AddingSteps> createState() => _AddingStepsState();
}

class _AddingStepsState extends State<AddingSteps> {
  bool isAdding = false;

  @override
  Widget build(BuildContext context) {
    return isAdding ? addPointView(context) : listOfPoints(context);
  }

  Widget addPointView(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Adding new stop",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.black,
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
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                widget.currentPlace ?? "Loading...",
                style: TextStyle(
                  color: Colors.black,
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
            onPressed: () {
              widget.onPointAdded();
              setState(() {
                isAdding = false;
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
            child: Text(
              'Add Stop',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget listOfPoints(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Confirm details",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isAdding = true;
                });
              },
              child: Text(
                "Add Stop +",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 10.0),
        ...widget.mapController.placesNames.map((place) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            margin: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.withOpacity(0.5),
                  ),
                  child: Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "${place}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.edit),
                const SizedBox(width: 10),
              ],
            ),
          );
        }),
        const SizedBox(height: 12.0),
        Container(
          width: double.infinity, // Fills the width of its parent
          child: ElevatedButton(
            onPressed: widget.onNext,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
            child: Text(
              'Confirm',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
