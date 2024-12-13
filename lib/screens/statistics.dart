import 'package:flutter/material.dart';
import 'package:myfinanceapp/helpers/colors.dart';
import 'package:myfinanceapp/helpers/size_helpers.dart';
import 'package:myfinanceapp/helpers/textstyle.dart';
import 'package:myfinanceapp/model/add_date.dart';
import 'package:myfinanceapp/model/listadata.dart';
import 'package:myfinanceapp/model/utility.dart';
import 'package:myfinanceapp/widgets/chart.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  List day = ['Día', 'Semana', 'Mes', 'Año'];
  List f = [today(), week(), month(), year()];
  List<Add_data> a = [];
  int index_color = 0;
  ValueNotifier kj = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blanco,
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: kj,
          builder: (context, dynamic value, child) {
            a = f[value];
            return custom();
          },
        ),
      ),
    );
  }

  CustomScrollView custom() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              addVerticalSpace(50),
              Text(
                'Statistics',
                style: bold(negro, 20),
              ),
              addVerticalSpace(16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(
                      4,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              index_color = index;
                              kj.value = index;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: index_color == index ? amber : blanco),
                            child: Text(
                              day[index],
                              style: medium(
                                  index_color == index ? blanco : amber, 16),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 120,
                  height: 40,
                  margin: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: gris, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Text(
                        'Expense',
                        style: medium(gris, 20),
                      ),
                      addHorizontalSpace(4),
                      Icon(
                        Icons.arrow_downward_sharp,
                        color: gris,
                      )
                    ],
                  ),
                ),
              ),
              addVerticalSpace(16),
              ChartPage(
                indexx: index_color,
              ),
              addVerticalSpace(16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Top',
                      style: medium(negro, 20),
                    ),
                    addHorizontalSpace(4),
                    Icon(
                      Icons.swap_vert,
                      size: 25,
                      color: gris,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return ListTile(
              title: Text(
                a[index].name,
                style: semibold(negro, 17),
              ),
              subtitle: Text(
                '${a[index].date.day}-${a[index].date.month}-${a[index].date.year}',
                style: regular(gris, 17),
              ),
              trailing: Text(
                '\$${a[index].monto}',
                style: medium(a[index].IN == 'Income' ? verde : rojo, 17),
              ),
            );
          }, childCount: a.length),
        ),
      ],
    );
  }
}
