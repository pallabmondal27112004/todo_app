import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todoapp/screen/HomeScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  List<String> images = ["3900527.jpg", "3912429.jpg", "4004529.jpg"];
  late PageController pageController;
  int currentPage = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentPage);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
        if (pageController.hasClients) {
          currentPage = (currentPage + 1) % images.length;
          pageController.animateToPage(
            currentPage,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE9F1FA), Color(0xFFDEE9F7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // 👇 Image Carousel
                SizedBox(
                  height: 320,
                  child: PageView(
                    controller: pageController,
                    children:
                        images.map((image) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              "assets/image/$image",
                              fit: BoxFit.cover,
                            ),
                          );
                        }).toList(),
                  ),
                ),

                // 👇 Page indicator
                SmoothPageIndicator(
                  controller: pageController,
                  count: images.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 8,
                    dotWidth: 10,
                    activeDotColor: Colors.blue.shade400,
                    dotColor: Colors.grey.shade300,
                  ),
                ),

                const SizedBox(height: 20),

                // 👇 Text Section
                Column(
                  children: const [
                    Text(
                      "Organize your tasks",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Easily manage your daily tasks and stay productive by categorizing and planning ahead.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),

                // 👇 Buttons Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        if (currentPage > 0) {
                          pageController.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.blue.shade400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      child: const Text(
                        "Back",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const Homescreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade400,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        elevation: 4,
                      ),
                      child: const Text(
                        "GET STARTED",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
