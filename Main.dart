import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const EnjoymentVoiceStudioApp());
}

class EnjoymentVoiceStudioApp extends StatelessWidget {
  const EnjoymentVoiceStudioApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Custom Color Palette: Yellow, Green, Blue
    final ThemeData customTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.green,
        primary: const Color(0xFF2E7D32), // Green
        secondary: const Color(0xFF1976D2), // Blue
        tertiary: const Color(0xFFFBC02D), // Yellow
      ),
    );

    return MaterialApp(
      title: 'Enjoyment Voice Studio',
      theme: customTheme,
      debugShowCheckedModeBanner: false,
      home: const AuthWrapper(),
    );
  }
}

// ==================== AUTH WRAPPER ====================
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    if (!isLoggedIn) {
      return LoginScreen(onLoginSuccess: () {
        setState(() {
          isLoggedIn = true;
        });
      });
    } else {
      return const MainDashboard();
    }
  }
}

// ==================== LOGIN SCREEN ====================
class LoginScreen extends StatelessWidget {
  final VoidCallback onLoginSuccess;
  const LoginScreen({super.key, required this.onLoginSuccess});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.mic_rounded, size: 80, color: Color(0xFFFBC02D)), // Yellow
            const SizedBox(height: 16),
            const Text(
              "Enjoyment Voice Studio",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              "Powered by Enjoyment Digital",
              style: TextStyle(fontSize: 14, color: Color(0xFF1976D2)),
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1976D2), // Blue
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: onLoginSuccess,
                icon: const Icon(Icons.g_mobiledata, size: 30),
                label: const Text("Continue with Google", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== MAIN DASHBOARD WITH BOTTOM NAV ====================
class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const AiChatScreen(),
    const VoiceStudioScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.chat), label: 'AI Chat'),
          NavigationDestination(icon: Icon(Icons.mic), label: 'Studio'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// ==================== HOME SCREEN ====================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _launchYouTube() async {
    final Uri url = Uri.parse('https://youtube.com/@enjoyment_digital');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enjoyment Voice Studio", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF2E7D32), // Green
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFBC02D).withOpacity(0.2), // Yellow tint
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFBC02D)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.wb_sunny, color: Color(0xFFFBC02D), size: 30),
                  SizedBox(width: 12),
                  Text("Good Day, Sunita!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Enjoyment Digital Info Card
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "About Enjoyment Digital",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "This app is made by Enjoyment Digital. Enjoyment Digital is a premier digital media brand producing creative vlogs, short dramas, AI-assisted video productions, and official music releases.",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF1976D2), // Blue
                        side: const BorderSide(color: Color(0xFF1976D2)),
                      ),
                      onPressed: _launchYouTube,
                      icon: const Icon(Icons.video_library),
                      label: const Text("Visit Our Official YouTube Channel (@enjoyment_digital)"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== AI CHAT SCREEN ====================
class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = ["Hello Sunita! I am your AI assistant. How can I help you today?"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Assistant", style: TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF1976D2)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Card(
                  color: index % 2 == 0 ? Colors.green[50] : Colors.blue[50],
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(_messages[index]),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: "Type a message...", border: OutlineInputBorder()),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFF2E7D32)),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      setState(() {
                        _messages.add(_controller.text);
                        _messages.add("AI: I am processing your request regarding enjoyment digital content!");
                        _controller.clear();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== VOICE STUDIO SCREEN ====================
class VoiceStudioScreen extends StatelessWidget {
  const VoiceStudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Voice Studio", style: TextStyle(color: Colors.white)), backgroundColor: const Color(0xFFFBC02D)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Enter podcast or voiceover script here...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E7D32), foregroundColor: Colors.white),
                onPressed: () {},
                child: const Text("Generate Voice"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== PROFILE SCREEN ====================
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Profile", style: TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF1976D2)),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(radius: 50, backgroundColor: Color(0xFFFBC02D), child: Icon(Icons.person, size: 50, color: Colors.white)),
            SizedBox(height: 16),
            Text("Sunita Sapkota", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text("sunita@gmail.com", style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 24),
            Divider(),
            ListTile(
              leading: Icon(Icons.info, color: Color(0xFF2E7D32)),
              title: Text("App Version"),
              subtitle: Text("1.0.0 (Enjoyment Digital)"),
            ),
          ],
        ),
      ),
    );
  }
}
