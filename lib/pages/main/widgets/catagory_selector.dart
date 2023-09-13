import 'package:flutter/material.dart';
import 'package:my_app/services/services.dart';

typedef ValueCallback = void Function(int?);

class CatagorySelector extends StatelessWidget {
  final FilterBy filterBy;
  final List<bool> isVisible = [];
  final List<List<Catagory>> _subCatagoryList = [[]];
  late final List<Filters> filter;

  CatagorySelector(
      {super.key, bool isVisible = false, required this.filterBy}) {
    this.isVisible.add(isVisible);

    filter = DatabaseService().filters;

    if (filterBy.catagory != null) {
      _subCatagoryList[0] = filter
          .firstWhere((item) => item.catagory.id == filterBy.catagory)
          .subcatagory;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Catagory Field
          dropMenuButton(
              catagoryList: filter.map((element) => element.catagory),
              value: filterBy.catagory,
              hint: 'Catagory',
              onselect: (int? newValue) {
                setState(() {
                  isVisible.removeAt(0);
                  isVisible.insert(0, true);
                  filterBy.catagory = newValue;
                  // adding sub catagory
                  _subCatagoryList[0] = filter
                      .firstWhere((element) => element.catagory.id == newValue)
                      .subcatagory;

                  filterBy.subcatagory = null;
                });
              }),

          // Margin
          const SizedBox(height: 8.0),
          // sub catagory
          Visibility(
              visible: isVisible.first,
              child: dropMenuButton(
                  value: filterBy.subcatagory,
                  catagoryList: _subCatagoryList.first,
                  hint: 'SubCatagory',
                  onselect: (int? newValue) {
                    setState(() {
                      filterBy.subcatagory = newValue;
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
