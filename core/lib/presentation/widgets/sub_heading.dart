import 'package:core/core.dart';
import 'package:flutter/material.dart';

class SubHeading extends StatelessWidget {
  final String title;
  final Function()? onTap;

  const SubHeading({Key? key, this.onTap, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        Material(
          color: kRichBlack,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
              ),
            ),
          ),
        )
      ],
    );
  }
}
