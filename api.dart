import 'dart:io';

import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/io_client.dart';

class ApiService {






  Future<bool> login({
    required String username,
    required String password,
  }) async {
    final ioc = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true; // ignore SSL
    final httpClient = IOClient(ioc);

    final url = Uri.parse('http://pawconnect.atwebpages.com/Web/api/log.php');

    try {
      final response = await httpClient.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'username': username,
          'password': password,
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == true) {
          final userData = jsonResponse['data'];

          // Save user info to SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt('user_id', userData['id']);
          await prefs.setString('firstname', userData['firstname']);
          await prefs.setString('lastname', userData['lastname']);
          await prefs.setString('email', userData['email']);
          await prefs.setString(
              'mobile_number', userData['mobile_number'].toString());

          print('✅ Login success, saved user: ${userData['firstname']}');
          return true;
        } else {
          print('❌ Login failed: ${jsonResponse['message']}');
          return false;
        }
      } else {
        print('❌ Server error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('⚠️ Login error: $e');
      return false;
    } finally {
      httpClient.close();
    }
  }



  Future<bool> reg({
    required String username,
    required String password,
    required String email,
    required String mobile,
    required String fname,
    required String lname,
  }) async {
    final ioc = HttpClient()
      ..badCertificateCallback = 
          (X509Certificate cert, String host, int port) => true;
    final httpClient = IOClient(ioc);

    final url = Uri.parse('http://pawconnect.atwebpages.com/Web/api/reg.php');

    try {
      final response = await httpClient.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'username': username,
          'password': password,
          'email': email,
          'phone': mobile,
          'fname': fname,
          'lname': lname,
        },
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        print('Response: ${response.body}');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Login error: $e');
      return false;
    } finally {
      httpClient.close();
    }
  }



Future<Map<String, dynamic>?> nfc({
    required String nfc,
  }) async {
    final ioc = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    final httpClient = IOClient(ioc);

    final url = Uri.parse('http://pawconnect.atwebpages.com/Web/api/nfc.php');

    try {
      final response = await httpClient.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'nfc': nfc},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == true) {
          return data['data']; 
        }
      }
      return null;
    } catch (e) {
      debugPrint('NFC error: $e');
      return null;
    } finally {
      httpClient.close();
    }
  }








  Future<bool> addpet({
    required String id,
    required String name,
    required String type,
    required String breed,
    required String age,
    required String description,
    required String code,
    required String gender,
    required String color,
    required String image,
  }) async {
    final ioc = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    final httpClient = IOClient(ioc);
    debugPrint('id $id');
    debugPrint('name $name');
    debugPrint('type $type');
    debugPrint('breed $breed');
    debugPrint('age $age');
    debugPrint('description $description');
    debugPrint('code $code');
    debugPrint('gender $gender');
    debugPrint('color $color');
    debugPrint('image $image');

    final url = Uri.parse('http://pawconnect.atwebpages.com/Web/api/addpet.php');

    try {
      final response = await httpClient.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'id': id,
          'name': name,
          'type': type,
          'breed': breed,
          'age': age,
          'description': description,
          'code': code,
          'color': color,
          'gender': gender,
          'image': image,
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        debugPrint('data $data');

        if(data['status'] == true){
          return true;
        }
        return false;     
      }
      return false;
    } catch (e) {
      debugPrint('NFC error: $e');
      return false;
    }
  }










 Future<bool> report({
    required String id,
    required String pet_name,
    required String description,
    required String image,
    required String date_missing,
  }) async {
    final ioc = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    final httpClient = IOClient(ioc);

    final url = Uri.parse('http://pawconnect.atwebpages.com/Web/api/report.php');

    try {
      final response = await httpClient.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'id': id,
          'pet_name': pet_name,
          'description': description,
          'image': image,
          'date_missing': date_missing,
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        debugPrint('data $data');
        
        if(data['status'] == true){
          return true;
        }
        return false;     
      }
      return false;
    } catch (e) {
      debugPrint('NFC error: $e');
      return false;
    }
  }







Future<bool> donate({
    required String id,
    required String donate_type,
    required String amount,
    required String ref,
  }) async {
    final ioc = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    final httpClient = IOClient(ioc);

    final url = Uri.parse('http://pawconnect.atwebpages.com/Web/api/donate.php');

    try {
      final response = await httpClient.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'id': id,
          'donate_type': donate_type,
          'amount': amount,
          'ref': ref,
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        debugPrint('data $data');
        
        if(data['status'] == true){
          return true;
        }
        return false;     
      }
      return false;
    } catch (e) {
      debugPrint('NFC error: $e');
      return false;
    }
  }




}
