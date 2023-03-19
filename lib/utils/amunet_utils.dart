import 'dart:io';

class FenoteAbewUtils{

  static T valueOrDefault<T>(T? value, T defaultValue) =>
    (value is String && value.isEmpty) || value == null || value == '' ? defaultValue : value;

  static String getFileExtension(File file){
    List fileNameSplit = file.path.split(".");
    String extension = fileNameSplit.last;
    return extension;
  }

  static String getFileSize(File file){
    return (file.lengthSync() / (1024 * 1024)).toStringAsFixed(1);
  }

}