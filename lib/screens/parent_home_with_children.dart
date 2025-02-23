import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'parent_child_settings_screen.dart';
import 'parent_notifications_screen.dart';
import 'add_child_screen.dart';
import 'parent_settings_screen.dart';

class ParentHomeWithChildren extends StatefulWidget {
  const ParentHomeWithChildren({super.key});

  @override
  _ParentHomeWithChildrenState createState() => _ParentHomeWithChildrenState();
}

class _ParentHomeWithChildrenState extends State<ParentHomeWithChildren> {
  int _selectedIndex = 0; // ✅ للتحكم في التبويبات

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // ✅ التنقل بين الصفحات بناءً على التبويبة المختارة
    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ParentNotificationsScreen(notifications: []), // ✅ تم تمرير قائمة فارغة مؤقتًا
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ParentSettingsScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> children = [
      {"name": "تالـيـة", "image": "assets/images/girl.png"},
      {"name": "عبدالرحمن", "image": "assets/images/boy.png"},
      {"name": "غيث", "image": "assets/images/boy2.png"},
    ];

    return Scaffold(
      backgroundColor: AppColors.snow,
      body: SafeArea(
        child: Column(
          children: [
            // ✅ الهيدر
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: AppColors.teaGreen,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications, color: Colors.black, size: 28),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ParentNotificationsScreen(notifications: []),
                        ),
                      );
                    },
                  ),
                  const Text(
                    "أهلاً بك، نورا! 👋",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ✅ حالة عدم وجود أطفال
            if (children.isEmpty)
              const Expanded(
                child: Center(
                  child: Text(
                    "لم تقم بإضافة أطفال بعد.",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: children.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ParentChildSettingsScreen(),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: AppColors.teaGreen,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(children[index]["image"] ?? "assets/images/default.png"), // ✅ صورة افتراضية
                            radius: 20,
                          ),
                          title: Text(
                            children[index]["name"]!,
                            textAlign: TextAlign.right,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

            const SizedBox(height: 20),

            // ✅ زر إضافة طفل
            Center(
              child: SizedBox(
                width: 180,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddChildScreen()),
                    );
                  },
                  icon: const Icon(Icons.add, color: Colors.black),
                  label: const Text("إضافة طفل", style: TextStyle(color: Colors.black, fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.thistle ?? Colors.purple[200], // ✅ لون احتياطي
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),

      // ✅ شريط التنقل السفلي
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "الإشعارات"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "الإعدادات"),
        ],
      ),
    );
  }
}
