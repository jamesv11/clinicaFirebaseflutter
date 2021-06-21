import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parcialclinicafirebase/src/screens/careStaffScreens/registerCareStaffPage.dart';
import 'package:parcialclinicafirebase/src/screens/careStaffScreens/updateCareStaffPage.dart';

class ViewCareStaff extends StatefulWidget {
  ViewCareStaff({Key key, this.tittle}) : super(key: key);
  final String tittle;
  static final String routeName = 'viewCareStaff';

  @override
  _ViewCareStaffState createState() => _ViewCareStaffState();
}

class _ViewCareStaffState extends State<ViewCareStaff> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal de atencion'),
        actions: [
          IconButton(
              tooltip: 'Adicionar Personal de Atención',
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, ResgisterCareStaffPage.routeName);
              })
        ],
      ),
      body: getInfo(context),
    );
  }

  Widget getInfo(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('careStaffs').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());

          case ConnectionState.active:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            // print(snapshot.data);
            return snapshot.data != null
                ? ListCareStaff(careStaffs: snapshot.data.docs)
                : Text('Sin Datos');
          default:
            return Text('Presiona el boton para recargar');
        }
      },
    );
  }
}

class ListCareStaff extends StatelessWidget {
  final List careStaffs;

  const ListCareStaff({Key key, this.careStaffs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: careStaffs == null ? 0 : careStaffs.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => UpdateCareStaff(
                          careStaffs: careStaffs,
                          index: index,
                        )));
          },
          leading: Container(
            padding: EdgeInsets.all(5.0),
            width: 50,
            height: 50,
            child: Image.network(careStaffs[index]['photo']),
          ),
          title: Text(
              "${careStaffs[index]['name']} ${careStaffs[index]['lastName']}"),
          subtitle: Text(careStaffs[index]['job']),
          trailing: Container(
            width: 80,
            height: 40,
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Row(
              children: [
                (careStaffs[index]['turn'])
                    ? Icon(
                        Icons.work_outline_sharp,
                        color: Colors.green,
                      )
                    : Icon(
                        Icons.work_outline_sharp,
                        color: Colors.red,
                      ),
                (careStaffs[index]['state'])
                    ? Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      )
                    : Icon(
                        Icons.dangerous,
                        color: Colors.red,
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}
