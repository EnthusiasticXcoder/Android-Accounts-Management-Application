import 'package:flutter/material.dart';
import 'package:my_app/pages/home/widgets/catagory_selector.dart';
import 'package:my_app/services/services.dart';

class FilterView extends StatelessWidget {
  FilterView({super.key});

  final List _catagory = [],
      _subcatagory = [],
      _year = [yearList.firstOrNull],
      _month = [],
      _date = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.47,
          margin: const EdgeInsets.all(14.0),
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
              color: Colors.lightBlue.shade50,
              borderRadius: BorderRadius.circular(24.0)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filter',
                style: TextStyle(fontSize: 24, height: 3.0),
              ),
              // Margin
              const SizedBox(height: 18.0),
              // Catagoryselector
              CatagorySelector(
                catagory: _catagory,
                subcatagory: _subcatagory,
                isVisible: true,
              ),

              // Margin
              const SizedBox(height: 18.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // year selector
                  DropdownMenu(
                    onSelected: (value) {
                      if (_year.isNotEmpty) _year.removeLast();
                      _year.insert(0, value);
                    },
                    initialSelection: yearList.firstOrNull,
                    width: MediaQuery.of(context).size.width * 0.27,
                    hintText: 'Year',
                    inputDecorationTheme: InputDecorationTheme(
                        border: OutlineInputBorder(
                            gapPadding: 0,
                            borderRadius: BorderRadius.circular(12))),
                    dropdownMenuEntries: yearList
                        .map((year) =>
                            DropdownMenuEntry(value: year, label: '$year'))
                        .toList(),
                  ),

                  // Margin
                  const SizedBox(width: 12.0),
                  // month selector
                  DropdownMenu(
                    onSelected: (value) {
                      if (_month.isNotEmpty) _month.removeLast();
                      _month.insert(0, value);
                    },
                    width: MediaQuery.of(context).size.width * 0.26,
                    hintText: 'Mon',
                    inputDecorationTheme: InputDecorationTheme(
                        border: OutlineInputBorder(
                            gapPadding: 0,
                            borderRadius: BorderRadius.circular(12))),
                    dropdownMenuEntries: monthList
                        .map((mon) =>
                            DropdownMenuEntry(value: mon, label: '$mon'))
                        .toList(),
                  ),

                  // Margin
                  const SizedBox(width: 12.0),
                  // date selector
                  DropdownMenu(
                    onSelected: (value) {
                      if (_date.isNotEmpty) _date.removeLast();
                      _date.insert(0, value);
                    },
                    width: MediaQuery.of(context).size.width * 0.24,
                    hintText: 'Day',
                    inputDecorationTheme: InputDecorationTheme(
                        border: OutlineInputBorder(
                            gapPadding: 0,
                            borderRadius: BorderRadius.circular(12))),
                    dropdownMenuEntries: dateList
                        .map((date) =>
                            DropdownMenuEntry(value: date, label: '$date'))
                        .toList(),
                  ),
                ],
              ),

              // Margin
              const SizedBox(height: 12.0),
              // actions
              ListTile(
                title: TextButton(
                    onPressed: () {
                      filterNodes(null);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Clear')),
                trailing: TextButton(
                    onPressed: () {
                      if (_year.firstOrNull != null) {
                        final filter = FilterBy(
                            year: _year.first,
                            month: _month.firstOrNull,
                            date: _date.firstOrNull,
                            catagory: _catagory.firstOrNull,
                            subcatagory: _subcatagory.firstOrNull);

                        filterNodes(filter);
                      }
                      Navigator.of(context).pop();
                    },
                    child: const Text('Apply')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
