import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

showPermissionDialog(
    {required BuildContext context,
    String? subject,
    String? message,
    Function? request}) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      //Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Grant Permission"),
    onPressed: () async {
      request;
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(subject!),
    content: Text(message!),
    actions: [
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
