import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parcialclinicafirebase/src/screens/helpers/helpHttpPatient.dart';
import 'package:parcialclinicafirebase/src/screens/utils/utils.dart';

class UpdatePatientPage extends StatefulWidget {
  static final String routeName = 'updatePatient';
  final index;
  final List patients;
  UpdatePatientPage({Key key, this.index, this.patients}) : super(key: key);

  @override
  _UpdatePatientPageState createState() => _UpdatePatientPageState();
}

class _UpdatePatientPageState extends State<UpdatePatientPage> {
  String _setDate;
  DateTime selectedDate = DateTime.now();

  TextEditingController _dateController = TextEditingController();
  TextEditingController controlId = TextEditingController();
  TextEditingController controlEmail = TextEditingController();
  TextEditingController controlPhoto = TextEditingController();
  TextEditingController controlName = TextEditingController();
  TextEditingController controlLastName = TextEditingController();
  TextEditingController controlAge = TextEditingController();
  TextEditingController controlAddress = TextEditingController();
  TextEditingController controlNeighborhood = TextEditingController();
  TextEditingController controlPhoneNumber = TextEditingController();
  TextEditingController controlCity = TextEditingController();
  TextEditingController controlState = TextEditingController();

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
    _dateController =
        TextEditingController(text: widget.patients[widget.index]['birthdate']);
    controlId =
        TextEditingController(text: widget.patients[widget.index]['id']);
    controlEmail =
        TextEditingController(text: widget.patients[widget.index]['email']);
    controlPhoto =
        TextEditingController(text: widget.patients[widget.index]['photo']);
    controlName =
        TextEditingController(text: widget.patients[widget.index]['name']);
    controlLastName =
        TextEditingController(text: widget.patients[widget.index]['lastName']);
    controlAge =
        TextEditingController(text: widget.patients[widget.index]['age']);
    controlAddress =
        TextEditingController(text: widget.patients[widget.index]['address']);
    controlNeighborhood = TextEditingController(
        text: widget.patients[widget.index]['neighborhood']);
    controlPhoneNumber = TextEditingController(
        text: widget.patients[widget.index]['phoneNumber']);
    controlCity =
        TextEditingController(text: widget.patients[widget.index]['city']);
    controlState = TextEditingController(
        text: (widget.patients[widget.index]['state']) ? 'Activo' : 'Inactivo');
    _dateController.text = DateFormat.yMd().format(DateTime.now());
    dropdownStateValue = widget.patients[widget.index]['state'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar paciente'),
        actions: [
          IconButton(
              tooltip: 'Eliminar personal de atención',
              icon: Icon(Icons.delete),
              onPressed: () {
                HelpHttpPatient.deletePatient(widget.patients[widget.index].id);

                Navigator.pop(context);
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: ListView(
            children: [
              TextField(
                controller: controlId,
                decoration: InputDecoration(labelText: "Identificación"),
              ),
              TextField(
                controller: controlEmail,
                decoration: InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: controlPhoto,
                decoration: InputDecoration(labelText: "Foto"),
              ),
              TextField(
                controller: controlName,
                decoration: InputDecoration(labelText: "Nombre"),
              ),
              TextField(
                controller: controlLastName,
                decoration: InputDecoration(labelText: "Apellido"),
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
                      labelText: 'Fecha de nacimiento',
                      contentPadding: EdgeInsets.only(top: 0.0)),
                ),
              ),
              TextField(
                controller: controlAddress,
                decoration: InputDecoration(labelText: "Dirección"),
              ),
              TextField(
                controller: controlNeighborhood,
                decoration: InputDecoration(labelText: "Barrio"),
              ),
              TextField(
                controller: controlPhoneNumber,
                decoration: InputDecoration(labelText: "Numero de telefono"),
              ),
              TextField(
                controller: controlCity,
                decoration: InputDecoration(labelText: "Ciudad"),
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
              ElevatedButton(
                child: Text("Actualizar Paciente"),
                onPressed: () {
                  calcularEdad();
                  var patient = <String, dynamic>{
                    'birthdate': _dateController.text,
                    'id': controlId.text,
                    'email': controlEmail.text,
                    'photo': controlPhoto.text,
                    'name': controlName.text,
                    'lastName': controlLastName.text,
                    'age': controlAge.text,
                    'address': controlAddress.text,
                    'neighborhood': controlNeighborhood.text,
                    'phoneNumber': controlPhoneNumber.text,
                    'city': controlCity.text,
                    'state': dropdownStateValue,
                  };

                  if (validateEmail(controlEmail.text) ||
                      controlId.text == '' ||
                      controlPhoto.text == '' ||
                      controlName.text == '' ||
                      controlLastName.text == '' ||
                      _dateController.text == '' ||
                      dropdownStateValue == null ||
                      controlAddress.text == '' ||
                      controlNeighborhood.text == '' ||
                      controlPhoneNumber.text == '' ||
                      controlCity.text == '') {
                    showAlert(context, 'Por favor, verificar los campos');
                  } else {
                    HelpHttpPatient.updatePatient(
                        widget.patients[widget.index].id, patient);
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

  bool validateEmail(email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(email)) {
      return false;
    } else {
      return true;
    }
  }

  calcularEdad() {
    controlAge = TextEditingController(text: selectedDate.year.toString());
  }
}
