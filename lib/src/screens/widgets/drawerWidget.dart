import 'package:flutter/material.dart';
import 'package:parcialclinicafirebase/src/screens/appointmentScreens/registerAppointmentPage.dart';
import 'package:parcialclinicafirebase/src/screens/appointmentScreens/viewAppointmentPage.dart';
import 'package:parcialclinicafirebase/src/screens/bloc/provider.dart';
import 'package:parcialclinicafirebase/src/screens/careStaffScreens/viewCareStaffPage.dart';
import 'package:parcialclinicafirebase/src/screens/screenPatient/registerPatientPage.dart';
import 'package:parcialclinicafirebase/src/screens/screenPatient/viewPatientPage.dart';
import 'package:parcialclinicafirebase/src/screens/settingsPage.dart';

import '../careStaffScreens/registerCareStaffPage.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 40.0),
              child: ListTile(
                leading: Icon(Icons.account_circle, size: 40.0),
                title: Text(
                  '${bloc.email}',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/backgroundDrawer.jpg'),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {},
          ),
          Divider(),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Crear',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.add_box_outlined,
            ),
            title: Text('Pacientes'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, RegisterPatientPage.routeName);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.add_box_outlined,
            ),
            title: Text('Personal de atencion'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, ResgisterCareStaffPage.routeName);
            },
          ),
          Divider(),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Agendar',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.article_outlined,
            ),
            title: Text('Citas'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, RegisterAppointmentPage.routeName);
            },
          ),
          Divider(),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Consultas',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.view_list,
            ),
            title: Text('Pacientes Asignados'),
            onTap: () {
              Navigator.pushNamed(context, ViewPatientPage.routeName);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.view_list,
            ),
            title: Text('Personal de Atencion'),
            onTap: () {
              Navigator.pushNamed(context, ViewCareStaff.routeName);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.view_list,
            ),
            title: Text('Citas'),
            onTap: () {
              Navigator.pushNamed(context, ViewAppointmentPage.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Ajustes'),
            onTap: () {
              Navigator.pushNamed(context, SettingsPage.routeName);
            },
          )
        ],
      ),
    );
  }
}
