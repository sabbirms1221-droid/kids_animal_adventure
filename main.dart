import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const KidsAnimalAdventure());
}

class Animal {
  final String name;
  final String emoji;
  final String fact;

  const Animal(this.name, this.emoji, this.fact);
}

const animals = [
  Animal('Lion', '🦁', 'The lion is known as the king of the jungle.'),
  Animal('Elephant', '🐘', 'Elephants are the largest land animals.'),
  Animal('Tiger', '🐯', 'Every tiger has a unique stripe pattern.'),
  Animal('Monkey', '🐒', 'Monkeys are clever and love to climb.'),
  Animal('Giraffe', '🦒', 'Giraffes have very long necks.'),
  Animal('Panda', '🐼', 'Pandas love eating bamboo.'),
  Animal('Penguin', '🐧', 'Penguins are birds that cannot fly but can swim.'),
  Animal('Rabbit', '🐰', 'Rabbits have strong back legs for hopping.'),
];

class KidsAnimalAdventure extends StatelessWidget {
  const KidsAnimalAdventure({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kids Animal Adventure',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'sans',
        colorSchemeSeed: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF7FBF2),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kids Animal Adventure',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFB8E986), Color(0xFF7ED6A5)],
                  ),
                ),
                child: const Column(
                  children: [
                    Text('🦁 🐘 🐯', style: TextStyle(fontSize: 48)),
                    SizedBox(height: 8),
                    Text(
                      'Animal Fun!',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Learn animals by playing',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              _BigButton(
                icon: Icons.pets,
                title: 'Learn Animals',
                subtitle: 'Tap an animal and hear its name',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AnimalsPage()),
                ),
              ),
              const SizedBox(height: 12),
              _BigButton(
                icon: Icons.quiz,
                title: 'Animal Quiz',
                subtitle: 'Can you find the right animal?',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const QuizPage()),
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                '🌟 More games coming soon!',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BigButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _BigButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                child: Icon(icon, size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 3),
                    Text(subtitle),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimalsPage extends StatefulWidget {
  const AnimalsPage({super.key});

  @override
  State<AnimalsPage> createState() => _AnimalsPageState();
}

class _AnimalsPageState extends State<AnimalsPage> {
  final FlutterTts tts = FlutterTts();

  Future<void> speak(Animal animal) async {
    await tts.setLanguage('en-US');
    await tts.setSpeechRate(0.42);
    await tts.speak(animal.name);
  }

  @override
  void dispose() {
    tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Learn Animals')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: animals.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: .92,
        ),
        itemBuilder: (context, index) {
          final animal = animals[index];
          return Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            elevation: 2,
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () => speak(animal),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(animal.emoji, style: const TextStyle(fontSize: 62)),
                    const SizedBox(height: 6),
                    Text(animal.name,
                        style: const TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 6),
                    const Icon(Icons.volume_up_rounded, size: 28),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int question = 0;
  int score = 0;
  int answer = 0;

  void next() {
    if (answer == question) score++;
    if (question == animals.length - 1) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('🎉 Great Job!'),
          content: Text('Your score: $score / ${animals.length}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  question = 0;
                  score = 0;
                });
              },
              child: const Text('Play Again'),
            )
          ],
        ),
      );
    } else {
      setState(() {
        question++;
        answer = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final target = animals[question];
    return Scaffold(
      appBar: AppBar(title: const Text('Animal Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('Which animal is this?',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    )),
            const SizedBox(height: 25),
            Text(target.emoji, style: const TextStyle(fontSize: 110)),
            const SizedBox(height: 20),
            ...List.generate(3, (i) {
              final option = animals[(question + i) % animals.length];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      setState(() => answer = animals.indexOf(option));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Text(option.name,
                          style: const TextStyle(fontSize: 19)),
                    ),
                  ),
                ),
              );
            }),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: next,
                icon: const Icon(Icons.arrow_forward),
                label: const Padding(
                  padding: EdgeInsets.all(13),
                  child: Text('Next', style: TextStyle(fontSize: 18)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
