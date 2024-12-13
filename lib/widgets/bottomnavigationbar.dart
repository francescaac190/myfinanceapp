import 'package:flutter/material.dart';
import 'package:myfinanceapp/helpers/colors.dart';
import 'package:myfinanceapp/helpers/size_helpers.dart';
import 'package:myfinanceapp/screens/add.dart';
import 'package:myfinanceapp/screens/home_main.dart';
import 'package:myfinanceapp/screens/statistics.dart';

class Bottom extends StatefulWidget {
  const Bottom({super.key});

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int index = 0;
  List Screen = [
    HomeMain(),
    StatisticsPage(),
    AddPage(),
    StatisticsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen[index],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const AddPage(),
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: amber,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: blanco,
        shadowColor: gris,
        color: blanco,
        elevation: 1,
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 0;
                  });
                },
                child: Icon(
                  Icons.home,
                  size: 30,
                  color: index == 0 ? amber : gris,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 1;
                  });
                },
                child: Icon(
                  Icons.bar_chart_outlined,
                  size: 30,
                  color: index == 1 ? amber : gris,
                ),
              ),
              addHorizontalSpace(20),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 2;
                  });
                },
                child: Icon(
                  Icons.account_balance_wallet,
                  size: 30,
                  color: index == 2 ? amber : gris,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 3;
                  });
                },
                child: Icon(
                  Icons.person,
                  size: 30,
                  color: index == 3 ? amber : gris,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
