/// Normaliza dados de geocodificação reversa sem confundir região com cidade.
/// O plugin pode retornar locality='' (não null), o que impede ?? de funcionar.
String resolveGpsCity({
  required Iterable<String?> localities,
  required Iterable<String?> subAdministrativeAreas,
}) {
  for (final raw in localities) {
    final value = (raw ?? '').trim();
    if (value.isNotEmpty) return value;
  }
  for (final raw in subAdministrativeAreas) {
    final value = (raw ?? '').trim();
    if (value.isEmpty) continue;
    // Serviços de mapas às vezes retornam "Região Metropolitana de Curitiba"
    // no lugar do município. Nesse caso o campo deve permanecer editável.
    if (RegExp(r'\b(regi[aã]o|metropolitan|mesorregi[aã]o|microrregi[aã]o)\b',
            caseSensitive: false)
        .hasMatch(value)) continue;
    return value;
  }
  return '';
}

/// Quando o CEP foi localizado pelo backend, usa o município canônico,
/// desde que não exista divergência de UF com o GPS.
String preferZipCity({
  required String gpsCity,
  required String zipCity,
  required String gpsState,
  required String zipState,
}) {
  final fromZip = zipCity.trim();
  if (fromZip.isEmpty) return gpsCity.trim();
  final gpsUf = gpsState.trim().toUpperCase();
  final zipUf = zipState.trim().toUpperCase();
  if (gpsUf.isNotEmpty && zipUf.isNotEmpty && gpsUf != zipUf) {
    return gpsCity.trim();
  }
  return fromZip;
}
