import 'package:flutter/material.dart';

class AddChildScreen extends StatefulWidget {
  const AddChildScreen({super.key});

  @override
  _AddChildScreenState createState() => _AddChildScreenState();
}

class _AddChildScreenState extends State<AddChildScreen> {
  final TextEditingController _childNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // ✅ نافذة المعلومات الخاصة بنظام الإشعارات
  void _showNotificationInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "المعلومات الخاصة بتنبيهات النظام",
          textAlign: TextAlign.right,
        ),
        content: Text(
          "📌 من عمر 4 إلى 9 سنوات:\n"
          "▪ يتم تنبيهك عن جميع المحتويات الضارة.\n\n"
          "📌 من عمر 10 إلى 13 سنة:\n"
          "▪ يتم تنبيهك عند وجود رسائل تحتوي على:\n"
          "  • مخدرات\n"
          "  • ألفاظ جنسية\n"
          "  • معلومات حساسة\n\n"
          "📌 من عمر 14 إلى 17 سنة:\n"
          "▪ يتم تنبيهك عند وجود رسائل تحتوي على:\n"
          "  • مخدرات\n"
          "  • ألفاظ جنسية",
          textAlign: TextAlign.right,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("إغلاق"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F1EB), // ✅ لون الخلفية كما هو في التصميم
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // ✅ عنوان الصفحة
            Text(
              "إضافة طفل",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 5),
            Text(
              "البيانات الشخصية:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 20),

            // ✅ الحقول المطلوبة
            _buildLabeledTextField("اسم الطفل", _childNameController, "أدخل اسم الطفل"),
            _buildLabeledTextField("اسم المستخدم للطفل", _usernameController, "أدخل اسم المستخدم"),
            _buildLabeledTextField("البريد الإلكتروني للطفل", _emailController, "أدخل البريد الإلكتروني الخاص بالطفل"),

            // ✅ حقل عمر الطفل مع عنوان وعلامة معلومات في الجهة الأخرى
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ✅ أيقونة المعلومات على اليسار (نهاية الجملة)
                      GestureDetector(
                        onTap: _showNotificationInfo,
                        child: Icon(Icons.info_outline, color: Colors.black),
                      ),
                      // ✅ العنوان "عمر الطفل" على اليمين
                      Text(
                        "عمر الطفل",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  // ✅ حقل إدخال العمر
                  _buildTextField(_ageController, "أدخل عمر الطفل"),
                ],
              ),
            ),

            _buildLabeledTextField("كلمة المرور الخاصة بحساب الطفل", _passwordController, "أدخل كلمة المرور الخاصة بحساب الطفل", isPassword: true),
            _buildLabeledTextField("تأكيد كلمة المرور", _confirmPasswordController, "أدخل تأكيد كلمة المرور", isPassword: true),

            SizedBox(height: 30),

            // ✅ زر إضافة الطفل في المنتصف
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // سيتم تنفيذ العملية لاحقًا عند ربطها بالباك اند
                },
                icon: Icon(Icons.add, color: Colors.black), // ✅ أيقونة بجانب النص
                label: Text(
                  "إضافة طفل",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF0CDEA), // ✅ اللون الوردي كما هو في التصميم
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ دالة لإنشاء الحقول مع عنوان فوقها
  Widget _buildLabeledTextField(String label, TextEditingController controller, String hint, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        _buildTextField(controller, hint, isPassword: isPassword),
      ],
    );
  }

  // ✅ دالة لإنشاء الحقول النصية بمحاذاة يمينية وتصميم مناسب
  Widget _buildTextField(TextEditingController controller, String hint, {bool isPassword = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        textAlign: TextAlign.right, // ✅ جعل النص داخل الحقل من اليمين
        decoration: InputDecoration(
          hintText: hint,
          hintTextDirection: TextDirection.rtl, // ✅ توجيه النصوص داخل الحقل
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        ),
      ),
    );
  }
}
