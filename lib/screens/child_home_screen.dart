import 'package:flutter/material.dart';
import 'child_chat_screen.dart';
import 'add_friend_screen.dart';
import 'child_settings_screen.dart'; // ✅ استيراد صفحة الإعدادات

class ChildHomeScreen extends StatefulWidget {
  final String childName;

  const ChildHomeScreen({super.key, required this.childName});

  @override
  _ChildHomeScreenState createState() => _ChildHomeScreenState();
}

class _ChildHomeScreenState extends State<ChildHomeScreen> {
  List<Map<String, String>> friends = [
    {"name": "أسامة", "avatar": "assets/images/boy.png"},
    {"name": "ليان", "avatar": "assets/images/girl.png"},
  ];

  List<Map<String, String>> chats = [
    {"name": "ليان خالد", "message": "بلا لعب", "time": "5:12 م", "avatar": "assets/images/girl.png"},
    {"name": "أسامة محمد", "message": "أضفد تالية", "time": "7:30 م", "avatar": "assets/images/boy.png"},
    {"name": "أنيـس", "message": "يا هلا فيك معنا! وش حاب نتكلم؟", "time": "7:30 م", "avatar": "assets/images/anis_logo.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F1EB),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              // ✅ الجزء العلوي (الترحيب + الأصدقاء)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: const BoxDecoration(
                  color: Color(0xFFC4E3B4),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "👋 أهلاً بك، ${widget.childName}!",
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "قائمة أصدقائك",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const SizedBox(height: 10),

                    // ✅ قائمة الأصدقاء + زر الإضافة
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Wrap(
                            spacing: 10, 
                            runSpacing: 10, 
                            alignment: WrapAlignment.end, 
                            children: [
                              ...friends.map((friend) => _friendAvatar(friend["avatar"]!, friend["name"]!)),
                              _addFriendButton(), // ✅ زر الإضافة
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ✅ قائمة المحادثات
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChildChatScreen(
                              friendName: chats[index]["name"]!,
                              friendAvatar: chats[index]["avatar"]!,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Text(chats[index]["time"]!, style: const TextStyle(color: Colors.black54, fontSize: 12)), 
                          title: Text(chats[index]["name"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(chats[index]["message"]!, style: const TextStyle(color: Colors.black54)),
                          trailing: CircleAvatar(
                            backgroundImage: AssetImage(chats[index]["avatar"]!),
                            radius: 25,
                          ), 
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      // ✅ شريط التنقل السفلي مع التنقل إلى الإعدادات
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: 0, 
        onTap: (index) {
          if (index == 2) { // ✅ عند الضغط على زر الإعدادات
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChildSettingScreen( // ✅ الانتقال إلى صفحة الإعدادات
                  childName: widget.childName,
                  childAge: 9, // ضع القيمة الصحيحة هنا
                  remainingTime: 120, // ضع القيمة الصحيحة هنا
                ),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "المحادثات"),
          BottomNavigationBarItem(icon: Icon(Icons.smart_toy), label: "أنيـس"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "الإعدادات"),
        ],
      ),
    );
  }

  // ✅ ودجت أيقونة الصديق
  Widget _friendAvatar(String image, String name) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(image),
          radius: 22,
        ),
        const SizedBox(height: 5),
        Text(name, style: const TextStyle(fontSize: 12, color: Colors.black)),
      ],
    );
  }

  // ✅ زر إضافة صديق (يؤدي إلى صفحة إضافة الأصدقاء)
  Widget _addFriendButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddFriendScreen()), // ✅ يفتح صفحة إضافة الأصدقاء
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.topRight, 
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 22,
                child: const Icon(Icons.add, color: Colors.black),
              ),
              Positioned(
                top: 0,
                right: 0, 
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Text("2", style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Text("إضافة", style: TextStyle(fontSize: 12, color: Colors.black)),
        ],
      ),
    );
  }
}
