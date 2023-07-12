import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_p_q_r_s/controlador/controlador_pqrs.dart';

class GraficoCircularIdentificacion extends StatefulWidget {
  const GraficoCircularIdentificacion({key});

  @override
  State<GraficoCircularIdentificacion> createState() =>
      _GraficoCircularIdentificacionState();
}

class _GraficoCircularIdentificacionState
    extends State<GraficoCircularIdentificacion> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
      future: loadDataFromFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          log('Error grafico circular: ${snapshot.error}');
          return Icon(Icons.warning);
        } else if (snapshot.hasData) {
          final List<int> data = snapshot.data!;
          log('data grafico circular: ' + data.toString());
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
          height: MediaQuery.of(context).size.width * 0.1,
          width: MediaQuery.of(context).size.width * 0.1,
          child: AspectRatio(
            aspectRatio: 1.5,
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    showTitle: true,
                    value: section1Percentage,
                    color: Colors.red,
                    title: '$section1Percentage%',
                    radius: 100,
                    titleStyle: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  PieChartSectionData(
                    value: section2Percentage,
                    color: Colors.blue,
                    title: '$section2Percentage%',
                    radius: 100,
                    titleStyle: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  PieChartSectionData(
                    value: section3Percentage,
                    color: Colors.green,
                    title: '$section3Percentage%',
                    radius: 100,
                    titleStyle: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
