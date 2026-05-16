import 'package:flutter/material.dart';

void main() {
  runApp(const HealthApp());
}

class HealthApp extends StatelessWidget {
  const HealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Health Monitor',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),

      // Named Routes
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (_) => const DashboardPage(),
            );

          case '/heart':
            return MaterialPageRoute(
              builder: (_) => const HeartRatePage(),
            );

          case '/details':
            final int heartRate = settings.arguments as int;

            return MaterialPageRoute(
              builder: (_) => DetailsPage(
                heartRate: heartRate,
              ),
            );

          case '/feedback':
            return MaterialPageRoute(
              builder: (_) => const FeedbackPage(),
            );
        }

        return null;
      },
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String feedbackResult = "No Feedback Yet";

  Future<void> goToHeartPage() async {
    final result = await Navigator.pushNamed(
      context,
      '/heart',
    );

    if (result != null) {
      setState(() {
        feedbackResult = result.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.favorite,
              color: Colors.red,
              size: 80,
            ),

            const SizedBox(height: 20),

            const Text(
              "Smart Health Monitoring System",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: goToHeartPage,
              child: const Text("Check Heart Rate"),
            ),

            const SizedBox(height: 30),

            Text(
              "Feedback: $feedbackResult",
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeartRatePage extends StatelessWidget {
  const HeartRatePage({super.key});

  final int heartRate = 78;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Heart Rate"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.monitor_heart,
              color: Colors.red,
              size: 100,
            ),

            const SizedBox(height: 20),

            Text(
              "$heartRate BPM",
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/details',
                  arguments: heartRate,
                );
              },
              child: const Text("View Details"),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final int heartRate;

  const DetailsPage({
    super.key,
    required this.heartRate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.health_and_safety,
              color: Colors.green,
              size: 90,
            ),

            const SizedBox(height: 20),

            Text(
              "Received Heart Rate: $heartRate BPM",
              style: const TextStyle(
                fontSize: 22,
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.pushNamed(
                  context,
                  '/feedback',
                );

                Navigator.pop(context, result);
              },
              child: const Text("Give Feedback"),
            ),
          ],
        ),
      ),
    );
  }
}

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "How is your health status?",
              style: TextStyle(
                fontSize: 22,
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, "Good");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text("Good"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, "Bad");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text("Bad"),
            ),
          ],
        ),
      ),
    );
  }
}