// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_to_pdf/controller/controller.dart';

class ConvertPage extends StatelessWidget {
  const ConvertPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Expanded(child: ImagePreview()),
        const SizedBox(height: 10),
        const FileNameTextfield(),
        const CompressCheckBox(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            Expanded(child: PickGalleryButton()),
            SizedBox(width: 10),
            Expanded(child: ConvertButton())
          ],
        )
      ],
    );
  }
}

class ImagePreview extends StatelessWidget {
  const ImagePreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ConvertController controller = Get.put(ConvertController());
    return Obx(
      () {
        if (controller.imagesList.isEmpty) {
          return const Center(
            child: Text("Choose Image"),
          );
        } else {
          if (controller.isConverting.value) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.grey.shade800,
              ),
            );
          } else {
            return ListView.separated(
              padding: const EdgeInsets.all(0),
              itemCount: controller.imagesList.length,
              itemBuilder: (context, index) {
                return Image.file(controller.imagesList[index]);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
            );
          }
        }
      },
    );
  }
}

class FileNameTextfield extends StatelessWidget {
  const FileNameTextfield({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ConvertController controller = Get.put(ConvertController());
    return TextField(
      controller: controller.fileNameController.value,
      decoration: InputDecoration(
        label: const Text("File Name"),
        hintText: "fileName${DateTime.now().millisecondsSinceEpoch}",
      ),
    );
  }
}

class CompressCheckBox extends StatelessWidget {
  const CompressCheckBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ConvertController controller = Get.put(ConvertController());
    return Obx(
      () => CheckboxListTile(
        value: controller.isImageCompressed.value,
        onChanged: ((value) => controller.isImageCompressed.value = value!),
        title: const Text("Compress images?"),
      ),
    );
  }
}

class PickGalleryButton extends StatelessWidget {
  const PickGalleryButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ConvertController controller = Get.put(ConvertController());
    return ElevatedButton.icon(
      onPressed: () => controller.getImage(),
      //  padding: const EdgeInsets.all(10),
      icon: const Icon(Icons.add_photo_alternate_rounded),
      // color: Colors.grey.shade800,
      label: const Text("Gallery"),
    );
  }
}

class ConvertButton extends StatelessWidget {
  const ConvertButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ConvertController controller = Get.put(ConvertController());
    return ElevatedButton.icon(
      onPressed: () => controller.convertImage(context),
      // padding: const EdgeInsets.all(10),
      icon: const Icon(Icons.picture_as_pdf_rounded),
      // color: Colors.grey.shade800,
      label: const Text("Convert"),
    );
  }
}
