import 'package:canchas/model/reserva.dart';
import 'package:canchas/providers/reservas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  Reserva reserva = Reserva(
    id: 'dfsifhiods4748468',
    cancha: 'B',
    fecha: DateTime.now(),
    horario: 1,
    persona: 'Rene Alas',
    precipitationProb: 57.7,
  );

  test('Añade una Reserva al Provider', () {
    Builder(
      builder: (context) {
        Provider.of<Reservas>(context, listen: false).addReserva(reserva);
        var resv = Provider.of<Reservas>(context, listen: false).reservas;
        expect(resv.length, 1);
        return Container();
      },
    );
  });

  test('Busca una Reserva', () {
    Builder(
      builder: (context) {
        Provider.of<Reservas>(context, listen: false).addReserva(reserva);
        Provider.of<Reservas>(context, listen: false)
            .getReservaPorCanchaPorDia('B', DateTime.now());
        var resv =
            Provider.of<Reservas>(context, listen: false).reservasFiltradas;
        expect(resv.length, 1);
        return Container();
      },
    );
  });

  test('Elimina una Reserva', () {
    Builder(
      builder: (context) {
        Provider.of<Reservas>(context, listen: false).addReserva(reserva);
        Provider.of<Reservas>(context, listen: false)
            .eliminarReserva('dfsifhiods4748468');
        var resv = Provider.of<Reservas>(context, listen: false).reservas;
        expect(resv.length, 0);
        return Container();
      },
    );
  });
}
