import 'package:flutter/material.dart';

import 'package:my_app/pages/home/widgets/catagory_selector.dart';
import 'package:my_app/utils/utils.dart';


class CreateNewNodeDialog extends StatefulWidget {
  const CreateNewNodeDialog({super.key, required this.isIncome});
  final bool isIncome;

  @override
  State<CreateNewNodeDialog> createState() => _CreateNewNodeDialogState();
}

class _CreateNewNodeDialogState extends State<CreateNewNodeDialog> {
  late final TextEditingController _amountController;
  final List _catagory = [], _subcatagory = [];

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
          // Catagoryselector
          CatagorySelector(
            catagory: _catagory,
            subcatagory: _subcatagory,
          ),
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
                  catagoryId: _catagory.elementAt(0),
                  subCatagoryId: _subcatagory.elementAt(0),
                  isIncome: (widget.isIncome) ? 1 : 0,
                );
              }
            },
            child: const Text("Done"))
      ],
    );
  }
}
