import 'dart:convert';
import 'dart:io';

class SaveFile {
  static File jsonFile;
  static Directory dir;
  static String fileName = 'myPlaylists.json';
  static bool fileExits = false;
  static Map<String, dynamic> fileContent;

  static File createFile(Map<String, dynamic> content) {
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    fileExits = true;
    file.writeAsStringSync(json.encode(content));
    return file;
  }

  static void writeToFile(
      {String playlistId, String playlistName, List<String> songId}) {
    print("write");

    Map<String, dynamic> content = {
      'playlistId': playlistId,
      'playlistName': playlistName,
      'songId': songId,
    };
    if (fileExits) {
      Map<String, dynamic> jsonFileContent =
          json.decode(jsonFile.readAsStringSync());
      print(content);
      jsonFileContent.addAll(content);
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    } else {
      print("Create");
      createFile(content);
    }
  }
}
