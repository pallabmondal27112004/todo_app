import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todoapp/common/CustomSnackBar.dart';

class Apicall {
  static final api = "https://todoapp-backends.onrender.com/todos/";
  // static final api = "http://192.168.0.120:8000/todos/";

  static Future<List<dynamic>> getTodo() async {
    print("Api is called ");
    try {
      final response = await http.get(Uri.parse(api)); // removed custom headers
      if (response.statusCode == 200) {
        return jsonDecode(response.body); // must be a JSON list
      } else {
        throw Exception('Server returned error: ${response.statusCode}');
      }
    } catch (e) {
      print('Caught error in getTodo: $e');
      throw Exception('Failed to connect to API');
    }
  }

  static Future<void> CreateTodo(String? name) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(api));
    request.body = json.encode({"name": name, "complected": false});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  static Future<void> updatetodo({
    BuildContext? context,
    int? id,
    String? name,
    bool? iscomplect,
  }) async {
    // Customsnackbar.showCustomSnackBar(context!, "Encounter", "error");
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('PUT', Uri.parse("$api$id/"));
    // Customsnackbar.showCustomSnackBar(context!, "$request", "success");

    request.body = json.encode({
      // "id": id,
      "name": name,
      "complected": iscomplect,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Customsnackbar.showCustomSnackBar(
        context!,
        "Updated successfully",
        "success",
      );
    } else {
      Customsnackbar.showCustomSnackBar(
        context!,
        "${response.statusCode} error occur ",
        "success",
      );
      print(response.reasonPhrase);
    }
  }

  static Future<void> DeleteTodo(int? id, BuildContext context) async {
    var request = http.Request('DELETE', Uri.parse("$api$id/"));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 204) {
      print(await response.stream.bytesToString());
      Customsnackbar.showCustomSnackBar(
        context,
        "Successfully deleted",
        "success",
      );
    } else {
      Customsnackbar.showCustomSnackBar(
        context,
        "Something is missing",
        "error",
      );
      print(response.reasonPhrase);
    }
  }

  static Future<void> createTodo({
    required String name,
    required BuildContext context,
  }) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse("$api"));
    request.body = jsonEncode({"name": name, "complected": false});
    request.headers.addAll(headers);
    // Customsnackbar.showCustomSnackBar(context, "$request", "error");

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      print(await response.stream.bytesToString());
      Customsnackbar.showCustomSnackBar(context, "creted tast", "success");
    } else {
      Customsnackbar.showCustomSnackBar(context, " ${request.body}", "error");
      print(response.reasonPhrase);
    }
  }
}
