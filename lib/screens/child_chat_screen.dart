import 'package:flutter/material.dart';

class ChildChatScreen extends StatefulWidget {
  final String friendName;
  final String friendAvatar;

  const ChildChatScreen({super.key, required this.friendName, required this.friendAvatar});

  @override
  State<ChildChatScreen> createState() => _ChildChatScreenState();
}

class _ChildChatScreenState extends State<ChildChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  List<Map<String, dynamic>> messages = [
    {"sender": "friend", "text": "هلا تالية، كيف حالك؟ 😊", "time": "5:45 م"},
    {"sender": "me", "text": "هلا أسامة، بخير وأنت؟", "time": "5:50 م"},
  ];

  void sendMessage(String message) {
    if (message.trim().isEmpty) return;

    setState(() {
      messages.add({"sender": "me", "text": message, "time": "الآن"});
    });
    _messageController.clear();
    _focusNode.unfocus();
  }

  void _showFriendInfo() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFC4E3B4),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      CircleAvatar(radius: 40, backgroundImage: AssetImage(widget.friendAvatar)),
                      const SizedBox(height: 10),
                      Text(widget.friendName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text("9 سنوات", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const Divider(),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text("📩 الذهاب إلى المحادثة", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showBlockDialog();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("🚫 حظر الصديق", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showBlockDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("🚫 حظر الصديق", style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text("هل أنت متأكد أنك تريد حظر ${widget.friendName}؟ سيتم إزالة الصديق والمحادثة نهائيًا."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("إلغاء", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  messages.clear();
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم حظر ${widget.friendName}")));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("تأكيد الحظر", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F1EB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC4E3B4),
        title: Row(
          children: [
            CircleAvatar(backgroundImage: AssetImage(widget.friendAvatar)),
            const SizedBox(width: 10),
            Text(widget.friendName, style: const TextStyle(color: Colors.black)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              showMenu(
                context: context,
                position: const RelativeRect.fromLTRB(100, 80, 0, 0),
                items: [
                  PopupMenuItem(
                    value: "info",
                    child: Row(
                      children: const [Icon(Icons.person, color: Colors.blue), SizedBox(width: 10), Text("معلومات الصديق")],
                    ),
                  ),
                  PopupMenuItem(
                    value: "block",
                    child: Row(
                      children: const [Icon(Icons.block, color: Colors.red), SizedBox(width: 10), Text("حظر الصديق")],
                    ),
                  ),
                ],
              ).then((value) {
                if (value == "info") _showFriendInfo();
                if (value == "block") _showBlockDialog();
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(15),
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[messages.length - 1 - index];
                final isMe = msg["sender"] == "me";

                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: isMe ? const Color(0xFFC4E3B4) : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
                    ),
                    child: Text(msg["text"], style: const TextStyle(fontSize: 16)),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
                    ),
                    child: TextField(controller: _messageController, focusNode: _focusNode, decoration: const InputDecoration(hintText: "اكتب رسالة...", border: InputBorder.none)),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => sendMessage(_messageController.text),
                  child: Container(padding: const EdgeInsets.all(12), decoration: const BoxDecoration(color: Color(0xFFC4E3B4), shape: BoxShape.circle), child: const Icon(Icons.send, color: Colors.black)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
