import 'package:flutter/material.dart';
import 'package:my_app/services/services.dart';

typedef ValueCallback = void Function(int?);

class CreateNewNodeDialog extends StatefulWidget {
  const CreateNewNodeDialog({super.key, required this.isIncome});
  final bool isIncome;

  @override
  State<CreateNewNodeDialog> createState() => _CreateNewNodeDialogState();
}

class _CreateNewNodeDialogState extends State<CreateNewNodeDialog> {
  late final TextEditingController _amountController;

  bool isVisible = false;
  int? _catagory, _subCatagory;
  List<Catagory> _subCatagoryList = [];

  @override
  void initState() {
    _amountController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filter = allFilters;
    return AlertDialog(
      title: Text(
        (widget.isIncome) ? 'Income' : 'Expense',
        style: TextStyle(color: (widget.isIncome) ? Colors.green : Colors.red),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Amount Field
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Amount',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: (widget.isIncome) ? Colors.green : Colors.red),
              ),
              border: const OutlineInputBorder(),
              prefixIcon: Icon(
                Icons.currency_rupee_outlined,
                color: (widget.isIncome) ? Colors.green : Colors.red,
              ),
            ),
          ),
          // Margin
          const SizedBox(height: 18.0),
          // Catagory Field
          catagorySelector(
            catagoryList: filter.map((element) => element.catagory),
            value: _catagory,
            hint: 'Catagory',
            onselect: (int? newValue) {
              setState(() {
                isVisible = true;
                _catagory = newValue;
                _subCatagoryList = filter
                    .firstWhere((element) => element.catagory.id == newValue)
                    .subcatagory;

                _subCatagory = null;
              });
            },
          ),
          // Margin
          const SizedBox(height: 8.0),
          // sub catagory
          Visibility(
              visible: isVisible,
              child: catagorySelector(
                  value: _subCatagory,
                  catagoryList: _subCatagoryList,
                  hint: 'SubCatagory',
                  onselect: (int? newValue) {
                    setState(() {
                      _subCatagory = newValue;
                    });
                  })),
        ],
      ),
      contentPadding: const EdgeInsets.only(
          left: 22.0, right: 22.0, top: 25.0, bottom: 8.0),
      actions: [
        TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              if (_amountController.text.isNotEmpty) {
                await createNode(
                  amount: int.tryParse(_amountController.text)!,
                  catagoryId: _catagory!,
                  subCatagoryId: _subCatagory!,
                  isIncome: (widget.isIncome) ? 1 : 0,
                );
              }
            },
            child: const Text("Done"))
      ],
    );
  }

  Widget catagorySelector({
    required Iterable<Catagory> catagoryList,
    int? value,
    String? hint,
    ValueCallback? onselect,
  }) {
    return Container(
      width: 120,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.blueGrey, width: 1)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
            value: value,
            hint: Text((hint == null) ? '' : hint),
            isExpanded: true,
            dropdownColor: Colors.lightBlue.shade50,
            borderRadius: BorderRadius.circular(22),
            items: catagoryList
                .map((item) => DropdownMenuItem<int>(
                    value: item.id, child: Text(item.name)))
                .toList(),
            onChanged: onselect),
      ),
    );
  }
}
