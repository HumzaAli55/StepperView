<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

A Flutter Widget to Add a Stepper View in your project without any problem.

## Features

Developers can add Data with a Data Model class statically or from a remote server. You can also control the number of steps you want to show.
There is "Continue", "Back" and "Finish" option available to control the flow of stepper's execution.

## Getting started

You can add this package anywhere just like any other widget.

    class HomePage extends StatefulWidget {
      const HomePage({Key? key}) : super(key: key);

      @override
      _HomePageState createState() => _HomePageState();
    }

    class _HomePageState extends State<HomePage> {
      List<StepData> stepsData = [];

      @override
      Widget build(BuildContext context) {
        return StepperView(data: stepsData,numberOfSteps: 3,);
      }

      @override
      void initState() {
        _getData();
        super.initState();
      }

      static const MethodChannel platform = MethodChannel('ads/campaign');

      Future<void> _getData() async {

        try {
          final result = await platform.invokeMethod('getCampaignData');
          var jsonData = jsonDecode(result);
          DataModel model = DataModel.fromJson(jsonData);
          setState(() {
            stepsData = model.data!;
          });
        } on PlatformException catch (e) {
          print('${e.message}');
        }
      }


    }





