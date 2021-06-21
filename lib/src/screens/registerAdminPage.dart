import 'package:flutter/material.dart';
import 'package:parcialclinicafirebase/src/screens/bloc/provider.dart';
import 'package:parcialclinicafirebase/src/screens/mainPage.dart';
import 'package:parcialclinicafirebase/src/screens/utils/utils.dart';

import 'helpers/helpUserAuth.dart';
import 'loginPage.dart';

class RegisterAdminPage extends StatelessWidget {
  const RegisterAdminPage({Key key}) : super(key: key);
  static final String routeName = 'registroAdmin';
  static final helpUserAuth = new UserAuth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(63, 63, 156, 1.0),
        Color.fromRGBO(90, 70, 178, 1.0)
      ])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(children: [
      fondoMorado,
      Positioned(top: 90.0, left: 30.0, child: circulo),
      Positioned(top: -40.0, right: -30.0, child: circulo),
      Positioned(bottom: -50.0, right: -10.0, child: circulo),
      Container(
        padding: EdgeInsets.only(top: 80.0),
        child: Column(
          children: [
            Image(image: AssetImage('assets/loginappmovil.png'), height: 100),
            SizedBox(
              height: 10.0,
              width: double.infinity,
            ),
            Text(
              'Clinica Good Doctor',
              style: TextStyle(color: Colors.white, fontSize: 25.0),
            )
          ],
        ),
      )
    ]);
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
        child: Column(
      children: [
        SafeArea(
            child: Container(
          height: 180.0,
        )),
        Container(
          width: size.width * 0.85,
          margin: EdgeInsets.symmetric(vertical: 30.0),
          padding: EdgeInsets.symmetric(vertical: 50.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0)
              ]),
          child: Column(
            children: [
              Text(
                'Crear Cuenta',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(
                height: 60.0,
              ),
              _createEmail(bloc),
              SizedBox(
                height: 30.0,
              ),
              _createPassWord(bloc),
              SizedBox(
                height: 30.0,
              ),
              _createButtom(bloc)
            ],
          ),
        ),
        TextButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, LoginPage.routeName),
            child: Text('¿Ya tienes una cuenta?')),
        SizedBox(height: 100.0)
      ],
    ));
  }

  Widget _createEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.alternate_email,
                  color: Colors.deepOrange,
                ),
                hintText: 'ejemplo@correo.com',
                labelText: 'Correo electronico',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _createPassWord(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passWordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.lock_outline,
                  color: Colors.deepOrange,
                ),
                labelText: 'Contraseña',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _createButtom(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ElevatedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Crear', style: TextStyle(color: Colors.white)),
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 0.0,
          ),
          onPressed: snapshot.hasData ? () => _register(bloc, context) : null,
        );
      },
    );
  }

  _register(LoginBloc bloc, BuildContext context) async {
    final info = await helpUserAuth.newAdmin(bloc.email, bloc.password);
    if (info['ok']) {
      Navigator.pushReplacementNamed(context, MainPage.routeName);
    } else {
      showAlert(context, info['message']);
    }
  }
}
