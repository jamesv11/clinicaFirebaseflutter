import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parcialclinicafirebase/src/screens/screenPatient/registerPatientPage.dart';
import 'package:parcialclinicafirebase/src/screens/screenPatient/updatePatientPage.dart';

class ViewPatientPage extends StatefulWidget {
  ViewPatientPage({Key key, this.tittle}) : super(key: key);
  final String tittle;
  static final String routeName = 'viewPatient';

  @override
  _ViewPatientPageState createState() => _ViewPatientPageState();
}

class _ViewPatientPageState extends State<ViewPatientPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pacientes'),
        actions: [
          IconButton(
              tooltip: 'Adicionar Pacientes',
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, RegisterPatientPage.routeName);
              })
        ],
      ),
      body: getInfo(context),
    );
  }

  Widget getInfo(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('patients').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());

          case ConnectionState.active:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            // print(snapshot.data);
            return snapshot.data != null
                ? ListPatient(patients: snapshot.data.docs)
                : Text('Sin Datos');
          default:
            return Text('Presiona el boton para recargar');
        }
      },
    );
  }
}

class ListPatient extends StatelessWidget {
  final List patients;

  const ListPatient({Key key, this.patients}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: patients == null ? 0 : patients.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => UpdatePatientPage(
                  patients: patients,
                  index: index,
                ),
              ),
            );
          },
          leading: Container(
            padding: EdgeInsets.all(5.0),
            width: 50,
            height: 50,
            child: Image.network(patients[index]['photo']),
          ),
          title:
              Text("${patients[index]['name']} ${patients[index]['lastName']}"),
          subtitle: Text(patients[index]['phoneNumber']),
          trailing: Container(
              width: 80,
              height: 40,
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: (patients[index]['state'])
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
