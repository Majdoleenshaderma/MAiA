import 'package:flutter/material.dart';
import 'login.dart';

class User extends StatefulWidget {
  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  int _currentIndex = 1;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'mAIa',
          style: TextStyle(
            color: Color(0xff780000),
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.book, color: Color(0xff05064e)),
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
              padding: EdgeInsets.only(left: 16, top: 40, bottom: 8),
              alignment: Alignment.centerLeft,
              child: Text(
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
              leading: Icon(Icons.history),
              title: Text('Recent Activity'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Spacer(),
            ListTile(
              leading: Icon(Icons.logout, color: Color(0xff780000)),
              title: Text(
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
            child: _messages.isEmpty
                ? Center(
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
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.8,
                    ),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        message,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 50,
                maxHeight: 200,
              ),
              child: Scrollbar(
                child: TextField(
                  controller: _controller,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Ask mAIa...',
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send, color: Color(0xff780000)),
                      onPressed: _sendMessage,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.person,
                  color: _currentIndex == 0 ? Color(0xff05064e) : Colors.grey),
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.home,
                  color: _currentIndex == 1 ? Color(0xff05064e) : Colors.grey),
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            IconButton(
              icon: Image.asset(
                'assets/images/mirror.png',
                width: 26,
                height: 26,
                color: _currentIndex == 2 ? Color(0xff05064e) : Colors.grey,
                colorBlendMode: BlendMode.modulate,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add(text);
        _controller.clear();
      });

      Future.delayed(Duration(milliseconds: 100)).then((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }
}
