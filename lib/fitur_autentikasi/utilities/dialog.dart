import 'package:flutter/material.dart';

Future<T?> myDialog<T>(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 15,
        child: SizedBox(
          width: 300,
          height: 150,
          child: Center(
            child: ListView(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              shrinkWrap: true,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                    )),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Kembali'),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
