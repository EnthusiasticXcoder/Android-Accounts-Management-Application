import 'package:flutter/material.dart';

import 'package:my_app/pages/home/widgets/catagory_selector.dart';
import 'package:my_app/utils/utils.dart';

class FilterView extends StatelessWidget {
  const FilterView(
      {super.key,
      required this.catagory,
      required this.subcatagory,
      required this.year,
      required this.month,
      required this.date});

  final List catagory, subcatagory, year, month, date;

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
                catagory: catagory,
                subcatagory: subcatagory,
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
                      if (year.isNotEmpty) year.removeLast();
                      year.insert(0, value);
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
                      if (month.isNotEmpty) month.removeLast();
                      month.insert(0, value);
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
                      if (date.isNotEmpty) date.removeLast();
                      date.insert(0, value);
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
                      if (catagory.isNotEmpty) catagory.removeLast();
                      if (subcatagory.isNotEmpty) subcatagory.removeLast();
                      if (date.isNotEmpty) date.removeLast();
                      if (month.isNotEmpty) month.removeLast();
                      if (year.isNotEmpty) year.removeLast();
                      filterNodes(null);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Clear')),
                trailing: TextButton(
                    onPressed: () {
                      if (year.firstOrNull != null) {
                        final filter = FilterBy(
                            year: year.first,
                            month: month.firstOrNull,
                            date: date.firstOrNull,
                            catagory: catagory.firstOrNull,
                            subcatagory: subcatagory.firstOrNull);

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
