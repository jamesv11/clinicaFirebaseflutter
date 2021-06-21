import 'package:flutter/material.dart';
import 'package:parcialclinicafirebase/src/screens/widgets/drawerWidget.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);
  static final String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Clinica good doctor'),
        ),
        drawer: DrawerWidget(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User'),
            Divider(),
            Text('Info'),
            Divider(),
          ],
        ));
  }
}
