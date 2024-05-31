import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:table_calendar/table_calendar.dart';


class Statistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StatisticsScreen();
  }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(140.0), // 높이를 120으로 줄임
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            flexibleSpace: Padding(
              padding: EdgeInsets.only(top: 30), // 패딩을 줄임
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    SvgPicture.asset('assets/img/icon.svg', height: 80), // 아이콘 크기를 줄임
                  ],
                ),
              ),
            ),
            bottom: TabBar(
              labelColor: Colors.black,
              indicatorColor: Color(0xFF8F8F8F),
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
              tabs: [
                Tab(text: "1일"),
                Tab(text: "1주"),
                Tab(text: "1개월"),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            DayView(),
            WeekView(),
            MonthView(),
          ],
        ),
      ),
    );
  }
}
//통계쪽은 배치로 가는 것이 맞다.

// 주별 월별은 필히 batch로 빠지는 것이 낫다. todolist로
class DayView extends StatelessWidget {
  final List<Map<String, dynamic>> conversations = [
    {
      "title": "국민연금 수령 걱정에 대한 대화",
      "date": "2024. 05. 24 금요일 - 오후 2시 56분",
      "time": "02:00:25",
      "details": ["국민연금 수령 조건", "못받으면 어떡하지", "다른 연금을 받을 수 있을까?", "걱정끼치기 싫어", "도움제안 및 마무리", "예상 수령액"],
    },
    {
      "title": "내일의 날씨 및 기온에 대한 대화",
      "date": "2024. 05. 24 금요일 - 오후 4시 32분",
      "time": "00:45:12",
      "details": ["내일의 날씨 예보", "기온 변화", "적절한 옷차림 추천"],
    },
    // 추가적인 대화 요약들...
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "정우정 님의",
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "\n하루를 요약 해드릴게요!",
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            ExpandablePageView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ConversationSummary(
                    title: conversations[index]['title'],
                    date: conversations[index]['date'],
                    time: conversations[index]['time'],
                    details: List<String>.from(conversations[index]['details']),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            ScreenTimeSummary(),
            SizedBox(height: 40),
            MoodRanking(),
            Row(
              // // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // // children: [
              // //   CircularStatIndicator(value: 0.05, label: "챗봇 사용시간", isTime: true),
              // //   CircularStatIndicator(value: 0.74, label: "부정적인 사용"),
              // ],
            ),
          ],
        ),
      ),
    );
  }
}

class ConversationSummary extends StatefulWidget {
  final String title;
  final String date;
  final String time;
  final List<String> details;

  ConversationSummary({
    required this.title,
    required this.date,
    required this.time,
    required this.details,
  });

  @override
  _ConversationSummaryState createState() => _ConversationSummaryState();
}

class _ConversationSummaryState extends State<ConversationSummary> {
  bool _isExpanded = true;
  final Color defaultTextColor = Colors.black; // 기본 텍스트 색상

  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      title: ListTile(
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.date),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.access_time, size: 14),
                SizedBox(width: 4),
                Text(widget.time),
              ],
            ),
          ],
        ),

      ),
      // margin: EdgeInsets.symmetric(vertical: 8.0),
        children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "상세 대화내용",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: defaultTextColor, // 기본 색상 사용
                      ),
                    ),
                    SizedBox(height: 10),
                    ...widget.details.map((detail) => Text("• $detail", style: TextStyle(color: defaultTextColor))).toList(),
                    SizedBox(height: 10), // 간격 추가
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.date, style: TextStyle(color: defaultTextColor)),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.access_time, size: 14),
                            SizedBox(width: 4),
                            Text(widget.time, style: TextStyle(color: defaultTextColor)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
    );
  }
}

class ScreenTimeSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "총 스크린 타임",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "4시간 24분",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "오늘, 5월 24일",
                    style: TextStyle(fontSize: 14, color: Colors.pinkAccent),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    leftTitles: SideTitles(
                      showTitles: true,
                      getTextStyles: (value) => const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                      margin: 8,
                    ),
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTextStyles: (value) => const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                      margin: 8,
                      getTitles: (double value) {
                        switch (value.toInt()) {
                          case 0:
                            return '오전 12시';
                          case 1:
                            return '오전 6시';
                          case 2:
                            return '오후 12시';
                          case 3:
                            return '오후 6시';
                          default:
                            return '';
                        }
                      },
                    ),
                  ),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(y: 30, colors: [Colors.redAccent])
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(y: 90, colors: [Colors.redAccent])
                      ],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(y: 45, colors: [Colors.redAccent])
                      ],
                    ),
                    BarChartGroupData(
                      x: 3,
                      barRods: [
                        BarChartRodData(y: 20, colors: [Colors.redAccent])
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MoodRanking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '기분을 확인해보세요!',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () { Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailedEmotionStatisticsView(),
      ),
    );
    },
                child: Text(
                  '더 알아보기 >',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                EmotionWidget(percentage: 44, emotion: '걱정', imagePath: 'assets/img/worried.svg'),
                EmotionWidget(percentage: 21, emotion: '불안', imagePath: 'assets/img/anxious.svg'),
                EmotionWidget(percentage: 18, emotion: '행복', imagePath: 'assets/img/happy.svg'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EmotionWidget extends StatelessWidget {
  final int percentage;
  final String emotion;
  final String imagePath;

  const EmotionWidget({
    Key? key,
    required this.percentage,
    required this.emotion,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Column(
        children: [
          Text(
            '$percentage%',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          SvgPicture.asset(imagePath, height: 50),
          SizedBox(height: 5),
          Text(
            emotion,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}




class DetailedEmotionStatisticsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('상세 감정통계')), // 제목 가운데 정렬
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32), // 제목과 텍스트 사이 간격 조정
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '오늘 하루 ',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: '걱정',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.pinkAccent),
                    ),
                    TextSpan(
                      text: '이 많으셨네요.\n전화통화를 추천드려요!',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 32), // 텍스트와 순위 사이 간격 조정
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  EmotionDetailWidget(rank: '1순위', emotion: '걱정', imagePath: 'assets/img/worried.svg'),
                  EmotionDetailWidget(rank: '2순위', emotion: '불안', imagePath: 'assets/img/anxious.svg'),
                  EmotionDetailWidget(rank: '3순위', emotion: '행복', imagePath: 'assets/img/happy.svg'),
                ],
              ),
              SizedBox(height: 32), // 순위와 EmotionBar 사이 간격 조정
              ..._buildEmotionBars()
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildEmotionBars() {
    return [
      EmotionBar(emotion: '걱정', percentage: 44),
      EmotionBar(emotion: '불안', percentage: 21),
      EmotionBar(emotion: '행복', percentage: 18),
      EmotionBar(emotion: '분노', percentage: 7),
      EmotionBar(emotion: '당황', percentage: 6),
      EmotionBar(emotion: '슬픔', percentage: 3),
    ];
  }
}

class EmotionDetailWidget extends StatelessWidget {
  final String rank;
  final String emotion;
  final String imagePath;

  const EmotionDetailWidget({
    Key? key,
    required this.rank,
    required this.emotion,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(rank, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.pinkAccent)),
        SizedBox(height: 8),
        SvgPicture.asset(imagePath, height: 50),
        SizedBox(height: 8),
        Text(emotion, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class EmotionBar extends StatelessWidget {
  final String emotion;
  final int percentage;

  const EmotionBar({Key? key, required this.emotion, required this.percentage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0), // EmotionBar들 간 간격 조정
      child: Row(
        children: [
          Text(emotion, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          SizedBox(width: 19),
          Expanded(
            child: SizedBox(
              height: 19, // 두께 조정
              child: LinearProgressIndicator(
                value: percentage / 100.0,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
              ),
            ),
          ),
          SizedBox(width: 10),
          Text('$percentage%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.pinkAccent)),
        ],
      ),
    );
  }
}


class WeekView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage('assets/img/happy.svg'), // 이미지 경로 설정
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "부모 님은",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "행복한 한주를 보내셨습니다!",
                                  style: TextStyle(fontSize: 14, color: Colors.pinkAccent),
                                ),
                                Text(
                                  "대화내용을 확인해보세요.",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailedConversationView()),
                            );
                          },
                          child: Text(
                            "더 알아보기 >",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '최근 7일 동안 하루 평균 4시간을 대화하셨습니다.\n이번주는 지난주 보다 30분 더 대화했어요.',
                style: TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: LineChartWidget(
                title: '대화 시간',
                data: [4, 5, 6, 7, 8, 6, 5], // Example data for each day of the week
                xLabels: ['월', '화', '수', '목', '금', '토', '일'],
                yInterval: 2,
                yMax: 12,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: LineChartWidget(
                title: '부정표현 사용 비율',
                data: [10, 20, 30, 40, 50, 40, 30], // Example data for each day of the week
                xLabels: ['월', '화', '수', '목', '금', '토', '일'],
                yInterval: 30,
                yMax: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MonthView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage('assets/img/anxious.svg'), // 이미지 경로 설정
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "부모 님은",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "불안한 한달을 보내셨습니다!",
                                  style: TextStyle(fontSize: 14, color: Colors.pinkAccent),
                                ),
                                Text(
                                  "대화내용을 확인해보세요.",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailedMonthlyConversationView()),
                            );
                          },
                          child: Text(
                            "더 알아보기 >",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '이번달 동안 하루 평균 2시간을 대화하셨습니다.\n이번달은 지난달 보다 50분 덜 대화했어요.',
                style: TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: LineChartWidget(
                title: '대화 시간',
                data: [4, 5, 6, 7, 8], // Example data for each week of the month
                xLabels: ['1주', '2주', '3주', '4주', '5주'],
                yInterval: 2,
                yMax: 12,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: LineChartWidget(
                title: '부정표현 사용 비율',
                data: [10, 20, 30, 40, 50], // Example data for each week of the month
                xLabels: ['1주', '2주', '3주', '4주', '5주'],
                yInterval: 30,
                yMax: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class DetailedMonthlyConversationView extends StatefulWidget {
  @override
  _DetailedMonthlyConversationViewState createState() => _DetailedMonthlyConversationViewState();
}

class _DetailedMonthlyConversationViewState extends State<DetailedMonthlyConversationView> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Map<DateTime, List<Map<String, String>>> _events = {
    DateTime.utc(2024, 5, 24): [
      {
        'title': '국민연금 수령 걱정에 대한 대화',
        'date': '2024. 05. 24 금요일 - 오후 2시 56분',
        'duration': '02:00:25',
      },
      {
        'title': '내일의 날씨 및 기온에 대한 대화',
        'date': '2024. 05. 24 금요일 - 오후 4시 32분',
        'duration': '00:45:12',
      },
    ],
    DateTime.utc(2024, 5, 25): [
      {
        'title': '퇴직 후 사회적 고립에 대한 고민',
        'date': '2024. 05. 25 토요일 - 오후 5시 30분',
        'duration': '01:30:34',
      },
      {
        'title': '저녁메뉴 추천에 대한 대화',
        'date': '2024. 05. 25 토요일 - 오후 7시 24분',
        'duration': '00:09:33',
      },
    ],
  };

  List<Map<String, String>> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('월간 요약 정보'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarFormat: CalendarFormat.month,
              eventLoader: _getEventsForDay,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            if (_selectedDay != null) ...[
              Padding(
                padding: const EdgeInsets.all(.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${_selectedDay!.year}년 ${_selectedDay!.month}월 ${_selectedDay!.day}일',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ..._getEventsForDay(_selectedDay!).map((event) => ConversationCard(
                title: event['title']!,
                date: event['date']!,
                duration: event['duration']!,
              )),
            ],
          ],
        ),
      ),
    );
  }
}

