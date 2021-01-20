import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safari_one/models/animalhive.dart';
import 'package:safari_one/models/animals.dart';

class AnimalEditPage extends StatefulWidget {
  int index;
  AnimalHive animalHive;

  AnimalEditPage({Key key}) : super(key: key);

  AnimalEditPage.forEdit(this.index, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimalEditState();
}

class _AnimalEditState extends State<AnimalEditPage> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  String imagePath = "";
  String description = "";
  String audioPath = "";

  @override
  void initState() {
    if (null != widget.index) {
      widget.animalHive =
          AnimalHive.clone(AnimalsProvider().animalList[widget.index]);
      name = widget.animalHive.name;
      imagePath = widget.animalHive.imagePath;
      description = widget.animalHive.description;
      audioPath = widget.animalHive.audioPath;
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
                  _myLabel("Paveiksliukas:"),
                  _pictureField(),
                  _myLabel("Aprašas:"),
                  _descriptionField(),
                  _myLabel("Audio aprašas:"),
                  _audioField(),
                  _subbmitButton(),
                ],
              )),
        ),
      ),
    );
  }

  _onSubmit() {
    _formKey.currentState.save();
    AnimalHive animal = AnimalHive(name, imagePath, description, audioPath);
    if (null != widget.index) {
      setState(() {
        AnimalsProvider().update(animal, widget.index);
      });
      print("Updated entry: " + animal.toString());
    } else {
      setState(() {
        widget.index = AnimalsProvider().add(animal);
      });
      print("New entry: " + animal.toString());
    }
  }

  Widget _nameField() {
    return TextFormField(
      initialValue: name,
      decoration: const InputDecoration(hintText: "Žvėries pavadinimas"),
      onSaved: (String value) {
        name = value;
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
        description = value;
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

  void getPictureFile() async {
    FilePickerResult result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (null != result) {
      imagePath = result.files.single.path;
    }
  }

  void getAudioFile() async {
    FilePickerResult result = await FilePicker.platform
        .pickFiles(type: FileType.audio, allowMultiple: false);
    if (null != result) {
      audioPath = result.files.single.path;
    }
  }

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
