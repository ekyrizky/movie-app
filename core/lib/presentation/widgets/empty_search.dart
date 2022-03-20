import 'package:core/core.dart';
import 'package:flutter/material.dart';

class EmptyMessage extends StatelessWidget {
  final EmptyState state;

  const EmptyMessage({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 32.0),
      child: Center(
          child: Column(
        children: [
          Image.asset(
            getImageType(state),
            width: 250,
            height: 250,
          ),
          Text(
            getEmptyMessage(state),
            style: kSubtitle,
          ),
        ],
      )),
    );
  }
}
