import 'package:flutter/material.dart';
import 'dart:ui' as ui;

Future<String?> showCustomDialogToSelectString(
    BuildContext context, List<String> options) async {
  return await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog.adaptive(
        title: const Text('Select'),
        content: SizedBox(
          height: MediaQuery.sizeOf(context).height / 2,
          child: SingleChildScrollView(
            child: ListBody(
              children: options.map((element) {
                return Card(
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: Text(
                      element,
                      textDirection: ui.TextDirection.rtl,
                    ),
                    onTap: () {
                      Navigator.of(context).pop(element);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      );
    },
  );
}
