import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_app/pages/main/widgets/catagory_selector.dart';
import 'package:my_app/services/services.dart';

class CreateNewNodeDialog extends StatefulWidget {
  const CreateNewNodeDialog({super.key, required this.isIncome});
  final bool isIncome;

  @override
  State<CreateNewNodeDialog> createState() => _CreateNewNodeDialogState();
}

class _CreateNewNodeDialogState extends State<CreateNewNodeDialog> {
  late final TextEditingController _amountController;
  late final FilterBy _filterBy;

  @override
  void initState() {
    _amountController = TextEditingController();
    _filterBy = FilterBy(year: 2023);
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
            filterBy: _filterBy,
          ),
        ],
      ),
      contentPadding: const EdgeInsets.only(
          left: 22.0, right: 22.0, top: 25.0, bottom: 8.0),
      actions: [
        TextButton(
            onPressed: () {
              if (_amountController.text.isNotEmpty) {
                final amount = int.tryParse(_amountController.text)!;
                final catagoryId = _filterBy.catagory;
                final subCatagoryId = _filterBy.subcatagory;
                final isIncome = (widget.isIncome) ? 1 : 0;

                context.read<MainBloc>().add(MainEventCreateNode(
                    amount: amount,
                    catagoryId: catagoryId!,
                    subCatagoryId: subCatagoryId!,
                    isIncome: isIncome),);
              }

              Navigator.of(context).pop();
            },
            child: const Text("Done"))
      ],
    );
  }
}
