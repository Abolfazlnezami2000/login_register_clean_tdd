import 'package:flutter/material.dart';
import 'basic_container.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasicContainer(builder: (context, screenInfo) {
      return Container(
        height: screenInfo.height / 3,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
