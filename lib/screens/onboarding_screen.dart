import 'dart:ffi' as pro;
import 'dart:ui' hide Size;

import 'package:flutter/material.dart';
import 'package:practica1/screens/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Onboarding Screen'),
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          children: [
            buildPage(
                color: Color.fromARGB(135, 194, 56, 56),
                urlImage: 'assets/Goku_SSJG.png',
                title: 'Goku SSJG',
                subtitle:
                    'Super Saiyan Dios: Goku obtiene esta forma para combatir a Bills, donde requiere que 5 Saiyajin de corazon puro le transfieran su ki por medio de un ritual. Esta forma le da a Goku el poder necesario para luchar contra un dios de la destrucción que se contiene.'),
            buildPage(
                color: Color.fromARGB(182, 36, 82, 190),
                urlImage: 'assets/Goku_SSJGB.png',
                title: 'Goku SSJGB',
                subtitle:
                    'Super Saiyan Dios Azul: Goku obtiene esta forma tras entrenar con Whiz y dominar el ki de dios que había absorbido del SSJG. Esta forma se consigue al combinar el SSJ con el ki de dios, superando al poder del SSJG. Esta forma ha sufrido incrementos de poder, como en la saga del Universo 6, donde entrena 3 años en la habitación del tiempo.'),
            buildPage(
                color: Color.fromARGB(195, 192, 230, 233),
                urlImage: 'assets/Goku_UI.png',
                title: 'Goku SSJG',
                subtitle:
                    'Esta técnica se manifiesta únicamente como una transformación en Gokū y es su forma más poderosa, trascendiendo al Super Saiyan Blue. A pesar de ello, Bills y los demás dioses reconocen la forma completa de la transformación, insinuando que podría no ser completamente exclusiva de Goku.'),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                primary: Colors.white,
                backgroundColor: Color.fromARGB(192, 64, 110, 133),
                minimumSize: const Size.fromHeight(80),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showHome', true);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => DashboardScreen()),
                );
              },
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => controller.jumpToPage(2),
                    child: const Text('Skip'),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: WormEffect(
                        spacing: 16,
                        dotColor: Colors.blueGrey,
                        activeDotColor: Colors.teal.shade700,
                      ),
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn),
                    ),
                  ),
                  TextButton(
                    onPressed: () => controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut),
                    child: const Text('Next'),
                  ),
                ],
              ),
            ),
    );
  }
}

Widget buildPage({
  required Color color,
  required String urlImage,
  required String title,
  required String subtitle,
}) =>
    Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            urlImage,
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          const SizedBox(
            height: 64,
          ),
          Text(
            title,
            style: TextStyle(
                color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              subtitle,
              style: const TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
