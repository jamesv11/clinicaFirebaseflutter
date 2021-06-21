import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parcialclinicafirebase/src/screens/appointmentScreens/registerAppointmentPage.dart';
import 'package:parcialclinicafirebase/src/screens/appointmentScreens/viewAppointmentPage.dart';
import 'package:parcialclinicafirebase/src/screens/bloc/provider.dart';
import 'package:parcialclinicafirebase/src/screens/careStaffScreens/updateCareStaffPage.dart';
import 'package:parcialclinicafirebase/src/screens/careStaffScreens/viewCareStaffPage.dart';
import 'package:parcialclinicafirebase/src/screens/loginPage.dart';
import 'package:parcialclinicafirebase/src/screens/mainPage.dart';
import 'package:parcialclinicafirebase/src/screens/registerAdminPage.dart';
import 'package:parcialclinicafirebase/src/screens/careStaffScreens/registerCareStaffPage.dart';
import 'package:parcialclinicafirebase/src/screens/screenPatient/registerPatientPage.dart';
import 'package:parcialclinicafirebase/src/screens/screenPatient/updatePatientPage.dart';
import 'package:parcialclinicafirebase/src/screens/screenPatient/viewPatientPage.dart';
import 'package:parcialclinicafirebase/src/screens/settingsPage.dart';
import 'package:parcialclinicafirebase/src/screens/userPreference/userPreference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter FireBase',
      initialRoute: LoginPage.routeName,
      routes: {
        MainPage.routeName: (BuildContext context) => MainPage(),
        SettingsPage.routeName: (BuildContext context) => SettingsPage(),
        LoginPage.routeName: (BuildContext context) => LoginPage(),
        RegisterAdminPage.routeName: (BuildContext context) =>
            RegisterAdminPage(),
        ResgisterCareStaffPage.routeName: (BuildContext context) =>
            ResgisterCareStaffPage(),
        ViewCareStaff.routeName: (BuildContext context) => ViewCareStaff(),
        UpdateCareStaff.routeName: (BuildContext context) => UpdateCareStaff(),
        RegisterPatientPage.routeName: (BuildContext context) =>
            RegisterPatientPage(),
        ViewPatientPage.routeName: (BuildContext context) => ViewPatientPage(),
        UpdatePatientPage.routeName: (BuildContext context) =>
            UpdatePatientPage(),
        RegisterAppointmentPage.routeName: (BuildContext context) =>
            RegisterAppointmentPage(),
        ViewAppointmentPage.routeName: (BuildContext context) =>
            ViewAppointmentPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
    ));
  }
}
