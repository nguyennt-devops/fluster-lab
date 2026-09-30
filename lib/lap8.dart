import 'package:flutter/material.dart';
import 'dart:math';

const kActiveCardColour = Color(0xFF1D1E33);
const kInactiveCardColour = Color(0xFF111328);
const kBottomContainerColour = Color(0xFFEB1555);

const kLabelTextStyle =
TextStyle(fontSize: 16.0, color: Color(0xFF8D8E98));
const kNumberTextStyle =
TextStyle(fontSize: 36.0, fontWeight: FontWeight.w900);
const kLargeButtonTextStyle =
TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold);
const kTitleTextStyle =
TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold);
const kResultTextStyle = TextStyle(
    color: Color(0xFF24D876),
    fontSize: 20.0,
    fontWeight: FontWeight.bold);
const kBMITextStyle =
TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold);
const kBodyTextStyle = TextStyle(fontSize: 18.0);

enum Gender { male, female }

void main() => runApp(const BMICalculator());

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
      ),
      home: const InputPage(),
    );
  }
}

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender? selectedGender;
  int height = 170;
  int weight = 60;
  int age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMI CALCULATOR')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _buildGender()),
            Expanded(child: _buildHeight()),
            Expanded(child: _buildWeightAge()),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildGender() {
    return Row(
      children: [
        Expanded(
          child: ReusableCard(
            colour: selectedGender == Gender.male
                ? kActiveCardColour
                : kInactiveCardColour,
            onTap: () => setState(() => selectedGender = Gender.male),
            child: const IconContent(icon: Icons.male, label: 'MALE'),
          ),
        ),
        Expanded(
          child: ReusableCard(
            colour: selectedGender == Gender.female
                ? kActiveCardColour
                : kInactiveCardColour,
            onTap: () => setState(() => selectedGender = Gender.female),
            child: const IconContent(icon: Icons.female, label: 'FEMALE'),
          ),
        ),
      ],
    );
  }

  Widget _buildHeight() {
    return ReusableCard(
      colour: kActiveCardColour,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('HEIGHT', style: kLabelTextStyle),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(height.toString(), style: kNumberTextStyle),
              const SizedBox(width: 5),
              const Text('cm', style: kLabelTextStyle),
            ],
          ),
          Slider(
            value: height.toDouble(),
            min: 120,
            max: 220,
            onChanged: (v) => setState(() => height = v.round()),
          ),
        ],
      ),
    );
  }

  Widget _buildWeightAge() {
    return Row(
      children: [
        Expanded(child: _buildCounter('WEIGHT', weight, (v) => weight = v)),
        Expanded(child: _buildCounter('AGE', age, (v) => age = v)),
      ],
    );
  }

  Widget _buildCounter(String label, int value, Function(int) setVal) {
    return ReusableCard(
      colour: kActiveCardColour,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: kLabelTextStyle),
          Text(value.toString(), style: kNumberTextStyle),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundIconButton(
                icon: Icons.remove,
                onPressed: () => setState(() => setVal(value - 1)),
              ),
              const SizedBox(width: 10),
              RoundIconButton(
                icon: Icons.add,
                onPressed: () => setState(() => setVal(value + 1)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return GestureDetector(
      onTap: () {
        final calc = CalculatorBrain(height: height, weight: weight);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ResultsPage(
              bmi: calc.calculateBMI(),
              result: calc.getResult(),
              interpretation: calc.getInterpretation(),
            ),
          ),
        );
      },
      child: Container(
        height: 60,
        width: double.infinity,
        color: kBottomContainerColour,
        child: const Center(
          child: Text('CALCULATE', style: kLargeButtonTextStyle),
        ),
      ),
    );
  }
}

class ResultsPage extends StatelessWidget {
  final String bmi;
  final String result;
  final String interpretation;

  const ResultsPage(
      {super.key,
        required this.bmi,
        required this.result,
        required this.interpretation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RESULT')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                  child:
                  Text('Your Result', style: kTitleTextStyle)),
            ),
            Expanded(
              flex: 4,
              child: ReusableCard(
                colour: kActiveCardColour,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(result, style: kResultTextStyle),
                    Text(bmi, style: kBMITextStyle),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        interpretation,
                        textAlign: TextAlign.center,
                        style: kBodyTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 60,
                width: double.infinity,
                color: kBottomContainerColour,
                child: const Center(
                  child: Text('RE-CALCULATE',
                      style: kLargeButtonTextStyle),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CalculatorBrain {
  final int height;
  final int weight;

  CalculatorBrain({required this.height, required this.weight});

  double _bmi = 0;

  String calculateBMI() {
    _bmi = weight / pow(height / 100, 2);
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi >= 25) return 'Overweight';
    if (_bmi >= 18.5) return 'Normal';
    return 'Underweight';
  }

  String getInterpretation() {
    if (_bmi >= 25) return 'Exercise more!';
    if (_bmi >= 18.5) return 'Good job!';
    return 'Eat more!';
  }
}

class ReusableCard extends StatelessWidget {
  final Color colour;
  final Widget child;
  final VoidCallback? onTap;

  const ReusableCard(
      {super.key, required this.colour, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: colour,
            borderRadius: BorderRadius.circular(10),
          ),
          child: child,
        ),
      ),
    );
  }
}

class IconContent extends StatelessWidget {
  final IconData icon;
  final String label;

  const IconContent({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 60),
        const SizedBox(height: 10),
        Text(label, style: kLabelTextStyle),
      ],
    );
  }
}

class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const RoundIconButton(
      {super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      constraints: const BoxConstraints.tightFor(width: 45, height: 45),
      shape: const CircleBorder(),
      fillColor: const Color(0xFF4C4F5E),
      child: Icon(icon),
    );
  }
}