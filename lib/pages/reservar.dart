// ignore_for_file: use_key_in_widget_constructors, unnecessary_const

import 'dart:math';

import 'package:canchas/model/reserva.dart';
import 'package:canchas/pages/home.dart';
import 'package:canchas/providers/reservas.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReservarScreen extends StatefulWidget {
  @override
  State<ReservarScreen> createState() => _ReservarScreenState();
}

class _ReservarScreenState extends State<ReservarScreen> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _selectedDate;
  bool dateSelected = false;

  // Initial Selected Value
  String canchaSelected = 'A';

  // List of items in our dropdown menu
  var canchas = [
    'A',
    'B',
    'C',
  ];

  // Variables to select TimeSlot and to check if selected court and date before
  List<Reserva> reservas = [];
  bool apiCalled = false;

  // Variables to check available Times in Court
  bool tieneDisponibilidad = false;
  List<int> timeSlots = [1, 2, 3];
  late int initialTime;

  // variable usuario
  late String usuario;
  bool showUserSection = false;

  // Variable para permitir Guardado
  bool allowedToSaved = false;

  Widget disponibilidadWidget = Container();

  void checkDisponibilidad(List<Reserva> reservas) {
    if (reservas.length > 0 && reservas.length < 3) {
      reservas.forEach((element) {
        switch (element.horario) {
          case 1:
            {
              timeSlots.remove(element.horario);
              setState(() {
                initialTime = timeSlots[0];
              });
            }
            break;
          case 2:
            {
              timeSlots.remove(element.horario);
              setState(() {
                initialTime = timeSlots[0];
              });
            }
            break;
          case 3:
            {
              timeSlots.remove(element.horario);
              setState(() {
                initialTime = timeSlots[0];
              });
            }
            break;
        }
      });
      setState(() {
        tieneDisponibilidad = true;
      });
    } else if (reservas.length == 3) {
      setState(() {
        timeSlots = [];
        disponibilidadWidget = const Center(
          child: Text('No hay Disponibilidad para Datos Seleccionados'),
        );
      });
    } else {
      setState(() {
        tieneDisponibilidad = true;
        initialTime = timeSlots[0];
      });
    }
  }

  void limpiar() {
    setState(() {
      dateSelected = false;

      canchaSelected = 'A';

      canchas = [
        'A',
        'B',
        'C',
      ];

      reservas = [];
      apiCalled = false;

      tieneDisponibilidad = false;
      timeSlots = [1, 2, 3];
      initialTime;

      usuario = '';
      showUserSection = false;

      allowedToSaved = false;
    });
  }

  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  void guardar() {
    Reserva reserva = Reserva(
      id: getRandomString(15),
      cancha: canchaSelected,
      fecha: _selectedDate,
      horario: initialTime,
      persona: usuario,
      precipitationProb: 100.00,
    );

    Provider.of<Reservas>(context, listen: false).addReserva(reserva);

    limpiar();

    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(seconds: 0),
        pageBuilder: (_, __, ___) => Home(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('es_ES');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Agregar Reservacion'),
      ),
      body: dateSelected
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Fecha Seleccionado: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat('dd/MMMM/yyyy', 'es_ES').format(_selectedDate),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 25,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Seleccione Cancha: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButton(
                        // Initial Value
                        value: canchaSelected,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: canchas.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            canchaSelected = newValue!;
                            Provider.of<Reservas>(context, listen: false)
                                .getReservaPorCanchaPorDia(
                                    newValue, _selectedDate);
                            reservas =
                                Provider.of<Reservas>(context, listen: false)
                                    .reservasFiltradas;
                            checkDisponibilidad(reservas);
                            apiCalled = true;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                tieneDisponibilidad
                    ? Padding(
                        padding: const EdgeInsets.only(
                          top: 25,
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Seleccione Horario: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            DropdownButton(
                              // Initial Value
                              value: initialTime,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: timeSlots.map((int items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items.toString()),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (newValue) {
                                setState(() {
                                  initialTime = newValue!;
                                  showUserSection = true;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    : disponibilidadWidget,
                showUserSection
                    ? Padding(
                        padding: const EdgeInsets.only(
                          top: 25,
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Ingrese su Nombre: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Form(
                              key: _formKey,
                              child: Container(
                                width: 300,
                                child: TextField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Nombre',
                                  ),
                                  onChanged: ((value) {
                                    setState(() {
                                      usuario = value;
                                      allowedToSaved = true;
                                    });
                                  }),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(),
              ],
            )
          : Center(
              child: GestureDetector(
                onTap: () async {
                  _selectedDate = (await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(3050),
                  ))!;
                  setState(() {
                    _selectedDate;
                    dateSelected = true;
                  });
                },
                child: Container(
                    width: 100,
                    height: 50,
                    padding:
                        const EdgeInsets.all(5), //EdgeInsets.only(right: 5), //
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child:
                        // Here the Heart Icon Changing
                        const Center(
                      child: Text(
                        'Seleccionar Fecha',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    )),
              ),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                limpiar();
              },
              child: Container(
                  width: 100,
                  height: 50,
                  padding:
                      const EdgeInsets.all(5), //EdgeInsets.only(right: 5), //
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child:
                      // Here the Heart Icon Changing
                      const Center(
                    child: Text(
                      'Limpiar',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () {
                allowedToSaved ? guardar() : null;
              },
              child: Container(
                  width: 100,
                  height: 50,
                  padding:
                      const EdgeInsets.all(5), //EdgeInsets.only(right: 5), //
                  decoration: BoxDecoration(
                    color: allowedToSaved ? Colors.green : Colors.grey,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child:
                      // Here the Heart Icon Changing
                      Center(
                    child: Text(
                      'Guardar',
                      style: TextStyle(
                        color: allowedToSaved ? Colors.white : Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
