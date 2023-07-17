import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:proyecto_p_q_r_s/controlador/controlador_pqrs.dart';

import '../../flutter_flow/flutter_flow_theme.dart';

class BarraCargaAnonimo extends StatefulWidget {
  final int tipo;
  final Color colorBarra;
  const BarraCargaAnonimo(
      {Key? key, required this.tipo, required this.colorBarra});

  @override
  State<BarraCargaAnonimo> createState() =>
      _BarraCargaAnonimoState(this.tipo);
}

class _BarraCargaAnonimoState extends State<BarraCargaAnonimo> {
  final int tipo;
  _BarraCargaAnonimoState(this.tipo);

  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
      future: loadDataFromFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(color: FlutterFlowTheme.of(context).info);
        } else if (snapshot.hasError) {
          log('Error: ${snapshot.error}');
          return Icon(Icons.warning);
        } else if (snapshot.hasData) {
          final List<int> data = snapshot.data!;
          log('Barra de carga: $data');

          try {
            return buildChart(data);
          } catch (e) {
            log(e.toString());
            return Icon(Icons.warning);
          }
        } else {
          return Text('No data available');
        }
      },
    );
  }

  Future<List<int>> loadDataFromFirebase() async {
    late List<Future<int>> futures;
    switch (tipo) {
      case 1:
        futures = [
          ControladorPQRS().getTotalPqrsCountAnonima(),
          ControladorPQRS().getTotalPqrsEnProcesoAnonima(),
        ];
        break;
      case 2:
        futures = [
          ControladorPQRS().getTotalPqrsCountAnonima(),
          ControladorPQRS().getTotalPqrsPendienteAnonima(),
        ];
        break;
      case 3:
        futures = [
          ControladorPQRS().getTotalPqrsCountAnonima(),
          ControladorPQRS().getTotalPqrsFinalizadoAnonima(),
        ];
        break;
      default:
        futures = [
          ControladorPQRS().getTotalPqrsCountAnonima(),
          ControladorPQRS().getTotalPqrsEnProcesoAnonima(),
        ];
    }
    final List<int> results = await Future.wait(futures);
    return results;
  }

  Widget buildChart(List<int> data) {
    final int totalValue = data[0]; // Valor total
    int section1Value = data[1]; // Valor de la sección 1

    double section1Percentage = section1Value / totalValue;

    // Construye la gráfica utilizando los datos cargados
    // Ejemplo:
    return LinearPercentIndicator(
      barRadius: Radius.circular(6),
      percent: section1Percentage,
      width: MediaQuery.of(context).size.width * 0.43,
      lineHeight: 24.0,
      animation: true,
      progressColor: this.widget.colorBarra,
      backgroundColor: FlutterFlowTheme.of(context).accent3,
      center: Text(
        '${(section1Percentage*100).toInt()}%',
        style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'Poppins',
              color: (section1Percentage<0.51) ? FlutterFlowTheme.of(context).secondaryText : FlutterFlowTheme.of(context).tertiary,
            ),
      ),
      padding: EdgeInsets.zero,
    );
  }
}
