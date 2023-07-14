import 'package:flutter/material.dart';
import 'package:my_app/services/database_service.dart';
import 'package:my_app/utilities/controllers/state_controller.dart';

class CreateIncomeDialog extends StatefulWidget {
  const CreateIncomeDialog({super.key});

  @override
  State<CreateIncomeDialog> createState() => _CreateIncomeDialogState();
}

class _CreateIncomeDialogState extends State<CreateIncomeDialog> {
  late final TextEditingController _amountController;
  late final TextEditingController _descriptionController;

  late final DatabaseService _databaseService;

  @override
  void initState() {
    _amountController = TextEditingController();
    _descriptionController = TextEditingController();
    _databaseService = DatabaseService();
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Income',
        style: TextStyle(color: Colors.green),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Amount Field
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Amount',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
              border: OutlineInputBorder(),
              prefixIcon: Icon(
                Icons.currency_rupee_outlined,
                color: Colors.green,
              ),
            ),
          ),
          // Margin
          const SizedBox(
            height: 18,
          ),
          // Description Field
          TextField(
            controller: _descriptionController,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              labelText: 'Description',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey.shade700)),
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
      contentPadding: const EdgeInsets.only(
          left: 22.0, right: 22.0, top: 25.0, bottom: 8.0),
      actions: [
        TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              if (_amountController.text.isNotEmpty &&
                  _descriptionController.text.isNotEmpty) {
                await _databaseService.createIncomeNode(
                  amount: int.tryParse(_amountController.text),
                  description: _descriptionController.text.toString(),
                );
                StateController().setStates();
              }
            },
            child: const Text("Done"))
      ],
    );
  }
}
