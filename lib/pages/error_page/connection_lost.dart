import 'package:flutter/material.dart';

class ConnectionLostScreen extends StatelessWidget {
  const ConnectionLostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/10_Connection Lost.png",
            fit: BoxFit.cover,
            height: 200,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.12,
            left: MediaQuery.of(context).size.width * 0.065,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 5),
                    blurRadius: 25,
                    color: const Color(0xFF59618B).withOpacity(0.17),
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "retry".toUpperCase(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}