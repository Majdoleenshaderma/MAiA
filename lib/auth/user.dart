import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class User extends StatefulWidget {
  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, String>> _chatHistory = [];
  String? _token;
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    _loadTokenAndLogs();
  }

  Future<void> _loadTokenAndLogs() async {
    final prefs = await SharedPreferences.getInstance();
    final storedToken = prefs.getString('auth_token');

    if (storedToken != null) {
      setState(() => _token = storedToken);
      await _fetchChatLogs(storedToken);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Token not found. Please login again.")),
      );
    }
  }

  Future<void> _fetchChatLogs(String token) async {
    try {
      final response = await http.get(
        Uri.parse('https://maiasalt.online/api/mobile/get-logs'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> logs = jsonDecode(response.body);
        setState(() {
          _chatHistory = logs
              .map<Map<String, String>>((item) => {
            'user': item['userMessage'],
            'ai': item['aiResponse'],
          })
              .toList();
        });

        await Future.delayed(Duration(milliseconds: 100));
        _scrollToBottom();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error loading logs")),
      );
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _sendMessage() async {
    final message = _controller.text.trim();
    if (message.isEmpty || _token == null) return;

    setState(() {
      _chatHistory.add({'user': message, 'ai': ''});
      _controller.clear();
    });

    _scrollToBottom();

    try {
      final response = await http.post(
        Uri.parse('https://maiasalt.online/api/mobile/ask-maia'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: jsonEncode({'message': message}),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        setState(() {
          _chatHistory[_chatHistory.length - 1]['ai'] =
          responseBody['aiResponse'];
        });
        _scrollToBottom();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to send message: ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error sending message")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'mAIa',
          style: TextStyle(
            color: Color(0xff780000),
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.book, color: Color(0xff05064e)),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16, top: 40, bottom: 8),
              alignment: Alignment.centerLeft,
              child: const Text(
                'History',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff05064e),
                ),
              ),
            ),
            Divider(color: Colors.grey[300]),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Recent Activity'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout, color: Color(0xff780000)),
              title: const Text(
                'Log out',
                style: TextStyle(color: Color(0xff780000)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _chatHistory.isEmpty
                ? const Center(
              child: Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff05064e),
                ),
              ),
            )
                : ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(
                  horizontal: 24, vertical: 16),
              itemCount: _chatHistory.length,
              itemBuilder: (context, index) {
                final chat = _chatHistory[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (chat['user']!.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "${chat['user']}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    if (chat['ai']!.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "${chat['ai']}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 50,
                maxHeight: 200,
              ),
              child: TextField(
                controller: _controller,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Ask mAIa...',
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send, color: Color(0xff780000)),
                    onPressed: _sendMessage,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.person,
                  color: _currentIndex == 0 ? Color(0xff05064e) : Colors.grey),
              onPressed: () => setState(() => _currentIndex = 0),
            ),
            IconButton(
              icon: Icon(Icons.home,
                  color: _currentIndex == 1 ? Color(0xff05064e) : Colors.grey),
              onPressed: () => setState(() => _currentIndex = 1),
            ),
            IconButton(
              icon: Image.asset(
                'assets/images/mirror.png',
                width: 26,
                height: 26,
                color: _currentIndex == 2 ? Color(0xff05064e) : Colors.grey,
                colorBlendMode: BlendMode.modulate,
              ),
              onPressed: () => setState(() => _currentIndex = 2),
            ),
          ],
        ),
      ),
    );
  }
}
