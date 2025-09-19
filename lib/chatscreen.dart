import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Chat> _chats = [
    Chat(
      name: 'John Doe',
      lastMessage: 'Is this still available?',
      time: '10:30 AM',
      unread: true,
    ),
    Chat(
      name: 'Jane Smith',
      lastMessage: 'I can offer P600 for it',
      time: 'Yesterday',
      unread: false,
    ),
    Chat(
      name: 'Mike Johnson',
      lastMessage: 'When can I pick it up?',
      time: 'Monday',
      unread: false,
    ),
  ];

  bool _disclaimerShown = false;
  bool _showDisclaimer = true;

  @override
  void initState() {
    super.initState();
    _loadDisclaimerPreference();
  }

  Future<void> _loadDisclaimerPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _showDisclaimer = prefs.getBool('show_chat_disclaimer') ?? true;
    });


    if (_showDisclaimer && !_disclaimerShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showSafetyDisclaimer(context);
      });
    }
  }

  void _showSafetyDisclaimer(BuildContext context) {
    bool dontShowAgain = !_showDisclaimer;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(

              title: const ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 28),
                title: Text(
                  'Safety & Liability',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'ByteBack connects buyers and sellers to promote the reuse of electronics and reduce e-waste. Please keep the following in mind:',
                      style: TextStyle(height: 1.5),
                    ),
                    const SizedBox(height: 16),
                    _buildDisclaimerPoint('Always meet in safe, public places.'),
                    _buildDisclaimerPoint('Inspect the device carefully before making payment.'),
                    _buildDisclaimerPoint('ByteBack is a platform only and is not responsible for fraud, loss, damage, or unsafe meetups.'),
                    const SizedBox(height: 16),
                    const Text(
                      'By continuing, you agree to trade responsibly and support our mission. 🌱',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 10),

                    InkWell(
                      onTap: () {
                        setState(() {
                          dontShowAgain = !dontShowAgain;
                        });
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Checkbox(
                              value: dontShowAgain,
                              onChanged: (value) {
                                setState(() {
                                  dontShowAgain = value ?? false;
                                });
                              },
                            ),

                            const SizedBox(width: 8),

                            const Expanded(
                              child: Text("Don't show this again"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),

                ElevatedButton.icon(
                  icon: const Icon(Icons.check_circle_outline, size: 18),
                  label: const Text('I Understand & Continue'),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();

                    await prefs.setBool('show_chat_disclaimer', !dontShowAgain);

                    if (mounted) {

                      this.setState(() {
                        _disclaimerShown = true;
                      });
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF109991),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildDisclaimerPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold, height: 1.5)),
          Expanded(child: Text(text, style: const TextStyle(height: 1.5))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: ListView.builder(
        itemCount: _chats.length,
        itemBuilder: (context, index) {
          final chat = _chats[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xFF109991),
              child: Text(
                chat.name[0],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(chat.name),
            subtitle: Text(chat.lastMessage),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  chat.time,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                if (chat.unread)
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatDetailScreen(chat: chat),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Chat {
  final String name;
  final String lastMessage;
  final String time;
  final bool unread;

  Chat({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unread,
  });
}

class ChatDetailScreen extends StatelessWidget {
  final Chat chat;

  const ChatDetailScreen({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    // Get the current theme's color scheme
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFF109991),
              child: Text(
                chat.name[0],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
            Text(chat.name),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                Align(
                  alignment: Alignment.centerLeft,
                  child: ChatBubble(
                    message: 'Hello! Is this item still available?',
                    isMe: false,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ChatBubble(
                    message: 'Yes, it is still available!',
                    isMe: true,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ChatBubble(
                    message: 'Great! Can you do P600?',
                    isMe: false,
                  ),
                ),
              ],
            ),
          ),
          // This is the message input bar that was fixed
          Container(
            padding: const EdgeInsets.all(8),
            // Use a theme-aware color for the background
            color: colorScheme.surfaceContainer,
            child: Row(
              children: [
                IconButton(
                  // Use a theme-aware color for the icon
                  icon: Icon(Icons.attach_file, color: colorScheme.onSurfaceVariant),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      // Use theme-aware colors for the text field
                      filled: true,
                      fillColor: colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none, // Remove the default border
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                IconButton(
                  // Use a theme-aware color for the icon
                  icon: Icon(Icons.send, color: colorScheme.primary),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {

    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(

        color: isMe ? const Color(0xFF109991) : colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        message,

        style: TextStyle(color: isMe ? Colors.white : colorScheme.onSurface),
      ),
    );
  }
}