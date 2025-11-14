import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:empresas_filtros_ej7/pages/pagina_principal.dart';
import 'package:empresas_filtros_ej7/pages/pagina_agregar_empresa.dart';

// Configuración de rutas con GoRouter
final GoRouter router = GoRouter(
  initialLocation: '/principal',
  routes: [
    GoRoute(
      path: '/principal',
      builder: (context, state) => const PaginaPrincipal(),
    ),
    GoRoute(
      path: '/agregar',
      builder: (context, state) => const PaginaAgregarEmpresa(),
    ),
  ],
);
