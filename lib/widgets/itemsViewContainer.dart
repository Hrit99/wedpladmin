import 'dart:io';

import 'package:adminapp/providers/homePageTabChange.dart';
import 'package:flutter/material.dart';
import 'package:adminapp/providers/homePageSubTabChange.dart';
import 'package:adminapp/widgets/ItemCard.dart';
import 'package:provider/provider.dart';

class ItemsViewContainer extends StatelessWidget {
  double _getPercent(double p, double quan) {
    return ((p / 100) * quan);
  }

  @override
  Widget build(BuildContext context) {
    var subtabProvider = Provider.of<HomePageSubTabChange>(context);
    var tabProvider = Provider.of<HomePageTabChange>(context, listen: false);
    var _scrollController = new ScrollController();
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Container(
                width: _getPercent(96, constraints.maxWidth),
                child: ListView.separated(
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      return ItemCard(
                        constraints,
                        subtabProvider.whichSubcategory.items[index],
                        index,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                        color: Theme.of(context).primaryColor,
                        height: 10,
                      );
                    },
                    itemCount: subtabProvider.whichSubcategory.items.length)),
          );
        },
      ),
    );
  }
}
