import 'package:flutter/material.dart';

Future<T?> messageDialog<T>(BuildContext context, String message,
    {double width = 300, double height = 200}) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 15,
        child: SizedBox(
          width: width,
          height: height,
          child: Center(
            child: ListView(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              shrinkWrap: true,
              children: <Widget>[
                const Center(child: Text('Informasi Data')),
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

Future<T?> redirectDialog<T>(BuildContext context, String message,
    redirectFunction, String redirectTitle,
    {double width = 300, double height = 200}) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 15,
        child: SizedBox(
          width: width,
          height: height,
          child: Center(
            child: ListView(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              shrinkWrap: true,
              children: <Widget>[
                const Center(child: Text('Informasi Data')),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                    )),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    redirectFunction();
                  },
                  child: Text(redirectTitle),
                ),
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
