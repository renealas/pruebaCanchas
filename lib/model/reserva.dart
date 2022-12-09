import 'package:flutter/cupertino.dart';

class Reserva with ChangeNotifier {
  final String id;
  final String cancha;
  final DateTime fecha;
  final int horario;
  final String persona;
  final double precipitationProb;

  Reserva({
    required this.id,
    required this.cancha,
    required this.fecha,
    required this.horario,
    required this.persona,
    required this.precipitationProb,
  });
}
