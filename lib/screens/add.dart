import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myfinanceapp/helpers/colors.dart';
import 'package:myfinanceapp/helpers/size_helpers.dart';
import 'package:myfinanceapp/helpers/textstyle.dart';
import 'package:myfinanceapp/model/add_date.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final box = Hive.box<Add_data>('data');
  final List<String> _item = [
    'food',
    "Transfer",
    "Transportation",
    "Education"
  ];
  final List<String> _itemei = [
    'Income',
    "Expand",
  ];
  String? selctedItem;
  String? selctedItemi;
  DateTime date = DateTime.now();
  TextEditingController explain = TextEditingController();
  FocusNode ex = FocusNode();
  TextEditingController monto = TextEditingController();
  FocusNode ex1 = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ex.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blanco,
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          backgroudn(context),
          Positioned(
            top: 120,
            child: main_container(),
          )
        ],
      ),
    );
  }

  Container main_container() {
    return Container(
      height: 600,
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: blanco,
      ),
      child: Column(
        children: [
          addVerticalSpace(50),
          nombre(),
          addVerticalSpace(16),
          descrip(),
          addVerticalSpace(16),
          montocont(),
          addVerticalSpace(16),
          how(),
          addVerticalSpace(16),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2, color: gris),
            ),
            width: 300,
            child: TextButton(
              onPressed: () async {
                DateTime? newDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100));

                if (newDate == null) return;
                setState(() {
                  date = newDate;
                });
              },
              child: Text(
                'Fecha: ${date.day}/${date.month}/${date.year}',
                style: regular(negro, 16),
              ),
            ),
          ),
          addVerticalSpace(16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                var add = Add_data(date, explain.text, selctedItemi!,
                    monto.text, selctedItem!);
                box.add(add);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber.shade400,
                minimumSize: Size(double.infinity, 50),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Guardar',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container how() {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: gris),
      ),
      child: DropdownButton<String>(
        value: selctedItemi,
        onChanged: ((value) {
          setState(() {
            selctedItemi = value!;
          });
        }),
        items: _itemei
            .map((e) => DropdownMenuItem(
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Text(
                          e,
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  value: e,
                ))
            .toList(),
        selectedItemBuilder: (BuildContext context) => _itemei
            .map((e) => Row(
                  children: [Text(e)],
                ))
            .toList(),
        hint: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Text(
            'How',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        dropdownColor: Colors.white,
        isExpanded: true,
        underline: Container(),
      ),
    );
  }

  Padding montocont() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: monto,
        focusNode: ex1,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          labelText: 'Monto',
          labelStyle: regular(gris, 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: gris),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: gris),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: gris),
          ),
        ),
      ),
    );
  }

  Padding descrip() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: explain,
        focusNode: ex,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          labelText: 'Descripcion',
          labelStyle: regular(gris, 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: gris),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: gris),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: gris),
          ),
        ),
      ),
    );
  }

  Container nombre() {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: gris),
      ),
      child: DropdownButton<String>(
          items: _item
              .map((e) => DropdownMenuItem(
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            child: Image.asset('assets/${e}.png'),
                          ),
                          addHorizontalSpace(8),
                          Text(
                            e,
                            style: regular(negro, 17),
                          )
                        ],
                      ),
                    ),
                    value: e,
                  ))
              .toList(),
          hint: Text(
            'Nombre',
            style: regular(gris, 16),
          ),
          value: selctedItem,
          dropdownColor: blanco,
          isExpanded: true,
          underline: Container(),
          onChanged: ((value) {
            setState(() {
              selctedItem = value;
            });
          })),
    );
  }

  Column backgroudn(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            color: amber,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              addVerticalSpace(40),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: blanco,
                      ),
                    ),
                    Text(
                      'Agregar',
                      style: medium(blanco, 20),
                    ),
                    Icon(
                      Icons.attach_file_outlined,
                      color: blanco,
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
