import 'package:flutter/material.dart';

import 'basic_container.dart';

class MessageDisplay extends StatelessWidget {
  final String message;

  const MessageDisplay({
    Key key,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasicContainer(builder: (context, screenInfo){
      return Container(
        height: screenInfo.height / 3,
        child: Center(
          child: SingleChildScrollView(
            child: Text(
              message,
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
      }     
    );
  }
}
