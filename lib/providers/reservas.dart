// ignore_for_file: prefer_final_fields

import 'package:canchas/model/reserva.dart';
import 'package:flutter/cupertino.dart';

class Reservas with ChangeNotifier {
  // Lista de Reservas Completas
  List<Reserva> _reservas = [];

  List<Reserva> get reservas {
    return [..._reservas];
  }

  // Lista de Reserva Filtrada
  List<Reserva> _reservasFiltradas = [];

  List<Reserva> get reservasFiltradas {
    return [..._reservasFiltradas];
  }

  void addReserva(Reserva res) {
    _reservas.add(res);
    notifyListeners();
  }

  void getReservaPorCanchaPorDia(String cancha, DateTime fecha) {
    List<Reserva> reservaMid = _reservas;
    reservaMid.retainWhere(
        (element) => element.cancha == cancha && element.fecha == fecha);

    _reservasFiltradas = reservaMid;
    notifyListeners();
  }

  void eliminarReserva(String id) {
    _reservas.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}
