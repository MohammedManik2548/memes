import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../business_logics/controllers/meme_details_page_controller.dart';
import '../../data/models/memes_model.dart';


class MemeDetailScreen extends StatelessWidget {
  final Meme? meme;
   MemeDetailScreen({super.key,this.meme});

  final MemeDetailsController _controller = Get.put(MemeDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(meme?.name??'')),
      body: Column(
        children: [
          Obx(()=>Expanded(
            child: _controller.editedImage.value.path == ''
                ? Image.network(meme?.url??'')
                : Image.file(_controller.editedImage.value!),
          ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.crop),
                onPressed: (){
                  _controller.cropImage(meme?.url??'');
                },
              ),
              IconButton(
                icon: Icon(Icons.rotate_right),
                onPressed: (){
                  _controller.rotateImage();
                },
              ),
              IconButton(
                icon: Icon(Icons.save),
                onPressed: (){
                  _controller.saveImage();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

