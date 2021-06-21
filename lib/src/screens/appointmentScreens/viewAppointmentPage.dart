import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parcialclinicafirebase/src/screens/appointmentScreens/registerAppointmentPage.dart';

import 'detailsAppointmentPage.dart';

class ViewAppointmentPage extends StatefulWidget {
  ViewAppointmentPage({Key key, this.tittle}) : super(key: key);
  final String tittle;
  static final String routeName = 'viewAppointment';

  @override
  _ViewAppointmentPageState createState() => _ViewAppointmentPageState();
}

class _ViewAppointmentPageState extends State<ViewAppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cita'),
        actions: [
          IconButton(
              tooltip: 'Cita',
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, RegisterAppointmentPage.routeName);
              })
        ],
      ),
      body: getInfo(context),
    );
  }

  Widget getInfo(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Appointments').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());

          case ConnectionState.active:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            // print(snapshot.data);
            return snapshot.data != null
                ? ListAppointment(appointments: snapshot.data.docs)
                : Text('Sin Datos');
          default:
            return Text('Presiona el boton para recargar');
        }
      },
    );
  }
}

class ListAppointment extends StatelessWidget {
  final List appointments;

  const ListAppointment({Key key, this.appointments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: appointments == null ? 0 : appointments.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => DetailsAppointment(
                  appointments: appointments,
                  index: index,
                ),
              ),
            );
          },
          leading: Container(
            padding: EdgeInsets.all(5.0),
            width: 50,
            height: 50,
            child: Text("${appointments[index]['id']}"),
          ),
          title: Text("${appointments[index]['description']}"),
          subtitle: Text(appointments[index]['dateService']),
          trailing: Container(
              width: 80,
              height: 40,
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: (appointments[index]['appointmentState'])
                  ? Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    )
                  : Icon(
                      Icons.dangerous,
                      color: Colors.red,
                    )),
        );
      },
    );
  }
}
