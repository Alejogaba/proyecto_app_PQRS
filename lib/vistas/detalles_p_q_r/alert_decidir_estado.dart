import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:proyecto_p_q_r_s/index.dart';
import 'package:proyecto_p_q_r_s/modelo/pqrs.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../controlador/controlador_pqrs.dart';
import '../../controlador/storage_helper.dart';
import '../../flutter_flow/custom_snackbars.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../ventan_p_q_r_s_anonimo/ventan_p_q_r_s_widget_anonimo.dart';

class AlertDecidirEstadoPQRS {
  final BuildContext contextPadre;
  final Pqrs pqr;
  final IconData iconEnvio;
  final String mensajeEnvio;
  TextEditingController textControllerDescripcionPqrs =
      new TextEditingController();

  AlertDecidirEstadoPQRS({
    required this.contextPadre,
    required this.iconEnvio,
    required this.mensajeEnvio,
    required this.pqr,
  });

  void showConfirmationAlert(BuildContext context) {
    Alert(
      closeFunction:  () async {
            await ControladorPQRS().marcarPqrsEnProceso(pqr.id!,pqr.respuesta??'Sin respuesta/No aplica');
                 CustomSnackBars().snackBarOk(
                                                    context,
                                                    'En proceso',
                                                    'Esta ${pqr.tipoPQRS} queda en proceso');
            if (pqr.esAnonimo) {
                  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const VentanPQRSWidgetAnonimo()));
                } else {
                   Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const VentanPQRSWidget()));
                }
          },
      context: context,
      title: '¿Que desea hacer?',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Una vez enviada la respuesta, ¿Como desea marcar esta solicitud?',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Poppins',
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal,
                ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          color: Color(0xFF054E63),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right:8.0),
                child: FaIcon(FontAwesomeIcons.clock,
                    color: FlutterFlowTheme.of(context).tertiary),
              ),
              Text(
                'En Proceso',
                style: TextStyle(color: FlutterFlowTheme.of(context).tertiary),
              ),
            ],
          ),
          onPressed: () async {
            await ControladorPQRS().marcarPqrsEnProceso(pqr.id!,pqr.respuesta??'Sin respuesta/No aplica');
                 CustomSnackBars().snackBarOk(
                                                    context,
                                                    'En proceso',
                                                    'Esta ${pqr.tipoPQRS} queda en proceso');
            if (pqr.esAnonimo) {
                  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const VentanPQRSWidgetAnonimo()));
                } else {
                   Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const VentanPQRSWidget()));
                }
          },
        ),
        DialogButton(
          color: Color.fromARGB(211, 28, 138, 46),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right:4.0),
                child: FaIcon(
                  iconEnvio,
                  color: FlutterFlowTheme.of(context).tertiary,
                ),
              ),
              Text('Finalizado',
                  style:
                      TextStyle(color: FlutterFlowTheme.of(context).tertiary)),
            ],
          ),
          onPressed: () async {
            await ControladorPQRS().marcarPqrsFinalizada(pqr.id!,pqr.respuesta??'Sin respuesta/No aplica');
                CustomSnackBars().snackBarOk(
                                                    context,
                                                    'Finalizada',
                                                    '${pqr.tipoPQRS} marcada como finalizada/leída');
                if (pqr.esAnonimo) {
                  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const VentanPQRSWidgetAnonimo()));
                } else {
                   Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const VentanPQRSWidget()));
                }
                
          },
        ),
      ],
    ).show();
  }

  static void showSuccessAlert(BuildContext context) {
    Alert(
      context: context,
      title: '¡Envío exitoso!',
      desc: 'El PQR ha sido enviado correctamente.',
      buttons: [
        DialogButton(
          child: Text('Aceptar'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ).show();
  }

  String tipoMedioContacto(int opcion) {
    switch (opcion) {
      case 1:
        return 'Enviar por correspondencia a dirección';
      case 2:
        return 'Enviar al correo eléctronico';
      case 3:
        return 'Enviar al Whatsapp';
      case 4:
        return 'Reclamar en ventanilla';
      default:
        return 'Reclamar en ventanilla';
    }
  }
}
