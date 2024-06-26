import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:eut/seunghyeon/screen/register_fam_1.dart';
import 'package:eut/seunghyeon/screen/register_fin.dart';

class MyApp3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisterFamTest(),
    );
  }
}

class RegisterFamTest extends StatefulWidget {
  const RegisterFamTest({super.key});

  @override
  State<RegisterFamTest> createState() => _RegisterFamTest();
}

class _RegisterFamTest extends State<RegisterFamTest> {
  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('회원가입',
            style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Noto Sans',
                fontWeight: FontWeight.w400,
                height: 0.07),
          ),
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => RegisFam()),
              );
            },
            highlightColor: Colors.white30,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SvgPicture.asset('assets/back_button.svg'),
            ),
          ),
        ),
        body: VerificationWidget(),
      ),
    );
  }
}

class VerificationWidget extends StatefulWidget {
  const VerificationWidget({super.key});

  @override
  _VerificationWidgetState createState() => _VerificationWidgetState();
}

class _VerificationWidgetState extends State<VerificationWidget> {
  bool _isTextFieldVisible = false;
  String _buttonText = '인증번호 발송';

  final TextEditingController _controller = TextEditingController(); // 전화번호 입력 컨트롤러
  final TextEditingController _confirmController = TextEditingController(); // 인증번호 입력 컨트롤러
  Color _buttonColor = Color(0xFFE2E2E2);
  Color _buttonConfirmColor = Color(0xFFE2E2E2);
  Color _textColor = Color(0xFFAEAEAE);
  Color _textConfirmColor = Color(0xFFAEAEAE);
  void _toggleTextField() {
    if (_controller.text.length == 11 && _controller.text.runes.every((r) => r >= '0'.runes.first && r <= '9'.runes.first)) {
      setState(() {
        _buttonColor = Color(0xFFEC295D);
        _textColor = Color(0xFFEC295D);

        _buttonText = _isTextFieldVisible ? "재발송" : "인증번호 발송";
      });
    } else {
      setState(() {
        _buttonColor = Color(0xFFE2E2E2);
        _textColor = Color(0xFFAEAEAE);
      });
    }
  }

  void _toggleTextFieldConfirm() {
    if (_confirmController.text.length == 6 && _confirmController.text.runes.every((r) => r >= '0'.runes.first && r <= '9'.runes.first)) {
      setState(() {
        _buttonConfirmColor = Color(0xFFEC295D);
        _textConfirmColor = Colors.white;
      });
    } else {
      setState(() {
        _buttonConfirmColor = Color(0xFFE2E2E2);
        _textConfirmColor = Color(0xFFAEAEAE);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_toggleTextField);
    _confirmController.addListener(_toggleTextFieldConfirm);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                SvgPicture.asset('assets/icon_eut.svg'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            SizedBox(height: 80),
            Row(
              children: [
                SizedBox(width: 10),
                Text('전화번호 인증하기', style: TextStyle(color: Colors.black, fontSize: 24, fontFamily: 'Noto Sans', fontWeight: FontWeight.w600, height: 0.06)),
              ],
            ),
            SizedBox(height: 30.0),
            Row(
              children: [
                SizedBox(width: 10),
                Text('입력하신 전화번호로 인증번호가 발송됩니다.', textAlign: TextAlign.left, style: TextStyle(color: Color(0xFF4D4D4D), fontSize: 14, fontFamily: 'Noto Sans', fontWeight: FontWeight.w500)),
              ],
            ),

            SizedBox(height: 100),
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 10),
                    Container(
                      width: 195,
                      height: 52,
                      child: TextField(
                        controller: _controller,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          contentPadding: EdgeInsets.fromLTRB(18, 10, 20, 18),
                          labelText: '전화번호 입력',
                          labelStyle: TextStyle(color: Color(0xFF8F8F8F), fontSize: 18, fontFamily: 'Noto Sans', fontWeight: FontWeight.w400, height: 0.07),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 16),
                    OutlinedButton(
                      onPressed: () {
                        if (_controller.text.length == 11 && _controller.text.runes.every((r) => r >= '0'.runes.first && r <= '9'.runes.first)) {
                          setState(() {
                            _isTextFieldVisible = !_isTextFieldVisible;
                            _buttonText = "재발송";
                          });
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        minimumSize: Size(139, 52),
                        side: BorderSide(width: 1, color: _buttonColor),
                      ),
                      child: Text(_buttonText, style: TextStyle(color: _textColor, fontSize: 18, fontFamily: 'Noto Sans', fontWeight: FontWeight.w400, height: 0.07)),
                    ),
                  ],
                ),
                if (_isTextFieldVisible) SizedBox(height: 10),
                if (_isTextFieldVisible) Column(
                  children: [
                    SizedBox(width: 16, height: 20),
                    Container(
                        width: 350,
                        height: 52,
                        child: TextField(
                          controller: _confirmController,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                              contentPadding: EdgeInsets.fromLTRB(16, 10, 20, 16),
                              labelText: '인증번호',
                              labelStyle: TextStyle(color: Color(0xFF8F8F8F), fontSize: 18, fontFamily: 'Noto Sans', fontWeight: FontWeight.w400, height: 0.07),
                              hintText: '6자리 숫자를 입력하세요'
                          ),
                          keyboardType: TextInputType.number,
                        )
                    ),
                  ],
                ),
                SizedBox(height: 190),
                TextButton(
                  onPressed: _buttonConfirmColor == Color(0xFFEC295D) ? (){} : null,
                  style: TextButton.styleFrom(
                    minimumSize: Size(350, 52),
                    backgroundColor: _buttonConfirmColor,
                    foregroundColor: _textConfirmColor,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(width: 1, color: _buttonConfirmColor)),
                  ),
                  child: Text('인증 완료', style: TextStyle(color: _textConfirmColor, fontSize: 18, fontFamily: 'Noto Sans', fontWeight: FontWeight.w600, height: 0.07)),
                ),
              ],
            ),
          ],
        ),
      ),
      ],
        ),
    );
  }
}