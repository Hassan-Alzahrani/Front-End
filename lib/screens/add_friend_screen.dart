import 'package:flutter/material.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> searchResults = [];
  List<Map<String, dynamic>> friendRequests = [
    {"name": "أسامة", "avatar": "assets/avatar1.png"},
    {"name": "نورة", "avatar": "assets/avatar2.png"},
  ];

  void searchFriends(String query) {
    setState(() {
      if (query.isEmpty) {
        searchResults = [];
      } else {
        searchResults = ["أحمد", "سارة", "خالد"].where((name) => name.contains(query)).toList();
      }
    });
  }

  void sendFriendRequest(String friendName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("تم إرسال طلب صداقة إلى $friendName")),
    );
  }

  void acceptRequest(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("تمت إضافة ${friendRequests[index]["name"]} إلى قائمة أصدقائك")),
    );
    setState(() {
      friendRequests.removeAt(index);
    });
  }

  void rejectRequest(int index) {
    setState(() {
      friendRequests.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F1EB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC4E3B4),
        title: const Text("إضافة الأصدقاء", style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: "ابحث عن صديق...",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(15),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                ),
                onChanged: searchFriends,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  if (searchResults.isNotEmpty) ...[
                    const Text("نتائج البحث:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    ...searchResults.map((friendName) => ListTile(
                          title: Text(friendName, style: const TextStyle(fontSize: 16)),
                          trailing: ElevatedButton(
                            onPressed: () => sendFriendRequest(friendName),
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC4E3B4)),
                            child: const Text("إرسال طلب", style: TextStyle(color: Colors.black)),
                          ),
                        )),
                  ],
                  if (friendRequests.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    const Text("طلبات الصداقة:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    ...List.generate(friendRequests.length, (index) {
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: ListTile(
                          leading: CircleAvatar(backgroundImage: AssetImage(friendRequests[index]["avatar"])),
                          title: Text(friendRequests[index]["name"], style: const TextStyle(fontSize: 16)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.check_circle, color: Colors.green),
                                onPressed: () => acceptRequest(index),
                              ),
                              IconButton(
                                icon: const Icon(Icons.cancel, color: Colors.red),
                                onPressed: () => rejectRequest(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
