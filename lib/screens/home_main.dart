import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myfinanceapp/helpers/colors.dart';
import 'package:myfinanceapp/helpers/size_helpers.dart';
import 'package:myfinanceapp/helpers/textstyle.dart';
import 'package:myfinanceapp/model/add_date.dart';
import 'package:myfinanceapp/model/listadata.dart';
import 'package:myfinanceapp/model/utility.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  final List<String> day = [
    'Lunes',
    "Martes",
    "Miercoles",
    "Jueves",
    'Viernes',
    'Sabado',
    'Domingo'
  ];
  var history;
  final box = Hive.box<Add_data>('data');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, value, child) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(height: 430, child: _head()),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Historial de transacciones',
                        style: bold(negro, 20),
                      ),
                      Text(
                        'Ver todo',
                        style: semibold(amber, 18),
                      )
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    history = box.values.toList()[index];
                    return getList(history, index);
                  },
                  childCount: box.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget getList(Add_data history, int index) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        history.delete();
      },
      child: get(index, history),
    );
  }

  ListTile get(int index, Add_data history) {
    return ListTile(
      title: Text(
        history.name,
        style: semibold(negro, 17),
      ),
      subtitle: Text(
        '${day[history.date.weekday - 1]}  ${history.date.day}-${history.date.month}-${history.date.year}',
        style: regular(gris, 17),
      ),
      trailing: Text(
        '\$${history.monto}',
        style: medium(history.IN == 'Income' ? verde : rojo, 17),
      ),
    );
  }

  Widget _head() {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.amber.shade400,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 100,
                    right: 20,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 40,
                        width: 40,
                        color: amberclaro,
                        child: Icon(
                          Icons.notification_add,
                          color: blanco,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        addVerticalSpace(90),
                        Text(
                          'Bienvenido,',
                          style: semibold(Colors.white.withOpacity(0.8), 20),
                        ),
                        Text(
                          'Juan Perez',
                          style: bold(blanco, 25),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 200,
          left: 35,
          child: Container(
            height: 200,
            width: 350,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: amber,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(47, 125, 121, 0.3),
                  offset: Offset(0, 6),
                  blurRadius: 12,
                  spreadRadius: 6,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Balance total:',
                      style: medium(blanco, 20),
                    ),
                    Icon(
                      Icons.more_horiz,
                      color: blanco,
                    )
                  ],
                ),
                // addVerticalSpace(8),
                Text(
                  '\$ ${totals}',
                  style: bold(blanco, 25),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IngresosEgresos(
                        Icons.arrow_downward, 'Ingresos', "\$ ${income()}"),
                    IngresosEgresos(
                        Icons.arrow_upward, 'Egresos', "\$ ${expenses()}"),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Column IngresosEgresos(IconData icon, String tipo, String monto) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 13,
              backgroundColor: amberclaro,
              child: Icon(
                icon,
                color: blanco,
                size: 20,
              ),
            ),
            addHorizontalSpace(8),
            Text(
              tipo,
              style: medium(blanco, 16),
            ),
          ],
        ),
        addVerticalSpace(8),
        Text(
          monto,
          style: semibold(blanco, 20),
        ),
      ],
    );
  }
}
