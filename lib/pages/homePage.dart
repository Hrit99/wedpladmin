import 'package:flutter/material.dart';
import 'package:adminapp/apis/reloadCheckApi.dart';
import 'package:adminapp/models/category.dart';
import 'package:adminapp/utils/flutter_ui_utils.dart';
import 'package:adminapp/widgets/borderSplash.dart';
import 'package:adminapp/widgets/homePageContainer.dart';
import 'package:adminapp/widgets/rangoliImg.dart';
import 'package:adminapp/apis/categoryApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _getPercent(double p, double quan) {
    return ((p / 100) * quan);
  }

  @override
  Widget build(BuildContext context) {
    Future allCategories = getAllCategories();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: BorderSplash(
        effect: false,
        child: Container(
          child: LayoutBuilder(builder: (context, constraints) {
            var smImgWidth = _getPercent(12, constraints.maxWidth);
            var smImgHeight = _getPercent(12, constraints.maxWidth);
            var smTopGap = _getPercent(3, constraints.maxHeight);
            var smLeftGap = _getPercent(50, constraints.maxWidth) -
                _getPercent(50, smImgWidth);

            return Stack(children: [
              Positioned(
                // alignment: Alignment.center,
                width: smImgWidth,
                height: smImgHeight,
                top: smTopGap,
                left: smLeftGap,
                child: RangoliImg(rangoliBuilt: () {}, timeDuration: 0),
              ),
              Positioned(
                top: smImgHeight + (2 * smTopGap),
                child: Container(
                  width: constraints.maxWidth,
                  height:
                      constraints.maxHeight - (smImgHeight + (2 * smTopGap)),
                  child: FutureBuilder(
                    future: allCategories,
                    builder: (context, snapshot) {
                      print(snapshot.data.toString());
                      if (snapshot.data != null) {
                        print("yes");
                        print(snapshot.data);
                        return HomePageContainer(snapshot.data);
                      } else {
                        print("nooo");
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ]);
          }),
        ),
      ),
    );
  }
}

// Positioned(
//   top: FlutterUiDart(context: context).getPercentHeight(7) +
//       smImgHeight,
//   left: FlutterUiDart(context: context).getPercentWidth(6),
//   child: Container(
//     width: FlutterUiDart(context: context).getPercentWidth(88),
//     height: FlutterUiDart(context: context).getPercentHeight(93) -
//         smImgHeight -
//         FlutterUiDart(context: context).getPercentWidth(6),
//     child: HomePageContainer(),
//   ),
// ),
// HomePageContainer()
