import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AlertNotificationWithOptions extends StatefulWidget {
  String title;
  String content;
  String positiveTitle;
  Function positiveFun;

  AlertNotificationWithOptions({
    required this.title,
    required this.content,
    required this.positiveTitle,
    required this.positiveFun,
  });

  @override
  _AlertNotificationWithOptionsState createState() =>
      _AlertNotificationWithOptionsState();
}

class _AlertNotificationWithOptionsState
    extends State<AlertNotificationWithOptions> {
  bool _isIos = false;

  @override
  void initState() {
    _isIos = Platform.isIOS;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isIos
        ? CupertinoAlertDialog(
            title: Text(widget.title),
            content: Text(widget.content),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('Cancel'),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  widget.positiveFun();
                },
                child: Text(widget.positiveTitle),
              ),
            ],
          )
        : AlertDialog(
            title: Text(widget.title),
            content: Text(widget.content),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  widget.positiveFun();
                },
                child: Text(widget.positiveTitle),
              ),
            ],
          );
  }
}
