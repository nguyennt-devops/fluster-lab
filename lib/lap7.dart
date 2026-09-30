import 'package:flutter/material.dart';

void main() => runApp(const Destini());

class Destini extends StatelessWidget {
  const Destini({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const StoryPage(),
    );
  }
}

StoryBrain storyBrain = StoryBrain();

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});
  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 15.0),
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          color: Color(0xFF121212),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 12,
                child: Center(
                  child: Text(
                    storyBrain.getStory(),
                    style: const TextStyle(fontSize: 22.0, fontFamily: 'Georgia'),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      storyBrain.nextStory(1);
                    });
                  },
                  style: TextButton.styleFrom(backgroundColor: Colors.redAccent),
                  child: Text(
                    storyBrain.getChoice1(),
                    style: const TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                flex: 2,
                child: Visibility(
                  visible: !storyBrain.isEnding(),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        storyBrain.nextStory(2);
                      });
                    },
                    style: TextButton.styleFrom(backgroundColor: Colors.blueAccent),
                    child: Text(
                      storyBrain.getChoice2(),
                      style: const TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class Story {
  String storyTitle;
  String choice1;
  String choice2;

  Story({required this.storyTitle, required this.choice1, required this.choice2});
}

class StoryBrain {
  int _storyNumber = 0;

  List<Story> _storyData = [
    Story(
        storyTitle: 'Bạn đang lái xe trên một con đường vắng thì xe bị hỏng. Một người lạ ghé qua đề nghị cho bạn đi nhờ. Bạn có đi không?',
        choice1: 'Tôi sẽ đồng ý. Cảm ơn ông!',
        choice2: 'Tốt hơn là tôi nên tự sửa xe.'),
    Story(
        storyTitle: 'Người lạ mỉm cười và hỏi: "Bạn có sợ bóng tối không?".',
        choice1: 'Tôi không sợ gì cả.',
        choice2: 'Thực ra là có, ông định làm gì?'),
    Story(
        storyTitle: 'Trong lúc bạn đang sửa xe, một luồng sáng kỳ lạ xuất hiện từ trên trời. Bạn định làm gì?',
        choice1: 'Chạy vào rừng lẩn trốn.',
        choice2: 'Đứng lại quan sát luồng sáng.'),
    Story(
        storyTitle: 'Hóa ra người lạ là một phù thủy tốt bụng. Ông ấy dùng phép thuật đưa bạn về nhà an toàn. KẾT THÚC CÓ HẬU.',
        choice1: 'Chơi lại',
        choice2: ''),
    Story(
        storyTitle: 'Bạn bị lạc trong rừng sâu và không bao giờ tìm thấy đường ra. KẾT THÚC BUỒN.',
        choice1: 'Chơi lại',
        choice2: ''),
    Story(
        storyTitle: 'Luồng sáng đó là phi thuyền của người ngoài hành tinh. Bạn đã được chọn để đi du hành vũ trụ! KẾT THÚC BẤT NGỜ.',
        choice1: 'Chơi lại',
        choice2: ''),
  ];

  String getStory() => _storyData[_storyNumber].storyTitle;
  String getChoice1() => _storyData[_storyNumber].choice1;
  String getChoice2() => _storyData[_storyNumber].choice2;

  void nextStory(int choiceNumber) {
    if (choiceNumber == 1 && _storyNumber == 0) {
      _storyNumber = 1;
    } else if (choiceNumber == 2 && _storyNumber == 0) {
      _storyNumber = 2;
    } else if (choiceNumber == 1 && _storyNumber == 1) {
      _storyNumber = 3;
    } else if (choiceNumber == 2 && _storyNumber == 1) {
      _storyNumber = 4;
    } else if (choiceNumber == 1 && _storyNumber == 2) {
      _storyNumber = 4;
    } else if (choiceNumber == 2 && _storyNumber == 2) {
      _storyNumber = 5;
    } else if (_storyNumber >= 3) {
      restart();
    }
  }

  void restart() => _storyNumber = 0;

  bool isEnding() => _storyNumber >= 3;
}