import 'package:flutter/material.dart';
import 'package:my_app/pages/home/widgets/catagory_selector.dart';

class FilterView extends StatelessWidget {
  const FilterView({
    super.key,
    required List catagory,
    required List subcatagory,
  })  : _catagory = catagory,
        _subcatagory = subcatagory;

  final List _catagory;
  final List _subcatagory;

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
                  DropdownMenu(
                    width: MediaQuery.of(context).size.width * 0.27,
                    hintText: 'Year',
                    inputDecorationTheme: InputDecorationTheme(
                        border: OutlineInputBorder(
                            gapPadding: 0,
                            borderRadius: BorderRadius.circular(12))),
                    dropdownMenuEntries: List.generate(
                        3,
                        (i) => DropdownMenuEntry(
                            value: i + 2020, label: '${i + 2020}')),
                  ),

                  // Margin
                  const SizedBox(width: 12.0),
                  DropdownMenu(
                    width: MediaQuery.of(context).size.width * 0.26,
                    hintText: 'Mon',
                    inputDecorationTheme: InputDecorationTheme(
                        border: OutlineInputBorder(
                            gapPadding: 0,
                            borderRadius: BorderRadius.circular(12))),
                    dropdownMenuEntries: List.generate(12,
                        (i) => DropdownMenuEntry(value: i + 1, label: 'jan')),
                  ),

                  // Margin
                  const SizedBox(width: 12.0),
                  DropdownMenu(
                    width: MediaQuery.of(context).size.width * 0.24,
                    hintText: 'Day',
                    inputDecorationTheme: InputDecorationTheme(
                        border: OutlineInputBorder(
                            gapPadding: 0,
                            borderRadius: BorderRadius.circular(12))),
                    dropdownMenuEntries: List.generate(
                        31,
                        (i) =>
                            DropdownMenuEntry(value: i + 1, label: '${i + 1}')),
                  ),
                ],
              ),

              // Margin
              const SizedBox(height: 12.0),
              // actions
              ListTile(
                title: TextButton(onPressed: () {}, child: const Text('Clear')),
                trailing: TextButton(onPressed: () {}, child: const Text('Apply')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