class ConversationCard extends StatelessWidget {
  final String title;
  final String date;
  final String duration;

  const ConversationCard({
    Key? key,
    required this.title,
    required this.date,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.access_time, size: 14),
                SizedBox(width: 4),
                Text(duration),
              ],
            ),
          ],
        ),
        trailing: Icon(Icons.expand_more),
        onTap: () {
          // 상세 내용을 보여줄 수 있는 기능 추가
        },
      ),
    );
  }
}



class DetailedConversationView extends StatefulWidget {
  @override
  _DetailedConversationViewState createState() => _DetailedConversationViewState();
}

class _DetailedConversationViewState extends State<DetailedConversationView> {
  int selectedDayIndex = 4; // 금요일을 기본으로 선택
  int selectedDay = 24; // 기본 선택된 날짜
  String selectedDayOfWeek = '금'; // 기본 선택된 요일

  final List<List<Map<String, dynamic>>> weeklyConversations = [
    // 월요일 데이터
    [
      {
        'title': '월요일 대화 1',
        'date': '2024. 05. 20 월요일 - 오전 10시 00분',
        'duration': '01:00:00',
        'details': ["길가다가 영기 엄마를","만났는데 텃발에","고구마를 키운데"],
      },
      {
        'title': '월요일 대화 2',
        'date': '2024. 05. 20 월요일 - 오후 2시 00분',
        'duration': '02:00:00',
        'details':["영기 엄마가","상추에 물을 많이 주면","상한다더라"],
      },
    ],
    // 화요일 데이터
    [
      {
        'title': '화요일 대화 1',
        'date': '2024. 05. 21 화요일 - 오전 9시 30분',
        'duration': '00:45:00',
        'detail':["영기 엄마가","상추를 뽑아서 ","준데"]
      },
      {
        'title': '화요일 대화 2',
        'date': '2024. 05. 21 화요일 - 오후 1시 00분',
        'duration': '01:15:00',
        'detail':["영기 엄마가"," 상추 맛있었냐고 물어봄"]
      },
    ],
    // 수요일 데이터
    [
      {
        'title': '수요일 대화 1',
        'date': '2024. 05. 22 수요일 - 오전 11시 00분',
        'duration': '01:30:00',
      },
    ],
    // 목요일 데이터
    [
      {
        'title': '목요일 대화 1',
        'date': '2024. 05. 23 목요일 - 오전 8시 00분',
        'duration': '00:30:00',
      },
    ],
    // 금요일 데이터
    [
      {
        'title': '국민연금 수령 걱정에 대한 대화',
        'date': '2024. 05. 24 금요일 - 오후 2시 56분',
        'duration': '02:00:25',
      },
      {
        'title': '내일의 날씨 및 기온에 대한 대화',
        'date': '2024. 05. 24 금요일 - 오후 4시 32분',
        'duration': '00:45:12',
      },
      {
        'title': '퇴직 후 사회적 고립에 대한 고민',
        'date': '2024. 05. 24 금요일 - 오후 5시 30분',
        'duration': '01:30:34',
      },
      {
        'title': '저녁메뉴 추천에 대한 대화',
        'date': '2024. 05. 24 금요일 - 오후 7시 24분',
        'duration': '00:09:33',
      },
    ],
    // 토요일 데이터
    [
      {
        'title': '토요일 대화 1',
        'date': '2024. 05. 25 토요일 - 오전 10시 00분',
        'duration': '00:50:00',
      },
    ],
    // 일요일 데이터
    [
      {
        'title': '일요일 대화 1',
        'date': '2024. 05. 26 일요일 - 오후 3시 00분',
        'duration': '01:20:00',
      },
    ],
  ];

