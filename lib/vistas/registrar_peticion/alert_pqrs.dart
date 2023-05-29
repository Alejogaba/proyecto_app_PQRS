import 'dart:html';

import 'package:flutter/material.dart';
import 'package:proyecto_p_q_r_s/modelo/pqrs.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../controlador/controlador_pqrs.dart';
import '../../controlador/storage_helper.dart';
import '../../flutter_flow/flutter_flow_theme.dart';

class AlertPQRS {
  final pqrs pqr;

  AlertPQRS({
    required this.pqr,
  });

  void showConfirmationAlert(BuildContext context) {
    Alert(
      context: context,
      title: 'Confirmación de envío',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Primer nombre del solicitante: ${pqr.primerNombreSolicitante}'),
          Text(
              'Segundo nombre del solicitante:  ${pqr.segundoNombreSolicitante}'),
          Text(
              'Primer apellido del solicitante:  ${pqr.primerApellidoSolicitante}'),
          Text(
              'Segundo apellido del solicitante: ${pqr.segundoApellidoSolicitante}'),
          Text(
              'Tipo de identificación del solicitante:  ${pqr.tipoIdSolicitante}'),
          Text('Identificación del solicitante:  ${pqr.idSolicitante}'),
          Text('Tipo de PQRS:  ${pqr.tipoPQRS}'),
          Text('Tipo de medio de contacto: '),
          Text('Medio de contacto:  ${pqr.medioContacto}'),
          Text('Número de teléfono:  ${pqr.numTelefono}'),
          Text('Descripción:  ${pqr.descripcion}'),
          Text('Archivo adjunto:  ${pqr.nombreArchivoAdjunto}'),
        ],
      ),
      buttons: [
        DialogButton(
          child: Text('Enviar'),
          onPressed: () async {
            String? idPQR = await ControladorPQRS().guardarPQR(pqr);
            if (idPQR!=null&&idPQR.isNotEmpty) {
              String? adjuntoPQRS = window.localStorage['adjuntoPQRS'];
              if (pqr.nombreArchivoAdjunto != null) {
                if (pqr.nombreArchivoAdjunto!.isNotEmpty) {
                  await StorageHelper().subirArchivoBase64(adjuntoPQRS!, idPQR);
                }
              }
              QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  title: 'Operación realizada',
                  confirmBtnText: 'Ok',
                  confirmBtnColor: FlutterFlowTheme.of(context).info,
                  text: '${pqr.tipoPQRS} enviada correctamente');
              Navigator.pop(context);
              showSuccessAlert(context);
              window.localStorage.clear();
            }
          },
        ),
        DialogButton(
          child: Text('Corregir'),
          onPressed: () => Navigator.pop(context),
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
}
