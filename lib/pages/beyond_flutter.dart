import 'package:flutter/material.dart';

class BeyondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Nothing',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontFamily: "lato",
                      color: Colors.white,
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
