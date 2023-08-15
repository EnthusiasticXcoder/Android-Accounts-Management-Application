import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/services/services.dart';

class Filter extends StatelessWidget {
  final VoidCallback onTap;
  final List catagory, subcatagory, year, month, date;

  const Filter({
    super.key,
    required this.onTap,
    required this.catagory,
    required this.subcatagory,
    required this.year,
    required this.month,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
            BlocBuilder<MainBloc, MainState>(
              buildWhen: (previous, current) => current is MainStateHomePage,
              builder: (context, state) {
                if (state is MainStateHomePage) {
                  List text = [];
                  if (catagory.isNotEmpty) text.add(' Catagory');
                  if (subcatagory.isNotEmpty) text.add(' Subcatagory');
                  if (month.isNotEmpty) text.add('Date');
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
                } else {
                  return Container();
                }
              },
            ),

            // clear filter button
            IconButton(
                onPressed: () {
                  if (catagory.isNotEmpty) catagory.removeLast();
                  if (subcatagory.isNotEmpty) subcatagory.removeLast();
                  if (date.isNotEmpty) date.removeLast();
                  if (month.isNotEmpty) month.removeLast();
                  if (year.isNotEmpty) year.removeLast();
                  context.read<MainBloc>().add(const MainEventFilterNode(null));
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
