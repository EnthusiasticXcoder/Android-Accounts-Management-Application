part of '../widgets/tab_bar.dart';

class CreateExpenseDialog extends StatefulWidget {
  const CreateExpenseDialog({super.key});

  @override
  State<CreateExpenseDialog> createState() => _CreateExpenseDialogState();
}

class _CreateExpenseDialogState extends State<CreateExpenseDialog> {
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
        'Expense',
        style: TextStyle(color: Colors.red),
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
                borderSide: BorderSide(color: Colors.red),
              ),
              border: OutlineInputBorder(),
              prefixIcon: Icon(
                Icons.currency_rupee_outlined,
                color: Colors.red,
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
            onPressed: (){
              Navigator.of(context).pop();
              if (_amountController.text.isNotEmpty &&
                  _descriptionController.text.isNotEmpty) {
                _databaseService.createExpenseNode(
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
