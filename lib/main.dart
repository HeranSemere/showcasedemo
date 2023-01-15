import 'package:flutter/material.dart';
import 'package:flutter_showcaseview/showcaseview.dart';



void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ShowCaseWidget(
          builder: Builder(builder: (context) => const ShowcaseDemo()),
        ),
      ),
    );
  }
}

class ShowcaseDemo extends StatefulWidget {
  const ShowcaseDemo({Key? key}) : super(key: key);

  @override
  _ShowcaseDemoState createState() => _ShowcaseDemoState();
}

class _ShowcaseDemoState extends State<ShowcaseDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey _first = GlobalKey();
  final GlobalKey _second = GlobalKey();
  final GlobalKey _third = GlobalKey();
  final GlobalKey _fourth = GlobalKey();
  final GlobalKey _fifth = GlobalKey();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
            (_) =>
        {ShowCaseWidget.of(context)
            .startShowCase([_first, _second, _third, _fourth, _fifth]),
          //ShowCaseWidget.of(context).totalWidgets=12
        }

      // (_) => {
      //   CustomShowCaseWidget.of(context).startShowCase([_first, _second, _third, _fourth, _fifth]),
      //   CustomShowCaseWidget.of(context).totalWidgets=10
      //
      // },


    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.cyan,
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          leading: buildShowCaseWidget(IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),_first, "description", "1", isLast: true),
          actions: [
            Showcase(
                key: _third,
                description: 'Press to see notification',
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_active)))
          ],
          title: CustomShowcase(
              key: _second,
              currentWidgetId: 1,
              // isLast: true,
              description: 'This is a demo app title',
              buttonStyle: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)
              ),
              child: const Text('Flutter Showcase Demo')),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.cyan,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Showcase(
                  key: _fourth,
                  description:
                  'FlutterDevs specializes in creating cost-effective and efficient applications',
                  child: Image.asset(
                    "assets/logo.png",
                    height: 400,
                    width: 350,
                  )),
            ),
          ],
        ),
        // floatingActionButton: Showcase(
        //   key: _fifth,
        //   title: 'Add Image',
        //   description: 'Click here to add new Image',
        //   targetShapeBorder: const CircleBorder(),
        //   tooltipBackgroundColor: Color.fromRGBO(243,228,217,100),
        //   child: FloatingActionButton(
        //     backgroundColor: Colors.cyan,
        //     onPressed: () {},
        //     child: const Icon(
        //       Icons.image,
        //     ),
        //   ),
        // ),
        floatingActionButton: Showcase.withWidget(

          key: _fifth,
          height: 80,
          width: 140,
          container: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Color.fromRGBO(243,228,217,100),
                height: 80,
                width: 140,
                child: Column(
                  children: [
                    IconButton(
                        onPressed: (){
                          ShowCaseWidget.of(context).next();
                        },
                        icon: Icon(Icons.cancel)),
                    ElevatedButton(
                      style: const ButtonStyle(

                      ),
                      child: Text("Next"),
                      onPressed: (){
                        ShowCaseWidget.of(context).dismiss();
                        print("Clicked");
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
          targetShapeBorder: CircleBorder(),
          child: FloatingActionButton(
            backgroundColor: Colors.cyan,
            onPressed: () {},
            child: const Icon(
              Icons.image,
            ),
          ),

        )
    );
  }

  Widget buildShowCaseWidget(Widget childWidget, GlobalKey globalKey, String description, String index,
      {bool isLast = false}){
    return Showcase.withWidget(
      key: globalKey,
      height: 200,
      width: 300,
      container: Container(
        //color: Color.fromRGBO(243,228,217,100),
          height: 200,
          width: MediaQuery.of(context).size.width/1.1,
          child: Card(
            child:  Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(index+"/5"),
                      IconButton(
                          onPressed: (){
                            // CustomShowcase.of
                            ShowCaseWidget.of(context).dismiss();
                          },
                          icon: Icon(Icons.close)),
                    ],
                  ),
                  Text(description),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: const ButtonStyle(
                        ),
                        child: Text(isLast? "Done":"Next"),
                        onPressed: (){
                          isLast? ShowCaseWidget.of(context).dismiss():ShowCaseWidget.of(context).next();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )

      ),
      child: childWidget,
    );
  }
}