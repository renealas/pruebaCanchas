// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:canchas/providers/reservas.dart';
import 'package:canchas/widgets/alerNotificationsWOptions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReservaSection extends StatelessWidget {
  final String cancha;
  final String fecha;
  final String usuario;
  final double probLluvia;
  final String id;

  ReservaSection({
    required this.cancha,
    required this.fecha,
    required this.id,
    required this.probLluvia,
    required this.usuario,
  });

  void delete(String id, BuildContext context) {
    Provider.of<Reservas>(context, listen: false).eliminarReserva(id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Cancha:',
              ),
              Text(
                cancha,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Usuario:',
              ),
              Text(
                usuario,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '% Lluvia:',
              ),
              Text(
                '$probLluvia %',
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertNotificationWithOptions(
                  title: 'Desea Borrar Reservacion',
                  content: 'Una vez borrada se liberara su espacio',
                  positiveFun: () {
                    delete(id, context);
                    Navigator.of(context).pop();
                  },
                  positiveTitle: 'Borrar',
                ),
              );
            },
            child: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          )
        ],
      )),
    );
  }
}
