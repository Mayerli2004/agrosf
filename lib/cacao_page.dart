import 'package:flutter/material.dart';
import 'package:agrosf/database_helper.dart';
import 'package:image_picker/image_picker.dart';




class CacaoPage extends StatefulWidget {
  @override
  _CacaoPageState createState() => _CacaoPageState();
}

class _CacaoPageState extends State<CacaoPage> {
  final TextEditingController _agrosfNameController = TextEditingController();
  final TextEditingController _agrosfPriceController = TextEditingController();
  XFile? _selectedImage; // Declaración de la variable para la imagen seleccionada

   Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery); // Puedes cambiar a ImageSource.camera si lo deseas
    if (pickedImage != null) {
      setState(() {
        _selectedImage = pickedImage;
      });
    }
  }

  void _addAgrosf() async{
    final agrosfName = _agrosfNameController.text;
    final agrosfPrice = double.tryParse(_agrosfPriceController.text) ?? 0.0;
     final imagePath = _selectedImage?.path ?? '';

      if (agrosfName.isNotEmpty && agrosfPrice > 0) {
    final newAgrosf = Agrosf(id: 0, name: agrosfName, price: agrosfPrice, imagePath: imagePath);
      
    try {
      await DatabaseProvider.instance.insertAgrosf(newAgrosf); 
      // Aquí puedes realizar cualquier acción que necesites después de la inserción
      // Por ejemplo, redirigir a una nueva pantalla o actualizar la lista de animales
    } catch(error) {
      // Manejo de errores si la inserción falla
      print('Error al insertar el agros: $error');
    }
  }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agregar agros cacao')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _agrosfNameController,
              decoration: InputDecoration(labelText: 'Nombre del agros'),
            ),
            TextField(
              controller: _agrosfPriceController,
              decoration: InputDecoration(labelText: 'Precio del agros'),
              keyboardType: TextInputType.number,
            ),
            // TODO: Agregar campos para manejar imágenes
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addAgrosf,
              child: Text('Agregar Agros'),
            ),
          ],
        ),
      ),
    );
  }
}
