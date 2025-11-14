import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:empresas_filtros_ej7/providers/empresa_provider.dart';
import 'routes/rutas.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EmpresaProvider()..cargarInicial(),
      child: MaterialApp.router(
        title: 'Empresas con Filtros',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 235, 166, 37),
          ),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}