  List<Map<String, dynamic>> getConversationsForSelectedDay() {
    return weeklyConversations[selectedDayIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('주간 요약 정보'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 주간 달력
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(7, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDayIndex = index;
                        selectedDay = 20 + index;
                        selectedDayOfWeek = ['월', '화', '수', '목', '금', '토', '일'][index];
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          ['월', '화', '수', '목', '금', '토', '일'][index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: selectedDayIndex == index ? Colors.pinkAccent : Colors.grey[300],
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${20 + index}',
                              style: TextStyle(
                                color: selectedDayIndex == index ? Colors.white : Colors.black,
                                fontWeight: selectedDayIndex == index ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            Divider(),
            // 요약된 대화 카드
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '2024년 5월 $selectedDay일 ($selectedDayOfWeek)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  ExpandablePageView.builder(
                    itemCount: getConversationsForSelectedDay().length,
                    itemBuilder: (context, index) {
                      var conversation = getConversationsForSelectedDay()[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ConversationSummary(
                          title: conversation['title'],
                          date: conversation['date'],
                          time: conversation['duration'],
                          details: List<String>.from(conversation['details'] ?? []),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String label;
  final int percentage;
  final Color color;

  const StatCard({Key? key, required this.label, required this.percentage, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Text('$percentage%', style: TextStyle(color: Colors.white)),
        ),
        title: Text(label),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ),
    );
  }
}

class LineChartWidget extends StatelessWidget {
  final String title;
  final List<double> data;
  final List<String> xLabels;
  final double yInterval;
  final double yMax;

  const LineChartWidget({
    Key? key,
    required this.title,
    required this.data,
    required this.xLabels,
    required this.yInterval,
    required this.yMax,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: true, drawVerticalLine: true, horizontalInterval: yInterval),
              titlesData: FlTitlesData(
                leftTitles: SideTitles(
                  showTitles: true,
                  interval: yInterval,
                  getTitles: (value) {
                    return value.toInt().toString();
                  },
                ),
                bottomTitles: SideTitles(
                  showTitles: true,
                  getTitles: (value) {
                    if (value.toInt() < xLabels.length) {
                      return xLabels[value.toInt()];
                    } else {
                      return '';
                    }
                  },
                ),
              ),
              borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d))),
              lineBarsData: [
                LineChartBarData(
                  spots: data.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList(),
                  isCurved: true,
                  colors: [Colors.orange],
                  barWidth: 4,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: true),
                ),
              ],
              minY: 0,
              maxY: yMax,
            ),
          ),
        ),
      ],
    );
  }
}

