part of elevated_flex;

class Elevated extends StatelessWidget {
  const Elevated({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
