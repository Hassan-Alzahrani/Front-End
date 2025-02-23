import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService { 
  final String baseUrl = "http://192.168.31.164:8000/api"; // تأكدي أنه صحيح

  Future<Map<String, dynamic>> registerParent({
    required String username,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    final url = Uri.parse("$baseUrl/parent/");
    
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "parentUserName": username,
          "email": email,
          "passwordHash": password,
          "firstName": firstName,
          "lastName": lastName,
        }),
      );

      print("🔹 Response Code: ${response.statusCode}");
      print("🔹 Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {"success": true, "message": "✅ تم إنشاء الحساب بنجاح!"};
      } else {
        return {
          "success": false,
          "message": jsonDecode(response.body)['detail'] ?? "❌ حدث خطأ غير متوقع!"
        };
      }
    } catch (e) {
      print("❌ خطأ في الاتصال بالـ API: $e");
      return {"success": false, "message": "❌ لا يمكن الاتصال بالسيرفر!"};
    }
  }
}
