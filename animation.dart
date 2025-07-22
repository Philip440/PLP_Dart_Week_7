Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => DashboardPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  ),
);

//bonus
AnimatedContainer(
  duration: Duration(milliseconds: 500),
  curve: Curves.easeInOut,
  padding: EdgeInsets.all(_showSuccess ? 20 : 10),
  decoration: BoxDecoration(
    color: _showSuccess ? Colors.green.shade200 : Colors.grey.shade100,
    borderRadius: BorderRadius.circular(10),
  ),
  child: Text("Processing...", style: TextStyle(fontSize: 16)),
)
