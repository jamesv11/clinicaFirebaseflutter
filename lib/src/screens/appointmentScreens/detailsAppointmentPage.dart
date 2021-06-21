import 'package:flutter/material.dart';

class DetailsAppointment extends StatelessWidget {
  final index;
  final List appointments;
  const DetailsAppointment({Key key, this.index, this.appointments})
      : super(key: key);

  static final String routeName = 'appointments';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la cita'),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
            height: 460,
            width: double.maxFinite,
            child: Card(
              elevation: 5,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -50,
                    left: (MediaQuery.of(context).size.width / 2) - 55,
                    child: Container(
                      height: 100,
                      width: 100,
                      //color: Colors.blue,
                      child: Card(
                        elevation: 2,
                        child: Image.network(
                            'https://th.bing.com/th/id/OIP.DzC_Z3rg0hFEeMbDZs_gpwHaHa?pid=ImgDet&rs=1'),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Column(
                            children: [
                              Text(
                                appointments[index]['description'],
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 80,
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text('Paciente',
                                          style: TextStyle(fontSize: 20)),
                                      Text(appointments[index]['patientId'])
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text('Personal',
                                          style: TextStyle(fontSize: 20)),
                                      Text(appointments[index]['careStaffId'])
                                    ],
                                  ),
                                ],
                              ),
                              Divider(),
                              SizedBox(
                                height: 20,
                              ),
                              Text('Fecha Asignada:'),
                              Text(appointments[index]['dateService']),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 20,
                minimumSize: Size(20, 50),
                shape: BeveledRectangleBorder(
                    side: BorderSide(color: Colors.orange, width: 2),
                    borderRadius: BorderRadius.circular(15)),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Regresar'))
        ],
      ),
    );
  }
}
