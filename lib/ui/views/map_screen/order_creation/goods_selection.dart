import 'package:bloomdeliveyapp/business_logic/view_models/order/create_order_viewmodel.dart';
import 'package:bloomdeliveyapp/ui/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  String? selectedGood;

  submitGoods() {
    if (selectedGood == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select goods type'),
        ),
      );
      return;
    }

    final viewModel = Provider.of<CreateOrderViewModel>(context, listen: false);
    viewModel.addGoods(selectedGood!);
    widget.onNext();
  }

  @override
  void initState() {
    final viewModel = Provider.of<CreateOrderViewModel>(context, listen: false);
    selectedGood = viewModel.goods;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 36,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Text(
            "Goods type",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: context.theme.bottomSheetTitleColor,
            ),
          ),
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
              onPressed: submitGoods,
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
                color: context.theme.bottomSheetTextColor,
              ),
            ),
            Radio(
              value: goodName,
              groupValue: selectedGood,
              activeColor: context.theme.bottomSheetTextColor,
              fillColor: MaterialStateProperty.all(context.theme.bottomSheetTextColor),
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
