import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_expense_screen.dart';
import 'saved_expenses_screen.dart';
import 'login_screen.dart'; // Import your login screen here

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool _showButtons = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        _showButtons = true;
      });
    });
  }

  Future<void> _confirmLogout() async {
    final bool? shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout Confirmation'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      // Navigate to login page and clear navigation stack
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/bg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple.withOpacity(0.75),
                    Colors.deepPurple.shade900.withOpacity(0.85),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          // Logout button at top right
          Positioned(
            top: 40,
            right: 20,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.deepPurple,
                elevation: 12,
                shadowColor: Colors.deepPurple.withOpacity(0.6),
                side: const BorderSide(color: Colors.deepPurple),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
              ),
              onPressed: _confirmLogout, // Call confirmation dialog here
              icon: const Icon(Icons.logout, size: 22),
              label: Text(
                'Logout',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Welcome Home!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.raleway(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.8,
                      shadows: [
                        Shadow(
                          blurRadius: 30,
                          color: Colors.deepPurpleAccent.shade200,
                          offset: const Offset(0, 0),
                        ),
                        const Shadow(
                          blurRadius: 20,
                          color: Colors.black54,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    'Track your spending like a pro. Stay organized, stay stress-free.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                      height: 1.6,
                      letterSpacing: 0.9,
                      shadows: const [
                        Shadow(
                          blurRadius: 12,
                          color: Colors.black38,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  AnimatedSlide(
                    offset: _showButtons ? Offset.zero : const Offset(0, 1),
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeOutBack,
                    child: AnimatedOpacity(
                      opacity: _showButtons ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 700),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.8, end: 1),
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.elasticOut,
                        builder: (context, scale, child) {
                          return Transform.scale(
                            scale: scale,
                            child: child,
                          );
                        },
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.deepPurple,
                            elevation: 12,
                            shadowColor: Colors.deepPurple.withOpacity(0.6),
                            side: const BorderSide(color: Colors.deepPurple),
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddExpenseScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.add, size: 26),
                          label: Text(
                            'Add Expense',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  AnimatedSlide(
                    offset: _showButtons ? Offset.zero : const Offset(0, 1),
                    duration: const Duration(milliseconds: 900),
                    curve: Curves.easeOutBack,
                    child: AnimatedOpacity(
                      opacity: _showButtons ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 900),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.8, end: 1),
                        duration: const Duration(milliseconds: 900),
                        curve: Curves.elasticOut,
                        builder: (context, scale, child) {
                          return Transform.scale(
                            scale: scale,
                            child: child,
                          );
                        },
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.deepPurpleAccent,
                            elevation: 12,
                            shadowColor:
                                Colors.deepPurpleAccent.withOpacity(0.6),
                            side: const BorderSide(
                                color: Colors.deepPurpleAccent),
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SavedExpensesScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.list_alt, size: 26),
                          label: Text(
                            'See Saved Expenses',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
