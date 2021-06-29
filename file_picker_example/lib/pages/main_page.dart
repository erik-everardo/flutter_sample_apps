
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File picker"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(onPressed: () async {

            

            // Asi se obtiene la ruta de un sulo archivo
            FilePickerResult? result = await _pickSingleFile();
            if(result != null) {
              print(result.files.single.path);
              final snackbar = SnackBar(content: Text(result.files.single.path!));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }


          }, child: Text("Escoger solo un archivo")),
          ElevatedButton(onPressed: () async {

            // Aqui se obtienes la rutas
            FilePickerResult? result = await _pickMultipleFiles();
            if(result != null) {
              print(result.paths);
              final snackbar = SnackBar(content: Text("Se escogieron multiples archivos. Ver consola."));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }


          }, child: Text("Escoger multiples archivos"))
        ],
        )
      )
    );
  }


  // File picker permite escoger el archivo, y lo pone en caché, para que la aplicación lo
  // pueda usar. La ruta que regresa es una ruta del sistema de archivos, una parte
  // a la que la aplicación tiene accesso. Esa ruta puede usarse para Firebase Cloud Storage

  // Cuando se tiene un solo archivo, tambien se tiene un array con las rutas, pero este solo tiene un elemento
  // Para acceder a esa ruta, se utilza files.single.path. 
  Future<FilePickerResult?> _pickSingleFile() {
    return FilePicker.platform.pickFiles(type: FileType.image);
  }

  Future<FilePickerResult?> _pickMultipleFiles() {

    // se puede filtrar por tipo o por extensiones. allowMultiple para permitir elegir más de un archivo
    // a la vez. El Future tiene un array llamado "paths", que contiene las rutas de los archivos.
    return FilePicker.platform.pickFiles(type:FileType.custom,allowedExtensions: ['jpg','png'], allowMultiple: true);
  }
}

