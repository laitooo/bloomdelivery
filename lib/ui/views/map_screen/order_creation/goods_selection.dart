import 'package:flutter/material.dart';

const goodsList = [
  "Timber/ Plywood/ Lamina",
  "Electrical/ Electronic/ Home",
  "Building/ Construction",
  "Catering/ Restaurants/ Events",
  "Machines/ Equipments/ Space",
  "Textile/ Garments/ Fashion",
  "Furniture/ Home furnishing",
  "House Shifting",
  "Ceramics, Sanitary ware",
  "Paper/ Packaging/ Printed Mat",
  "Chemicals/ Paints",
  "Logistics service provider",
  "Perishable food",
  "Pharmacy/ Medical/ Healthcare",
  "FMCG/ Food products",
  "Platic/ Rubber",
];

class GoodsSelection extends StatefulWidget {
  const GoodsSelection({
    Key? key,
    required this.onNext,
  }) : super(key: key);

  final void Function() onNext;

  @override
  State<GoodsSelection> createState() => _GoodsSelectionState();
}

class _GoodsSelectionState extends State<GoodsSelection> {
  String? selectedGood = null;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(top: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          Text(
            "Receiver Info",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10.0),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: List.generate(
                goodsList.length,
                (index) => _goodChoice(
                  goodsList[index],
                ),
              ),
            ),
          ),
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
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }

  Widget _goodChoice(String goodName) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedGood = goodName;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              goodName,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Radio(
              value: goodName,
              groupValue: selectedGood,
              onChanged: (value) {
                setState(() {
                  selectedGood = value.toString();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
