// ignore_for_file: use_build_context_synchronously, import_of_legacy_library_into_null_safe

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_merger/pdf_merger.dart';
import 'package:permission_handler/permission_handler.dart';

class ConvertController extends GetxController {
  var imagesList = <File>[].obs;
  var fileNameController = TextEditingController().obs;
  var isImageCompressed = false.obs;
  var isConverting = false.obs;

  Future getImage() async {
    try {
      if (await Permission.photos.request().isGranted &&
          await Permission.storage.request().isGranted) {
        final List<XFile>? images = await ImagePicker().pickMultiImage();
        if (images == null) return;

        for (var element in images) {
          imagesList.add(File(element.path));
        }
      }
    } catch (e) {
      e.toString().printError();
    }
  }

  Future convertImage(BuildContext context) async {
    try {
      if (imagesList.isNotEmpty) {
        isConverting.value = true;

        List<String> imagesPath = [];
        Directory? appDocDir = await getExternalStorageDirectory();
        String appDocPath = "";

        if (fileNameController.value.text.isEmpty) {
          appDocPath =
              "${appDocDir!.path}/fileName${DateTime.now().millisecondsSinceEpoch}.pdf";
        } else {
          appDocPath =
              "${appDocDir!.path}/${fileNameController.value.text}.pdf";
        }

        for (var element in imagesList) {
          imagesPath.add(element.path);
          debugPrint(element.path);
        }

        CreatePDFFromMultipleImageResponse response =
            await PdfMerger.createPDFFromMultipleImage(
          paths: imagesPath,
          outputDirPath: appDocPath,
          needImageCompressor: isImageCompressed.value,
        );

        if (response.status == "success") {
          response.message.printInfo();
          response.response.printInfo();
          response.status.printInfo();

          isConverting.value = false;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "${response.message.toString().toUpperCase()}: ${response.response}",
              ),
            ),
          );

          OpenFile.open(appDocPath);
        }
      }
    } catch (e) {
      e.toString().printError();
    }
  }
}
