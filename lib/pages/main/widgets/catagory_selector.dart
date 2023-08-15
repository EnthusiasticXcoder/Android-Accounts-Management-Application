import 'package:flutter/material.dart';
import 'package:my_app/services/services.dart';

typedef ValueCallback = void Function(int?);

class CatagorySelector extends StatelessWidget {
  final List catagory;
  final List subcatagory;
  final List<bool> isVisible = [];
  final List<List<Catagory>> _subCatagoryList = [[]];

  CatagorySelector(
      {super.key,
      required this.catagory,
      required this.subcatagory,
      bool isVisible = false}) {
    this.isVisible.add(isVisible);
  }

  @override
  Widget build(BuildContext context) {
    final filter = DatabaseService().filters;
    return StatefulBuilder(
      builder: (context, setState) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Catagory Field
          dropMenuButton(
              catagoryList: filter.map((element) => element.catagory),
              value: catagory.elementAtOrNull(0),
              hint: 'Catagory',
              onselect: (int? newValue) {
                setState(() {
                  isVisible.removeAt(0);
                  isVisible.insert(0, true);
                  if (catagory.isNotEmpty) catagory.removeLast();
                  catagory.insert(0, newValue);
                  // adding sub catagory
                  if (_subCatagoryList.isNotEmpty) _subCatagoryList.removeAt(0);
                  _subCatagoryList.insert(
                      0,
                      filter
                          .firstWhere(
                              (element) => element.catagory.id == newValue)
                          .subcatagory);
                  if (subcatagory.isNotEmpty) subcatagory.removeLast();
                  subcatagory.insert(0, null);
                });
              }),

          // Margin
          const SizedBox(height: 8.0),
          // sub catagory
          Visibility(
              visible: isVisible.first,
              child: dropMenuButton(
                  value: subcatagory.elementAtOrNull(0),
                  catagoryList: _subCatagoryList.first,
                  hint: 'SubCatagory',
                  onselect: (int? newValue) {
                    setState(() {
                      if (subcatagory.isNotEmpty) subcatagory.removeLast();
                      subcatagory.insert(0, newValue);
                    });
                  })),
        ],
      ),
    );
  }

  Container dropMenuButton({
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
