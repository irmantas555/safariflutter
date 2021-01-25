import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safari_one/models/animalhive.dart';
import 'package:safari_one/models/animals.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as p;

class AnimalEditPage extends StatefulWidget {
  int index;
  AnimalHive animalHive;

  AnimalEditPage({Key key}) : super(key: key);

  AnimalEditPage.forEdit({Key key})
      : index = int.parse(Get.parameters['value']),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimalEditState();
}

class _AnimalEditState extends State<AnimalEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name = "";
  String nameRu = "";
  String nameEn = "";
  String imagePath = "";
  String description = "";
  String descriptionEn = "";
  String descriptionRu = "";
  String audioPath = "";
  String audioPathEn = "";
  String audioPathRu = "";
  final picker = ImagePicker();

  @override
  void initState() {
    if (null != widget.index) {
      widget.animalHive = AnimalsGetter().animallist[widget.index];
      name = widget.animalHive.name;
      nameRu = widget.animalHive.nameRu;
      nameEn = widget.animalHive.nameEn;
      imagePath = widget.animalHive.imagePath;
      description = widget.animalHive.description;
      descriptionRu = widget.animalHive.descriptionRu;
      descriptionEn = widget.animalHive.descriptionEn;
      audioPathEn = widget.animalHive.audioPath;
      audioPathEn = widget.animalHive.audioPathRu;
      audioPathEn = widget.animalHive.audioPathEn;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                children: [
                  _myLabel("Pavadinimas:"),
                  _nameField(),
                  _myLabel("Pavadinimas Ru:"),
                  _nameFieldRu(),
                  _myLabel("Pavadinimas En:"),
                  _nameFieldEn(),
                  _myLabel("Paveiksliukas:"),
                  _pictureField(),
                  _myLabel("Aprašas:"),
                  _descriptionField(),
                  _myLabel("Aprašas Ru:"),
                  _descriptionFieldRu(),
                  _myLabel("Aprašas En:"),
                  _descriptionFieldEn(),
                  _myLabel("Audio aprašas:"),
                  _audioField(),
                  _myLabel("Audio aprašas Ru:"),
                  _audioFieldRu(),
                  _myLabel("Audio aprašas En:"),
                  _audioFieldEn(),
                  _subbmitButton(),
                ],
              )),
        ),
      ),
    );
  }

  _onSubmit() {
    _formKey.currentState.save();
    AnimalHive animal = AnimalHive(name, nameRu, nameEn, imagePath, description,
        descriptionRu, descriptionEn, audioPath, audioPathRu, audioPathEn);
    // print(animal);
    if (null != widget.index) {
      setState(() {
        AnimalsGetter().updateAnimal(animal, widget.index);
      });
      // print("Updated entry: " + animal.toString());
    } else {
      setState(() {
        widget.index = AnimalsGetter().add(animal);
      });
      // print("New entry: " + animal.toString());
    }
  }

  Widget _nameField() {
    return TextFormField(
      initialValue: name,
      decoration: const InputDecoration(hintText: "Žvėries pavadinimas"),
      onChanged: (String value) {
        setState(() {
          name = value;
        });
      },
    );
  }

  Widget _nameFieldRu() {
    return TextFormField(
      initialValue: nameRu,
      decoration: const InputDecoration(hintText: "Žvėries pavadinimas"),
      onSaved: (String value) {
        setState(() {
          nameRu = value;
        });
      },
    );
  }

  Widget _nameFieldEn() {
    return TextFormField(
      initialValue: nameEn,
      decoration: const InputDecoration(hintText: "Žvėries pavadinimas"),
      onSaved: (String value) {
        setState(() {
          nameEn = value;
        });
      },
    );
  }

  Widget _descriptionField() {
    return TextFormField(
      initialValue: description,
      minLines: 3,
      maxLines: 20,
      decoration: const InputDecoration(hintText: "Žvėries pavadinimas"),
      onSaved: (String value) {
        setState(() {
          description = value;
        });
      },
    );
  }

  Widget _descriptionFieldRu() {
    return TextFormField(
      initialValue: descriptionRu,
      minLines: 3,
      maxLines: 20,
      decoration: const InputDecoration(hintText: "Žvėries pavadinimas"),
      onSaved: (String value) {
        setState(() {
          descriptionRu = value;
        });
      },
    );
  }

  Widget _descriptionFieldEn() {
    return TextFormField(
      initialValue: description,
      minLines: 3,
      maxLines: 20,
      decoration: const InputDecoration(hintText: "Žvėries pavadinimas"),
      onSaved: (String value) {
        setState(() {
          descriptionEn = value;
        });
      },
    );
  }

  Widget _pictureField() {
    return Row(
      children: [
        Text(imagePath),
        IconButton(
          icon: Icon(Icons.folder_open_outlined),
          onPressed: () {
            getPictureFile();
          },
        )
      ],
    );
  }

  Widget _audioField() {
    return Row(
      children: [
        Text(audioPath),
        IconButton(
          icon: Icon(Icons.folder_open_outlined),
          onPressed: () {
            getPictureFile();
          },
        )
      ],
    );
  }

  Widget _audioFieldRu() {
    return Row(
      children: [
        Text(audioPath),
        IconButton(
          icon: Icon(Icons.folder_open_outlined),
          onPressed: () {
            getPictureFile();
          },
        )
      ],
    );
  }

  Widget _audioFieldEn() {
    return Row(
      children: [
        Text(audioPath),
        IconButton(
          icon: Icon(Icons.folder_open_outlined),
          onPressed: () {
            getPictureFile();
          },
        )
      ],
    );
  }

  void getPictureFile() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (null != pickedFile) {
      final appDir = await path_provider.getApplicationDocumentsDirectory();
      // print("path: " + appDir.path);
      final fileName = p.basename(pickedFile.path);
      // print("file: " + fileName);
      File sourceFile = File(pickedFile.path);
      File newFile = File(appDir.path + "/" + fileName);
      File written = await moveFile(sourceFile, appDir.path + "/" + fileName);
      imagePath = written.path;
    }
  }

  Future<File> moveFile(File sourceFile, String newPath) async {
    try {
      /// prefer using rename as it is probably faster
      /// if same directory path
      return await sourceFile.rename(newPath);
    } catch (e) {
      /// if rename fails, copy the source file
      final newFile = await sourceFile.copy(newPath);
      return newFile;
    }
  }

  // void getAudioFile() async {
  //   FilePickerResult result = await FilePicker.platform
  //       .pickFiles(type: FileType.audio, allowMultiple: false, withReadStream: true);
  //   if (null != result) {
  //     final appDir = await path_provider.getApplicationDocumentsDirectory();
  //     final fileName = result.files.single.name;
  //     File newFile = File(appDir.toString() +  "/" + fileName);
  //       audioPath = await _localFile(result.files.first, newFile);
  //   }
  // }
  //
  // Future<String> _localFile(PlatformFile file, File newfile) async {
  //   try {
  //     File newFile = await newfile.writeAsBytes(file.bytes);
  //     return newFile.path;
  //   } catch (e){
  //     print(e);
  //     return Future.error(e);
  //   }
  //
  // }

  Widget _myLabel(String s) {
    return Text(
      s,
      style: TextStyle(
        fontSize: 20,
        fontFamily: "nunitor",
        fontWeight: FontWeight.bold,
        color: Colors.deepOrange,
      ),
    );
  }

  Widget _subbmitButton() {
    return Center(
        child: FlatButton(onPressed: _onSubmit, child: _myLabel("Įvęsti")));
  }
}
