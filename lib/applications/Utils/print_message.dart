import 'package:flutter/material.dart';

/// This class is part of the other_pages package,
/// which indicates other "external" pages that allow you to
/// better divide the Project code.
/// This page provides an implementation to show any error
/// messages or text correctness messages when the user
/// goes to perform an action.
class PrintStatus {
  /// Method that , if called, brings up an error
  /// box (Color red) with a text message indicating
  /// an error.
  void printError(BuildContext context, String textMessage) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.all(16),
          height: 70,
          decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Text(textMessage),
        ),
      ));

  /// Method that, if called, brings up a correctness
  /// box or provides the user with a message.
  void printCorrect(BuildContext context, String textMessage) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.all(16),
          height: 70,
          decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Text(textMessage),
        ),
      ));
}
