import 'package:flutter/cupertino.dart';

import 'home/home.dart';

void main() {
  runApp(const NoteMe());
}

class NoteMe extends StatelessWidget {
  const NoteMe({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'NoteMe',
      theme: CupertinoThemeData(
        applyThemeToAll: true,
        primaryColor: Color.fromARGB(255, 253, 200, 52),
      ),
      home: HomeMe(),
    );
  }
}






