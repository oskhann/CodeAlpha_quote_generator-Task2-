import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'quote_service.dart';

void main() {
  runApp(QuoteApp());
}

class QuoteApp extends StatefulWidget {
  @override
  _QuoteAppState createState() => _QuoteAppState();
}

class _QuoteAppState extends State<QuoteApp> {
  String _quote = "Click the button to generate a quote!";
  String _author = "";

  void _getQuote() async {
    try {
      var quoteData = await QuoteService.fetchQuote();
      setState(() {
        _quote = quoteData['content']!;
        _author = "- " + quoteData['author']!;
      });
    } catch (e) {
      setState(() {
        _quote = "Failed to fetch quote. Try again.";
        _author = "";
      });
    }
  }

  void _shareQuote() {
    Share.share('$_quote $_author');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Random Quote Generator"),
          backgroundColor: Colors.blueAccent,
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _quote,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                _author,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _getQuote,
                child: Text("Generate Quote"),
              ),
              SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: _shareQuote,
                icon: Icon(Icons.share),
                label: Text("Share"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
