import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void alertError(BuildContext context, String msg) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert Message'),
          content: Text(msg),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'))
          ],
        );
      });
}

void alertLogin(BuildContext context, String desc) {
  var alertStyle = AlertStyle(
    animationType: AnimationType.fromTop,
    isCloseButton: false,
    isOverlayTapDismiss: true,
    descStyle: const TextStyle(fontWeight: FontWeight.bold),
    descTextAlign: TextAlign.start,
    animationDuration: const Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0.0),
      side: const BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: const TextStyle(
      color: Colors.red,
    ),
    alertAlignment: Alignment.center,
  );
  Alert(
    context: context,
    style: alertStyle,
    type: AlertType.error,
    title: "Login Failed",
    desc: desc,
    buttons: [
      DialogButton(
        onPressed: () => Navigator.pop(context),
        color: const Color.fromRGBO(0, 179, 134, 1.0),
        radius: BorderRadius.circular(0.0),
        child: const Text(
          "Close",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ],
  ).show();
}
