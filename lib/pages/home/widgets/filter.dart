import 'package:flutter/material.dart';

import '../view/filter_view.dart';
import 'package:my_app/utils/utils.dart';


class Filter extends StatelessWidget {
  Filter({super.key});

  final List _catagory = [],
      _subcatagory = [],
      _year = [yearList.firstOrNull],
      _month = [],
      _date = [];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => FilterView(
              catagory: _catagory,
              subcatagory: _subcatagory,
              year: _year,
              month: _month,
              date: _date),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(left: 15.0),
        width: 200.0,
        decoration: BoxDecoration(
          color: const Color.fromARGB(129, 227, 242, 253),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: -1.0,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // margin
            const SizedBox(),
            // textfield to show filter
            ValueListenableBuilder(
                valueListenable: nodeValueNotifier,
                builder: (context, __, _) {
                  List text = [];
                  if (_catagory.isNotEmpty) text.add(' Catagory');
                  if (_subcatagory.isNotEmpty) text.add(' Subcatagory');
                  if (_month.isNotEmpty) text.add('Date');
                  String value = 'No Filter';
                  if (text.isNotEmpty) {
                    value = 'Filter By : ${text.first}';
                  }
                  return SizedBox(
                    width: 100,
                    child: Text(
                      value,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  );
                }),
            // clear filter button
            IconButton(
                onPressed: () {
                  if (_catagory.isNotEmpty) _catagory.removeLast();
                  if (_subcatagory.isNotEmpty) _subcatagory.removeLast();
                  if (_date.isNotEmpty) _date.removeLast();
                  if (_month.isNotEmpty) _month.removeLast();
                  if (_year.isNotEmpty) _year.removeLast();
                  filterNodes(null);
                },
                icon: Icon(
                  Icons.filter_alt_off_rounded,
                  color: Colors.blue.shade500,
                )),
          ],
        ),
      ),
    );
  }
}
