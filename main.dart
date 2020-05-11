import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

void main() => runApp(MaterialApp(title: "camtest",home: camcrop()));

class camcrop extends StatefulWidget{
  @override
  State<camcrop> createState() => _camcropState();
}

class _camcropState extends State<camcrop> {
  File _selectedFile;
  Widget getImageWidget() {
    if (_selectedFile != null) {
      return Image.file(
        _selectedFile,
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset("Images/rushiaprofie.png",
        width: 250,
        height: 250,
        fit: BoxFit.cover,
        color: Colors.blue,
      );
    }
  }

  void getImage(ImageSource source) async{
    File image = await ImagePicker.pickImage(source: source);
    if(image != null){
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(
              ratioX: 1,ratioY: 1),
          compressQuality: 100,
          maxHeight: 800,
          maxWidth:  800,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.deepOrange,
            toolbarTitle: "crop your face",
            statusBarColor: Colors.tealAccent,
            backgroundColor: Colors.white,
          )
      );
      this.setState((){
        _selectedFile = cropped;
      });
    }
  }

  Widget build(BuildContext context) {
    Future _dialogshow() async {
      switch (await showDialog(
          context: context,
          builder: (BuildContext incontext) {
            return SimpleDialog(
              title: Text("Choose input"),
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(incontext, "cam");
                  },
                  child: Text("camera"),
                ),
                SizedBox(height: 20.0,),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(incontext, "gally");
                  },
                  child: Text("device"),
                )
              ],
            );
          }
      )
      ) 
        {
        case "cam":
          {
            getImage(ImageSource.camera);
            break;
          }
        case "no":
          {
            getImage(ImageSource.camera);
            break;
          }
      };
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("everything will be the same"),
        backgroundColor: Colors.amber,
      ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _dialogshow();
          },
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                getImageWidget(),
                SizedBox(height: 48,),
                Center(
                  child: Text("This is image",
                    style: TextStyle(
                      fontSize: 28.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.amber,
          child: Container(
            height: 50.0,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    }
  }
