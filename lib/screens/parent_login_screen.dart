import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'reset_password_screen.dart';

class ParentLoginScreen extends StatelessWidget {
  const ParentLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F1EB), // ✅ خلفية بيج فاتح مثل التصميم
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight > 0 
                      ? constraints.maxHeight 
                      : MediaQuery.of(context).size.height, // ✅ الحل الجديد
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      // ✅ الجزء العلوي الأخضر
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                          color: Color(0xFFA7D7A9), // ✅ اللون الأخضر
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end, // ✅ المحاذاة لليمين
                          children: [
                            // ✅ زر الرجوع في اليسار
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                icon: Icon(Icons.arrow_back, color: Colors.black),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            // ✅ العنوان الرئيسي
                            Text(
                              'تسجيل دخول الآباء',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 22, // ✅ تصغير العنوان عشان لا يتجاوز
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 3),
                            // ✅ النص الوصفي
                            Text(
                              'أدخل بياناتك للدخول إلى حسابك',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(fontSize: 14, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),

                      // ✅ توسيع المساحة المتبقية عشان المحتوى ما يكون ضيق
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // ✅ حقل اسم المستخدم
                              Text(
                                'اسم المستخدم',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30), // ✅ استدارة للحقل
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'أدخل اسم المستخدم',
                                      hintStyle: TextStyle(color: Colors.black45),
                                      border: InputBorder.none, // ✅ إزالة الحدود
                                    ),
                                    textAlign: TextAlign.right, // ✅ محاذاة النص لليمين
                                  ),
                                ),
                              ),

                              SizedBox(height: 10),

                              // ✅ حقل كلمة المرور
                              Text(
                                'كلمة المرور',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30), // ✅ استدارة للحقل
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: TextField(
                                    obscureText: true, // ✅ إخفاء النص لكلمة المرور
                                    decoration: InputDecoration(
                                      hintText: 'أدخل كلمة المرور',
                                      hintStyle: TextStyle(color: Colors.black45),
                                      border: InputBorder.none, // ✅ إزالة الحدود
                                    ),
                                    textAlign: TextAlign.right, // ✅ محاذاة النص لليمين
                                  ),
                                ),
                              ),

                              // ✅ زر "نسيت كلمة المرور؟"
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ResetPasswordScreen()), // ✅ فتح صفحة استعادة كلمة المرور
                                    );
                                  },
                                  child: Text(
                                    'نسيت كلمة المرور؟',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ),
                              ),

                              SizedBox(height: 20),

                              // ✅ زر "تسجيل الدخول"
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFF0CDEA), // ✅ تعديل اللون الوردي
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  ),
                                  child: Text(
                                    'تسجيل الدخول',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),

                              Spacer(), // ✅ يجعل "ليس لديك حساب؟" ينزل للأسفل

                              // ✅ "ليس لديك حساب؟ تسجيل"
                              Center(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SignUpScreen()), // ✅ يفتح صفحة التسجيل
                                    );
                                  },
                                  child: Text.rich(
                                    TextSpan(
                                      text: 'ليس لديك حساب؟ ',
                                      style: TextStyle(color: Colors.black54),
                                      children: [
                                        TextSpan(
                                          text: 'تسجيل',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20), // ✅ مسافة أخيرة للتأكد من أن الزر ظاهر بالكامل
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
