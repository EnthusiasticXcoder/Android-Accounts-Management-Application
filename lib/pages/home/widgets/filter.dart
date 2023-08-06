import 'package:flutter/material.dart';
import 'package:my_app/services/services.dart';

import '../view/filter_view.dart';

class Filter extends StatelessWidget {
  const Filter({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => FilterView(),
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
            const Text(
              'No Filter',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            // clear filter button
            IconButton(
                onPressed: () {
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
