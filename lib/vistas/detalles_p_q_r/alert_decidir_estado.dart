import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:proyecto_p_q_r_s/modelo/pqrs.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../controlador/controlador_pqrs.dart';
import '../../controlador/storage_helper.dart';
import '../../flutter_flow/flutter_flow_theme.dart';

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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FaIcon(FontAwesomeIcons.clock,
                  color: FlutterFlowTheme.of(context).tertiary),
              Text(
                'En Proceso',
                style: TextStyle(color: FlutterFlowTheme.of(context).tertiary),
              ),
            ],
          ),
          onPressed: () async {
            await ControladorPQRS().marcarPqrsEnProceso(pqr.id!);
            Get.snackbar('En proceso', 'Esta ${pqr.tipoPQRS} queda en proceso',
                duration: Duration(seconds: 5),
                margin: EdgeInsets.fromLTRB(4, 8, 4, 0),
                snackStyle: SnackStyle.FLOATING,
                backgroundColor: Color(0xFF054E63),
                icon: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                colorText: Color.fromARGB(255, 228, 219, 218));
            Navigator.of(contextPadre).pop();
          },
        ),
        DialogButton(
          color: Color.fromARGB(211, 28, 138, 46),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FaIcon(
                iconEnvio,
                color: FlutterFlowTheme.of(context).tertiary,
              ),
              Text('Finalizado',
                  style:
                      TextStyle(color: FlutterFlowTheme.of(context).tertiary)),
            ],
          ),
          onPressed: () async {
            await ControladorPQRS().marcarPqrsFinalizada(pqr.id!);
            Get.snackbar(
                'Finzalizado', '${pqr.tipoPQRS} marcada como finalizada',
                duration: Duration(seconds: 5),
                margin: EdgeInsets.fromLTRB(4, 8, 4, 0),
                snackStyle: SnackStyle.FLOATING,
                backgroundColor: Color.fromARGB(211, 28, 138, 46),
                icon: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                colorText: Color.fromARGB(255, 228, 219, 218));
                Navigator.of(contextPadre).pop();
                Navigator.of(context).pop();
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
