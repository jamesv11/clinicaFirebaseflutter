import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:parcialclinicafirebase/src/screens/helpers/helpHttpCareStaff.dart';
import 'package:parcialclinicafirebase/src/screens/utils/utils.dart';

class UpdateCareStaff extends StatefulWidget {
  final index;
  final List careStaffs;
  const UpdateCareStaff({Key key, this.index, this.careStaffs})
      : super(key: key);
  static final String routeName = 'updateCareStaff';

  @override
  _UpdateCareStaffState createState() => _UpdateCareStaffState();
}

class _UpdateCareStaffState extends State<UpdateCareStaff> {
  TextEditingController controlEmail = TextEditingController();
  TextEditingController controlId = TextEditingController();
  TextEditingController controlPhoto = TextEditingController();
  TextEditingController controlName = TextEditingController();
  TextEditingController controlLastName = TextEditingController();
  TextEditingController controlJob = TextEditingController();
  TextEditingController controlState = TextEditingController();
  TextEditingController controlTurn = TextEditingController();
  TextEditingController controlPassword = TextEditingController();

  List _jobs = <String>["Medico", "Enfermero(a)", "Fisioterapeuta"];
  List _state = <String>["Activo ", "Inactivo"];
  List _turn = <String>["En servicio ", "Libre"];

  String dropdownJobValue = '';
  bool dropdownStateValue;
  bool dropdownTurnValue;

  @override
  void initState() {
    controlEmail =
        TextEditingController(text: widget.careStaffs[widget.index]['email']);
    controlId =
        TextEditingController(text: widget.careStaffs[widget.index]['id']);
    controlPhoto =
        TextEditingController(text: widget.careStaffs[widget.index]['photo']);
    controlName =
        TextEditingController(text: widget.careStaffs[widget.index]['name']);
    controlLastName = TextEditingController(
        text: widget.careStaffs[widget.index]['lastName']);
    controlPassword = TextEditingController(
        text: widget.careStaffs[widget.index]['password']);
    controlJob =
        TextEditingController(text: widget.careStaffs[widget.index]['job']);
    controlState = TextEditingController(
        text:
            (widget.careStaffs[widget.index]['state']) ? 'Activo' : 'Inactivo');
    controlTurn = TextEditingController(
        text: (widget.careStaffs[widget.index]['turn'])
            ? 'En servicio'
            : "Libre");
    dropdownJobValue = widget.careStaffs[widget.index]['job'];
    dropdownStateValue = widget.careStaffs[widget.index]['state'];
    dropdownTurnValue = widget.careStaffs[widget.index]['turn'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar personal de atención'),
        actions: [
          IconButton(
              tooltip: 'Eliminar personal de atención',
              icon: Icon(Icons.delete),
              onPressed: () {
                HelpHttpCareStaff.deleteCareStaff(
                    widget.careStaffs[widget.index].id);

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
                controller: controlEmail,
                decoration: InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: controlId,
                decoration: InputDecoration(labelText: "Identificacion"),
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
              SizedBox(height: 16.0),
              DropDownField(
                labelText: 'Cargo *',
                controller: controlJob,
                hintText: "Seleccione...",
                enabled: true,
                items: _jobs,
                onValueChanged: (value) {
                  setState(() {
                    dropdownJobValue = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Divider(height: 10.0, color: Colors.black),
              DropDownField(
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
              SizedBox(height: 16.0),
              Divider(height: 10.0, color: Colors.black),
              DropDownField(
                labelText: 'Turno *',
                controller: controlTurn,
                hintText: "Seleccione...",
                enabled: true,
                items: _turn,
                onValueChanged: (value) {
                  setState(() {
                    dropdownTurnValue = (value == "Libre") ? false : true;
                  });
                },
              ),
              Divider(height: 10.0, color: Colors.black),
              TextField(
                controller: controlPassword,
                decoration: InputDecoration(labelText: "Password"),
              ),
              ElevatedButton(
                child: Text("Actualizar Personal de Atención"),
                onPressed: () {
                  var careStaff = <String, dynamic>{
                    'email': controlEmail.text,
                    'id': controlId.text,
                    'photo': controlPhoto.text,
                    'name': controlName.text,
                    'lastName': controlLastName.text,
                    'job': controlJob.text,
                    'state': dropdownStateValue,
                    'turn': dropdownTurnValue,
                    'password': controlPassword.text,
                  };

                  if (validateEmail(controlEmail.text) ||
                      controlId.text == '' ||
                      controlPhoto.text == '' ||
                      controlName.text == '' ||
                      controlLastName.text == '' ||
                      controlJob.text == '' ||
                      dropdownStateValue == null ||
                      dropdownTurnValue == null ||
                      controlPassword.text == '') {
                    showAlert(context, 'Por favor, verificar los campos');
                  } else {
                    HelpHttpCareStaff.updateCareStaff(
                        widget.careStaffs[widget.index].id, careStaff);
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
}
