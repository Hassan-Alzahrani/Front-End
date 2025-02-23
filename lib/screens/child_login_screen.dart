import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'reset_password_screen.dart';

class ChildLoginScreen extends StatefulWidget {
  const ChildLoginScreen({super.key});

  @override
  _ChildLoginScreenState createState() => _ChildLoginScreenState();
}

class _ChildLoginScreenState extends State<ChildLoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F1EB), // ✅ خلفية بيج فاتح
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ✅ الجزء العلوي الأخضر (بنفس حجم تسجيل دخول الآباء)
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.30, // ✅ نفس ارتفاع صفحة الآباء
              decoration: BoxDecoration(
                color: Color(0xFFA7D7A9), // ✅ اللون الأخضر
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50), // ✅ نفس المسافات
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // ✅ زر الرجوع
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  // ✅ العنوان
                  Text(
                    'تسجيل دخول الأبناء',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  // ✅ النص الوصفي
                  Text(
                    'أدخل بياناتك للدخول إلى حسابك',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            ),

            // ✅ الحقول والأزرار
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // ✅ اسم المستخدم
                  Text(
                    'اسم المستخدم',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  CustomTextField(hint: 'أدخل اسم المستخدم', controller: _usernameController),
                  SizedBox(height: 10),

                  // ✅ كلمة المرور
                  Text(
                    'كلمة المرور',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  CustomTextField(hint: 'أدخل كلمة المرور', controller: _passwordController, isPassword: true),

                  // ✅ زر نسيت كلمة المرور مع التنقل لصفحة الاستعادة
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
                        );
                      },
                      child: Text('نسيت كلمة المرور؟', style: TextStyle(color: Colors.black54)),
                    ),
                  ),

                  SizedBox(height: 20),

                  // ✅ زر تسجيل الدخول
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CustomButton(
                      text: 'تسجيل الدخول',
                      color: Color(0xFFF0CDEA), // ✅ اللون الوردي النهائي
                      textColor: Colors.white,
                      onTap: () {
                        print("اسم المستخدم: ${_usernameController.text}");
                        print("كلمة المرور: ${_passwordController.text}");
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}