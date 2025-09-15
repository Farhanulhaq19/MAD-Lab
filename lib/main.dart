import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bidding App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const MaximumBid(),
    );
  }
}

class MaximumBid extends StatefulWidget {
  const MaximumBid({super.key});

  @override
  State<MaximumBid> createState() => _MaximumBidState();
}

class _MaximumBidState extends State<MaximumBid> {
  int _currentBid = 0;
  List<int> _bidHistory = [];

  void _increaseBid() {
    setState(() {
      _currentBid += 50;
      _bidHistory.add(_currentBid);
    });

    // Show a small popup message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Bid increased to \$$_currentBid"),
        duration: const Duration(milliseconds: 600),
      ),
    );
  }

  void _resetBid() {
    setState(() {
      _currentBid = 0;
      _bidHistory.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bidding Page"),
        centerTitle: true,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Text(
                      "Current Maximum Bid",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, anim) =>
                          ScaleTransition(scale: anim, child: child),
                      child: Text(
                        "\$$_currentBid",
                        key: ValueKey<int>(_currentBid),
                        style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _increaseBid,
                          icon: const Icon(Icons.add),
                          label: const Text("Increase Bid"),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                        const SizedBox(width: 15),
                        OutlinedButton.icon(
                          onPressed: _resetBid,
                          icon: const Icon(Icons.refresh),
                          label: const Text("Reset"),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _bidHistory.isEmpty
                  ? const Text("No bids yet...",
                  style: TextStyle(fontSize: 16, color: Colors.grey))
                  : ListView.builder(
                itemCount: _bidHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.attach_money),
                    title: Text("Bid #${index + 1}: \$${_bidHistory[index]}"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}