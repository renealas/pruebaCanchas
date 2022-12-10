import 'package:canchas/providers/lluviaApi.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Hace llamado a la API y Recibe un String con la Probabilidad de Lluvia',
      () async {
    DateTime selectedDate = DateTime.now();

    int num = await PredictionService().getLluvia(selectedDate);

    expect(num, greaterThanOrEqualTo(0));
  });
}
