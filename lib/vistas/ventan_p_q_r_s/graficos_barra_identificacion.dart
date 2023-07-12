import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:proyecto_p_q_r_s/controlador/controlador_pqrs.dart';
import 'package:proyecto_p_q_r_s/flutter_flow/flutter_flow_theme.dart';
import 'package:segment_bar/percent_graph_model.dart';
import 'package:segment_bar/segment_bar.dart';

class GraficoBarraTotalIdentificacion extends StatefulWidget {
  const GraficoBarraTotalIdentificacion({Key? key});

  @override
  State<GraficoBarraTotalIdentificacion> createState() =>
      _GraficoBarraTotalIdentificacionState();
}

class _GraficoBarraTotalIdentificacionState
    extends State<GraficoBarraTotalIdentificacion> {
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
      future: loadDataFromFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          log('Error: ${snapshot.error}');
          return Icon(Icons.warning);
        } else if (snapshot.hasData) {
          final List<int> data = snapshot.data!;
          return buildChart(data);
        } else {
          return Text('No data available');
        }
      },
    );
  }

  Future<List<int>> loadDataFromFirebase() async {
    final List<Future<int>> futures = [
      ControladorPQRS().getTotalPqrsCountIdentificacion(),
      ControladorPQRS().getTotalPqrsPendienteIdentificacion(),
      ControladorPQRS().getTotalPqrsEnProcesoIdentificaion(),
      ControladorPQRS().getTotalPqrsFinalizadoIdentificaion(),
    ];

    final List<int> results = await Future.wait(futures);
    return results;
  }

  Widget buildChart(List<int> data) {
    final int totalValue = data[0]; // Valor total
    int section1Value = data[1]; // Valor de la sección 1
    int section2Value = data[2]; // Valor de la sección 2
    int section3Value = data[3]; // Valor de la sección 3

    double section1Percentage = (section1Value / totalValue) * 100;
    double section2Percentage = (section2Value / totalValue) * 100;
    double section3Percentage = (section3Value / totalValue) * 100;

    // Construye la gráfica utilizando los datos cargados
    // Ejemplo:
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
      height: 28,
      width: MediaQuery.of(context).size.width * 0.43,
      child: SegmentBar(
        segmentData: [
          SegmentBarModel(value: section1Percentage, color: FlutterFlowTheme.of(context).primary, label: (section1Percentage>0) ? 'Sin Iniciar: $section1Percentage%' : ''),
          SegmentBarModel(value: section2Percentage, color:  Color(0xFF12B07E), label: (section2Percentage>0) ? 'En Proceso: $section2Percentage%':''),
          SegmentBarModel(value: section3Percentage, color: FlutterFlowTheme.of(context).secondary, label: (section3Percentage>0) ?  "Finalizados: $section3Percentage%" : ''),
        ],
      ),
    );
      },
    );
  }

}
