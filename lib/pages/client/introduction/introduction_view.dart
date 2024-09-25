import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/core/config.dart';
import 'package:wallpaper_app/routes/app_routes.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroductionView extends StatefulWidget {
  const IntroductionView({Key? key}) : super(key: key);

  @override
  IntroductionViewState createState() => IntroductionViewState();
}

class IntroductionViewState extends State<IntroductionView> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Get.toNamed(AppRoutes.login);
  }

  Widget _buildImage(String assetName, [double width = 210]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      infiniteAutoScroll: true,

      pages: [
        PageViewModel(
          titleWidget: Text(
            "تطبيق هاني شري وكون هاني",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Config.primaryColor),
          ),
          body: "",
          image: SizedBox(
            height: 150,
            width: 150,
            child: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/WhatsApp Image 2023-06-17 at 11.22.17 AM.jpeg')),
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 6,
            imageFlex: 6,
            safeArea: 80,
          ),
        ),
        PageViewModel(
          titleWidget: Text(
            "كومندي لي بغيتي الوقت لي بغيتي بثمن أقل",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Config.primaryColor),
          ),
          body: "",
          image: _buildImage('1694687774242.jpg'),
          decoration: pageDecoration.copyWith(
            bodyFlex: 6,
            imageFlex: 6,
            safeArea: 80,
          ),
        ),
        PageViewModel(
          titleWidget: Text(
            "يمكن ليك تختار السلعة ديالك وتكومندي بطريقة ساهلة",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Config.primaryColor),
          ),
          body: "",
          image: _buildImage('1694687774238.png'),
          decoration: pageDecoration.copyWith(
            bodyFlex: 6,
            imageFlex: 6,
            safeArea: 80,
          ),
        ),
        PageViewModel(
          titleWidget: Text(
            "التوصيل مجاني حتى لباب المحل في أقل من 24",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Config.primaryColor),
          ),
          body: "",
          image: _buildImage('1694687774233.png'),
          decoration: pageDecoration.copyWith(
            bodyFlex: 6,
            imageFlex: 6,
            safeArea: 80,
          ),
        ),
      ],
      globalFooter: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 250,
          height: 45,
          child: ElevatedButton(
            child: const Text(
              'تسجيل الدخول',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ))),
            onPressed: () => _onIntroEnd(context),
          ),
        ),
      ),
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      controlsPosition: Position(left: 0, right: 0, bottom: 60),
      showDoneButton: false,
      showNextButton: false,
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        // color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
