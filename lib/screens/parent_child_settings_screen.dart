import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class ParentChildSettingsScreen extends StatefulWidget {
  const ParentChildSettingsScreen({super.key});

  @override
  _ParentChildSettingsScreenState createState() => _ParentChildSettingsScreenState();
}

class _ParentChildSettingsScreenState extends State<ParentChildSettingsScreen> {
  final int _childAge = 9;
  final String _childUsername = "toto2024";
  final String _childEmail = "totaaa2015@gmail.com";
  TimeOfDay? _selectedTime;
  
  // قائمة الأصدقاء
  List<Map<String, dynamic>> friends = [
    {"name": "سارة محمد", "isActive": true},
    {"name": "ليلى أحمد", "isActive": false},
    {"name": "فرح عبدالله", "isActive": true},
  ];

  // اختيار الوقت
  void _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  // ✅ تأكيد حذف الطفل
  void _confirmDeleteChild() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("حذف الطفل", textAlign: TextAlign.right),
        content: Text(
          "يرجى ملاحظة أن هذا الإجراء سيؤدي إلى فقدان جميع البيانات المرتبطة بحساب الطفل.",
          textAlign: TextAlign.right,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("إلغاء", style: TextStyle(color: Colors.black54)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showDeleteSuccess();
            },
            child: Text("تأكيد الحذف", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // ✅ إشعار نجاح الحذف
  void _showDeleteSuccess() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("تم حذف الطفل بنجاح!", textAlign: TextAlign.right),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("العودة إلى الصفحة الرئيسية"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.snow,
      body: SafeArea(
        child: SingleChildScrollView( // ✅ حل مشكلة الـ Overflow
          child: Column(
            children: [
              // ✅ الهيدر الأخضر
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: AppColors.teaGreen,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      "أهلاً بك، نورا! 👋",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // ✅ بيانات الطفل
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(Icons.person, size: 40, color: Colors.black),
                    ),
                    SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("اسم الطفل: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text("تالية خالد", style: TextStyle(fontSize: 18)),
                      ],
                    ),

                    SizedBox(height: 5),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("اسم المستخدم: ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(_childUsername, style: TextStyle(fontSize: 16, color: Colors.black54)),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("البريد الإلكتروني: ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(_childEmail, style: TextStyle(fontSize: 16, color: Colors.black54)),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("عمر الطفل: ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text("$_childAge", style: TextStyle(fontSize: 16, color: Colors.black54)),
                      ],
                    ),

                    SizedBox(height: 15),

                    // ✅ زر ضبط الوقت
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton.icon(
                        onPressed: _pickTime,
                        icon: Icon(Icons.timer, color: Colors.black),
                        label: Text("ضبط الوقت", style: TextStyle(color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.thistle,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              ),

              // ✅ قائمة الأصدقاء
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("أصدقاء تالية", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Column(
                      children: friends.map((friend) {
                        return ListTile(
                          title: Text(friend["name"], textAlign: TextAlign.right),
                          trailing: Switch(
                            value: friend["isActive"],
                            onChanged: (bool value) {
                              setState(() {
                                friend["isActive"] = value;
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // ✅ زر حذف الطفل (تم إرجاعه مع نافذة التأكيد)
              ElevatedButton(
                onPressed: _confirmDeleteChild,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text("حذف الطفل", style: TextStyle(color: Colors.white)),
              ),

              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
