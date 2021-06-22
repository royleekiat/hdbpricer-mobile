import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: _index,
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        }
      },
      onStepContinue: () {
        if (_index <= 2) {
          setState(() {
            _index += 1;
          });
        }
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
        });
      },
      steps: <Step>[
        Step(
          title: const Text('What\'s behind this app?'),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                  'This application is built with Flutter and powered by a Flask backend. Prediction is done using a trained K nearest neighbours model which is retrained on a quarterly basis.')),
        ),
        Step(
          title: Text(
              'Where do I find out more about the calculations behind the predictions?'),
          content: Container(
            alignment: Alignment.centerLeft,
            child: InkWell(child: Text('Visit royleekiat.com'),
              onTap: () => launch('https://royleekiat.com'),
            )
          ),
        ),
        Step(
          title: Text(
              'I do not like the mobile version. Where do I find the Desktop Web version?'),
          content: Container(
            alignment: Alignment.centerLeft,
            child: InkWell(child: Text('Try out hdbpricer.com'),
              onTap: () => launch('http://hdbpricer.com'),
            )
          ),
        ),
        Step(
          title: Text('I would like to fork and contribute to this project.'),
          content: Container(
            alignment: Alignment.centerLeft,
            child: InkWell(child: Text('Visit github.com/royleekiat'),
              onTap: () => launch('https://github.com/royleekiat'),
            )
          ),
        ),
      ],
    );
  }
}
