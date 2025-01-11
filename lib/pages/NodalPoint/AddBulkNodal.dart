import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../Model/FIleDataModel.dart';
import '../../constants/style.dart';
import '../../widgets/Button.dart';
import 'NodalPointController/NodalPointController.dart';



class AddBulkNodal extends StatefulWidget {

  final ValueChanged<FileDataModel> onDroppedFile;

  const AddBulkNodal({Key? key,required this.onDroppedFile}):super(key: key);
  @override
  _AddBulkNodalState createState() => _AddBulkNodalState();
}

class _AddBulkNodalState extends State<AddBulkNodal> {
  //controller to hold data of file dropped by user
  late DropzoneViewController controller;
  // a variable just to update UI color when user hover or leave the drop zone
  bool highlight = false;
  final Controller = Get.put(NodalPointController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 500.h,
        width: 500.w,
      child: buildDecoration(
          child: Stack(
            children: [
              // dropzone area
              DropzoneView(
                // attach an configure the controller
                onCreated: (controller) => this.controller = controller,
                // call UploadedFile method when user drop the file
                onDrop: UploadedFile,
                // change UI when user hover file on dropzone
                onHover:() => setState(()=> highlight = true),
                onLeave: ()=> setState(()=>highlight = false),
                onLoaded: ()=> print('Zone Loaded'),
                onError: (err)=> print('run when error found : $err'),
              ),

              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_upload_outlined,
                      size: 80,
                      color: Colors.white,
                    ),
                    Text(
                      'Drop Files Here',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // a button to pickfile from computer
                    ElevatedButton.icon(
                      onPressed: () async {
                        final events = await controller.pickFiles();
                        if(events.isEmpty) return;
                        UploadedFile(events.first);
                      },
                      icon: Icon(Icons.search),
                      label: Text(
                        'Choose File',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20
                          ),
                          backgroundColor: lightGrey,
                          shape: RoundedRectangleBorder()
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    GestureDetector(

                      onTap:(){
                        Navigator.pop(context);
                      },
                      child: Button(
                          'Back',
                          150,
                          15,
                          60
                      ),

                    )
                  ],
                ),
              ),


            ],
          )),
    );
  }

  Future UploadedFile(dynamic event) async {
    // this method is called when user drop the file in drop area in flutter

    final name = event.name;
    final mime = await controller.getFileMIME(event);
    final byte = await controller.getFileSize(event);
    final url = await controller.createFileUrl(event);
    Uint8List? fileBytes = await controller.getFileData(event);
    Controller.addInBulk(fileBytes!, name);

    final droppedFile = FileDataModel
      (name: name, mime: mime, bytes: byte, url: url);

    //Update the UI
    widget.onDroppedFile(droppedFile);
    setState(() {
      highlight = false;
    });
  }

  Widget buildDecoration({required Widget child}){
    final colorBackground =  highlight? Colors.blue.withOpacity(0.3): active.withOpacity(0.3);
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(10),
        color: colorBackground,
        child: DottedBorder(
            borderType: BorderType.RRect,
            color: Colors.white,
            strokeWidth: 3,
            dashPattern: [8,4],
            radius: Radius.circular(10),
            padding: EdgeInsets.zero,
            child: child
        ),
      ),
    );
  }
}


class AddNodalButton extends StatefulWidget {
  const AddNodalButton({super.key});

  @override
  State<AddNodalButton> createState() => _AddNodalButtonState();
}

class _AddNodalButtonState extends State<AddNodalButton> {
  FileDataModel? file;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBulkNodal( onDroppedFile: (file) => setState(()=> this.file = file) ,)
            ));
      },
      child: Button(
          'Add Nodal Bulk',
          150,
          15,
          60
      ),

    );
  }
}
