import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_agora/FirstScreen/textFieldModel.dart';
import 'package:flutter_app_agora/Model/ModelBroadcast.dart';
import 'package:flutter_app_agora/Style/colorStyle.dart';
import 'package:flutter_app_agora/services/jsonApiBroadcast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:progress_dialog/progress_dialog.dart';

class NewBradcast extends StatefulWidget {
  ModelBroadCast modelBroadCast;
  NewBradcast(this.modelBroadCast);
  @override
  _NewBradcastState createState() => _NewBradcastState();
}

class _NewBradcastState extends State<NewBradcast> {

  TextEditingController dateEvent = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController collaboration = TextEditingController();

  final format = DateFormat("yyyy-MM-dd HH:mm");
  bool check = false;


  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateEvent.text = 'Date Broadcast';
    if (widget.modelBroadCast != null) {
      title.text = widget.modelBroadCast.title;
      description.text = widget.modelBroadCast.description;
      dateEvent.text = widget.modelBroadCast.date.toString();
      check = widget.modelBroadCast.recorded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back, color: AppColors.colorPrincipal1, size: 35,),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: widget.modelBroadCast == null ? Text('Add New Broadcast',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.indigo),
        ) : Text('Update Broadcast',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.indigo),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.only(right: 25, left: 25),
                child: InkWell(
                  onTap: getImage,
                  child: Container(
//                    color: Colors.red,
                      height: 180,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: widget.modelBroadCast != null ?
                      (
                          widget.modelBroadCast.photo == '' ?
                          (
                              _image == null ?
                              (
                                  Icon(Icons.add_photo_alternate, size: 180,
                                      color: AppColors.colorPrincipal1)
                              )
                                  :
                              (
                                  Image.file(_image)
                              )
                          )
                              :
                          (
                              _image == null ?
                              (
                                  CachedNetworkImage(
                                    imageUrl: "https://bakarbakar.herokuapp.com/images/${widget
                                        .modelBroadCast.photo}",
                                    placeholder: (context, url) =>
                                        Center(child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  )
                              )
                                  :
                              (
                                  Image.file(_image)
                              )
                          )
                      )
                          :
                      (
                          _image == null ?
                          (
                              Icon(Icons.add_photo_alternate, size: 180,
                                  color: AppColors.colorPrincipal1)
                          )
                              :
                          (
                              Image.file(_image)
                          )
                      )
                  ),
                ),
              ),
              SizedBox(height: 25,),
              txtEdForm(title, 'title', null, TextInputType.text, false),
              SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.only(right: 25, left: 25),
                child: TextField(
                  controller: description,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  decoration: InputDecoration(
                      hintText: 'description'
                  ),
                ),
              ),
              SizedBox(height: 25,),
              txtEdForm(
                  collaboration, 'collaboration', null, TextInputType.text,
                  false),
              SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.only(right: 25, left: 25),
                child: DateTimeField(
                  format: format,
                  onShowPicker: (context, currentValue) async {
                    final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        initialDate: DateTime.now(),
                        lastDate: DateTime.now().add(new Duration(days: 365))
                    );
                    if (date != null) {
                      final time = await showTimePicker(
                        context: context,
                        initialTime:
                        TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.combine(date, time);
                    } else {
                      return currentValue;
                    }
                  },
                  controller: dateEvent,
                ),
              ),
              SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.only(right: 25, left: 25),
                child: Row(
                  children: <Widget>[
                    Text('Record Broadcast :', style: TextStyle(
                        color: AppColors.colorPrincipal1,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),),
                    Checkbox(
                      value: check,
                      activeColor: AppColors.colorPrincipal1,
                      onChanged: (v) {
                        setState(() {
                          check = v;
                        });
                      },
                    )
                  ],
                ),
              ),
              SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.only(right: 25, left: 25),
                child: GestureDetector(
                    onTap: () {
                      if (widget.modelBroadCast == null)
                        addBroad();
                      else
                        updateBroad();
                    },
                    child: buttonForm(context,
                        widget.modelBroadCast == null ? 'Add' : 'Update')
                ),
              ),
              SizedBox(height: 25,),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addBroad() async {
    if (title.text.isNotEmpty && description.text.isNotEmpty &&
        dateEvent.text.isNotEmpty) {
      if (dateEvent.text != 'Date Broadcast') {
        DateTime datetime = DateTime.parse(dateEvent.text);
        ModelBroadCast modelBroadCast = ModelBroadCast(
          title: title.text,
          description: description.text,
          date: datetime,
          recorded: check,
          //collaboration: collaboration.toString(),
          image: _image,
        );
        ProgressDialog pr = prDialog(context);
        pr.show();
        String r = await JsonApiBrodCast.createBroadCast(modelBroadCast);
        pr.hide();
        if (r == 'true') {
          title.text = '';
          description.text = '';
          dateEvent.text = 'Date Broadcast';
          setState(() {
            check = false;
          });
        }
        else
          flushBarShow(context, 'Erreur');
      }
      else
        flushBarShow(context, 'Entre date');
    }
    else
      flushBarShow(context, 'Entre a valide data');
  }

  Future<void> updateBroad() async {
    if (title.text.isNotEmpty && description.text.isNotEmpty &&
        dateEvent.text.isNotEmpty) {
      if (dateEvent.text != 'Date Broadcast') {
        DateTime datetime = DateTime.parse(dateEvent.text);
        ModelBroadCast modelBroadCast = ModelBroadCast(
          id: widget.modelBroadCast.id,
          title: title.text,
          description: description.text,
          date: datetime,
          recorded: check,
          //collaboration: collaboration.toString(),
          image: _image,
        );
        ProgressDialog pr = prDialog(context);
        pr.show();
        String r = await JsonApiBrodCast.updateBroadCast(modelBroadCast);
        pr.hide();
        if (r == 'true') {
          flushBarShow(context, 'Greate');
        }
        else
          flushBarShow(context, 'Erreur');
      }
      else
        flushBarShow(context, 'Entre date');
    }
    else
      flushBarShow(context, 'Entre a valide data');
  }

}