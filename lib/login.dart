import 'package:agrosf/database_helper.dart';
import 'package:agrosf/registro.dart';
import 'package:flutter/material.dart';
import 'aguacate_page.dart';
import 'cacao_page.dart';
import 'piña_page.dart';
import 'guayaba_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _profileController = TextEditingController();
  
  String _errorMessage = '';

  void _login() async {
    final username = _usernameController.text; // 0 'bovinos2' 0 'acuicola3' 0  'porcinos4'
    final password = _passwordController.text; // 0 'bovinos123' 0 'acuicola123' 0  'porcinos123'
    final profile = _profileController.text; // 0 'bovinos' 0 'acuicola' 0  'porcinos'

    final db = await DatabaseProvider.instance.database;
    final result = await db.query(
      'users',
      where: 'username = ? AND password = ?',// verificar para cada tipo de usuario
      whereArgs: [username, password,profile,],
    );

    if (result.isNotEmpty) {
      final userProfile = result[0]['profile'];
      // Verifica el perfil del usuario y redirige a la página correspondiente
   
      //ovinos 
switch (userProfile) {
  case 'Aguacate':
    print("Navigating to AguacatePage");
   Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => AguacatePage()),
);
    break;
  case 'piña':
    print("Navigating to PiñaPage");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PinaPage()),
    );
    break;
   case 'cacao':
    print("Navigating to CacaoPage");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CacaoPage()),
    );
    break;

    case 'guayaba':
    print("Navigating to guayabaPage");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GuayabaPage()),
    );
    break;  
  // ... Repeat for other cases
  default:
    print("Unrecognized profile");
    setState(() {
      _errorMessage = 'Perfil no reconocido';
    });
    break;
}

   } else {
      setState(() {
        _errorMessage = 'Credenciales incorrectas';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inicio de Sesión Agro')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/imagen/agro.png',
                width: 250, //ajusta el tamaño de la imagen  segun tus necesidades
              ),
              SizedBox(height: 20,),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Nombre de Usuario'),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _login,
                child: Text('Iniciar Sesión'),
              ),
              SizedBox(height: 8.0),
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(height: 30.0),
              Container(
                width: double.infinity,
                child: RawMaterialButton(
                  fillColor: Color.fromARGB(171, 26, 16, 141),
                  elevation: 0.0,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => RegisterPage()));
                  },
                  child: const Text(
                    "Registrarse",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}