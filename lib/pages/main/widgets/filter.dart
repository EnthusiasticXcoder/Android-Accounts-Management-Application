import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/services/services.dart';

class Filter extends StatelessWidget {
  final VoidCallback onTap;
  final FilterBy filter;

  const Filter({
    super.key,
    required this.onTap,
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
        width: MediaQuery.of(context).size.width * 0.5,
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
                  if (filter.catagory != null) text.add(' Catagory');
                  if (filter.subcatagory != null) text.add(' Subcatagory');
                  if (filter.month != null) text.add('Date');
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
                  filter.setNull();
                  context.read<MainBloc>().add(
                        MainEventFilterNode(filter),
                      );
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
