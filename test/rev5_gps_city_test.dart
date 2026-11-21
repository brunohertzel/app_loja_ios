import 'package:flutter_test/flutter_test.dart';
import 'package:soft_ecommerce_mobile/features/store/gps_city_resolver.dart';

void main() {
  group('Cidade sugerida pelo GPS', () {
    test('locality vazia não impede fallback para município', () {
      expect(resolveGpsCity(
        localities: ['', null, '  '],
        subAdministrativeAreas: ['Pinhais'],
      ), 'Pinhais');
    });
    test('busca cidade nos outros placemarks antes de subdivisão', () {
      expect(resolveGpsCity(
        localities: ['', 'Colombo'],
        subAdministrativeAreas: ['Região Metropolitana de Curitiba'],
      ), 'Colombo');
    });
    test('não usa região metropolitana como município', () {
      expect(resolveGpsCity(
        localities: [''],
        subAdministrativeAreas: ['Região Metropolitana de Curitiba'],
      ), '');
    });
    test('cidade oficial pelo CEP tem prioridade na mesma UF', () {
      expect(preferZipCity(
        gpsCity: 'Curitiba', zipCity: 'Pinhais', gpsState: 'PR', zipState: 'PR',
      ), 'Pinhais');
    });
    test('não sobrescreve com CEP de outra UF', () {
      expect(preferZipCity(
        gpsCity: 'Pinhais', zipCity: 'Santos', gpsState: 'PR', zipState: 'SP',
      ), 'Pinhais');
    });
    test('funciona mesmo sem cidade no GPS', () {
      expect(preferZipCity(
        gpsCity: '', zipCity: 'Colombo', gpsState: 'PR', zipState: 'PR',
      ), 'Colombo');
    });
  });
}
