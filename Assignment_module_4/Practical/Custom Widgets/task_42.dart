import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: ProgressBarExample(),
    debugShowCheckedModeBanner: false,
  ));
}

class ProgressBarExample extends StatefulWidget {
  const ProgressBarExample({super.key});

  @override
  State<ProgressBarExample> createState() => _ProgressBarExampleState();
}

class _ProgressBarExampleState extends State<ProgressBarExample> {
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Progress Bar")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                const barWidth = 250.0;
                return GestureDetector(
                  onPanUpdate: (details) {
                    final box = context.findRenderObject() as RenderBox;
                    final localPos =
                    box.globalToLocal(details.globalPosition);

                    setState(() {
                      progress = (localPos.dx / barWidth * 100).clamp(0, 100);
                    });
                  },
                  child: CustomProgressBar(percentage: progress),
                );
              },
            ),
            const SizedBox(height: 20),
            Text("Progress: ${progress.toInt()}%"),
          ],
        ),
      ),
    );
  }
}

class CustomProgressBar extends StatelessWidget {
  final double percentage;

  const CustomProgressBar({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[300],
      ),
      child: Stack(
        children: [
          Container(
            width: (percentage.clamp(0, 100) / 100) * 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.blue,
            ),
          ),
          Center(
            child: Text("${percentage.toInt()}%", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ),
        ],
      ),
    );
  }
}