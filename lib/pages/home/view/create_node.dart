part of '../widgets/tab_bar.dart';

class CreateNewNodeDialog extends StatefulWidget {
  const CreateNewNodeDialog({super.key, required this.isIncome});
  final bool isIncome;

  @override
  State<CreateNewNodeDialog> createState() => _CreateNewNodeDialogState();
}

class _CreateNewNodeDialogState extends State<CreateNewNodeDialog> {
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
      title: Text(
        (widget.isIncome) ? 'Income' : 'Expense',
        style: TextStyle(color: (widget.isIncome) ? Colors.green : Colors.red),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
          const SizedBox(height: 18),
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
                await _databaseService.createNode(
                  amount: int.tryParse(_amountController.text)!,
                  description: _descriptionController.text.toString(),
                  isIncome: (widget.isIncome) ? 1 : 0,
                );
              }
            },
            child: const Text("Done"))
      ],
    );
  }
}
