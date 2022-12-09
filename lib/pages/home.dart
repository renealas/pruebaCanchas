// ignore_for_file: use_key_in_widget_constructors

import 'package:canchas/helpers/margin.dart';
import 'package:canchas/helpers/ui_layout.dart';
import 'package:canchas/model/reserva.dart';
import 'package:canchas/pages/reservar.dart';
import 'package:canchas/providers/reservas.dart';
import 'package:canchas/widgets/reservacion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    List<Reserva> reservas = Provider.of<Reservas>(context).reservas;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Canchas Agendadas'),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Expanded(
              child: Column(
                children: [
                  Text('Reservasiones'),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Margin.margin16(),
                      padding: const EdgeInsets.only(
                        bottom: UILayout.margin16,
                      ),
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: reservas.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (ctx, i) => Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: ReservaSection(
                          cancha: reservas[i].cancha,
                          fecha: DateFormat('dd/MMMM/yyyy', 'es_ES').format(
                            reservas[i].fecha,
                          ),
                          id: reservas[i].id,
                          probLluvia: reservas[i].precipitationProb,
                          usuario: reservas[i].persona,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Expanded(
          //   child: Container(),
          // ),
          Positioned(
            bottom: 15,
            right: 15,
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: const Duration(seconds: 0),
                      pageBuilder: (_, __, ___) => ReservarScreen(),
                    ),
                  );
                },
                child: Container(
                  width: 65,
                  height: 65,
                  padding:
                      const EdgeInsets.all(5), //EdgeInsets.only(right: 5), //
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child:
                      // Here the Heart Icon Changing
                      const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
