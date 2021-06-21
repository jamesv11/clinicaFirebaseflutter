import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parcialclinicafirebase/src/screens/helpers/helpHttpAppointment.dart';
import 'package:parcialclinicafirebase/src/screens/screenPatient/viewPatientPage.dart';
import 'package:parcialclinicafirebase/src/screens/utils/utils.dart';

class RegisterAppointmentPage extends StatefulWidget {
  static final String routeName = 'registerAppointment';
  RegisterAppointmentPage({Key key}) : super(key: key);

  @override
  _RegisterAppointmentPageState createState() =>
      _RegisterAppointmentPageState();
}

class _RegisterAppointmentPageState extends State<RegisterAppointmentPage> {
  String _setDate;
  DateTime selectedDate = DateTime.now();

  TextEditingController _dateController = TextEditingController();
  TextEditingController controlState = TextEditingController();
  TextEditingController controlId = TextEditingController();
  TextEditingController controlDescription = TextEditingController();
  TextEditingController controlIdCareStaff = TextEditingController();
  TextEditingController controlIdPatient = TextEditingController();
  List _state = <String>["Activo ", "Inactivo"];

  bool dropdownStateValue;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  @override
  void initState() {
    _dateController.text = DateFormat.yMd().format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RegistrarCita'),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: ListView(
            children: [
              TextField(
                controller: controlId,
                decoration: InputDecoration(labelText: "Codigo"),
              ),
              DropDownField(
                required: true,
                labelText: 'Estado *',
                controller: controlState,
                hintText: "Seleccione...",
                enabled: true,
                items: _state,
                onValueChanged: (value) {
                  setState(() {
                    dropdownStateValue = (value == "Inactivo") ? false : true;
                  });
                },
              ),
              InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: TextFormField(
                  textAlign: TextAlign.center,
                  enabled: false,
                  keyboardType: TextInputType.text,
                  controller: _dateController,
                  onSaved: (String val) {
                    _setDate = val;
                  },
                  decoration: InputDecoration(
                      // disabledBorder:
                      //     UnderlineInputBorder(borderSide: BorderSide.none),
                      labelText: 'Fecha de servicio',
                      contentPadding: EdgeInsets.only(top: 0.0)),
                ),
              ),
              TextField(
                controller: controlDescription,
                decoration: InputDecoration(labelText: "descripción"),
              ),
              TextField(
                controller: controlIdCareStaff,
                decoration:
                    InputDecoration(labelText: "Id personal de atención"),
              ),
              TextField(
                controller: controlIdPatient,
                decoration: InputDecoration(labelText: "Id paciente"),
              ),
              ElevatedButton(
                child: Text("Registar Cita"),
                onPressed: () {
                  var appointment = <String, dynamic>{
                    'id': controlId.text,
                    'appointmentState': dropdownStateValue,
                    'dateService': _dateController.text,
                    'description': controlDescription.text,
                    'careStaffId': controlIdCareStaff.text,
                    'patientId': controlIdPatient.text,
                  };

                  if (controlId.text == '' ||
                      _dateController.text == '' ||
                      dropdownStateValue == null ||
                      controlDescription.text == '' ||
                      controlIdCareStaff.text == '' ||
                      controlIdPatient.text == '') {
                    showAlert(context, 'Por favor, verificar los campos');
                  } else {
                    getInfo();
                    HelpHttpAppointment.createAppointment(appointment);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  getInfo() {
    var stream = FirebaseFirestore.instance.collection('Patients').get();

    print(stream);
  }
}
