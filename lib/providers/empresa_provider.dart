import 'package:flutter/foundation.dart';
import '../models/empresa.dart';

class EmpresaProvider extends ChangeNotifier {
  final List<Empresa> _todas = [];

  // Filtros: sector, estado y provincia, y tamaño
  String _filtroSector = 'Todos';
  String _filtroEstado = 'Todas'; // 'Todas', 'Activas', 'Inactivas'
  String _filtroProvincia = 'Todas las provincias de la Comunidad Valenciana';
  String _filtroTamanyo = 'Todos'; // 'Todos', 'Micro', 'Pyme', 'Grande'

  String get filtroSector => _filtroSector;
  String get filtroEstado => _filtroEstado;
  String get filtroProvincia => _filtroProvincia;
  String get filtroTamanyo => _filtroTamanyo;

  List<Empresa> get empresasFiltradas {
    return _todas.where((e) {
      final okSector = _filtroSector == 'Todos' || e.sector == _filtroSector;
      final okProv = _filtroProvincia == 'Todas las provincias de la Comunidad Valenciana' || e.provincia == _filtroProvincia;
      final okTam = _filtroTamanyo == 'Todos' || e.tamanyo == _filtroTamanyo;
      final okEstado = switch (_filtroEstado) {
        'Activas' => e.activa,
        'Inactivas' => !e.activa,
        _ => true,
      };
      return okSector && okProv && okTam && okEstado;
    }).toList();
  }

  void cargarInicial() {
    _todas.addAll([
      Empresa(id: 1, nombre: 'TechVal', sector: 'Sector de Tecnología', provincia: 'Valencia', tamanyo: 'Pyme'),
      Empresa(id: 2, nombre: 'Costa Salud', sector: 'Sector de Salud', provincia: 'Alicante', tamanyo: 'Grande'),
      Empresa(id: 3, nombre: 'Castellón Educa', sector: 'Sector de Educación', provincia: 'Castellón', tamanyo: 'Micro'),
      Empresa(id: 4, nombre: 'IndusLevante', sector: 'Sector de Industria', provincia: 'Valencia', tamanyo: 'Pyme', activa: false),
    ]);
    notifyListeners();
  }

  // Cambios de filtros (nombres alineados con Ej6)
  void cambiarFiltroSector(String v) { _filtroSector = v; notifyListeners(); }
  void cambiarFiltroEstado(String v) { _filtroEstado = v; notifyListeners(); }
  void cambiarFiltroProvincia(String v) { _filtroProvincia = v; notifyListeners(); }
  void cambiarFiltroTamanyo(String v) { _filtroTamanyo = v; notifyListeners(); }

  // CRUD
  void alternarActiva(Empresa e) {
    final i = _todas.indexOf(e);
    if (i != -1) {
      _todas[i] = e.copyWith(activa: !e.activa);
      notifyListeners();
    }
  }

  void agregarEmpresa(Empresa e) {
    _todas.add(e);
    notifyListeners();
  }

  // Listas para desplegables (según enunciado)
  List<String> get sectores => [
    'Todos',
    'Sector de Tecnología',
    'Sector de Salud',
    'Sector de Educación',
    'Sector de Industria',
  ];

  List<String> get estados => ['Todas', 'Activas', 'Inactivas'];

  List<String> get provincias => [
    'Todas las provincias de la Comunidad Valenciana',
    'Castellón',
    'Valencia',
    'Alicante',
  ];

  List<String> get tamanos => ['Todos', 'Micro', 'Pyme', 'Grande'];
}
