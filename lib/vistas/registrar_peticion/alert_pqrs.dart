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
  final Pqrs pqr;

  AlertPQRS({
    required this.pqr,
  });

  void showConfirmationAlert(BuildContext context) {
    Alert(
      context: context,
      title: 'Confirme sus datos',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (pqr.primerNombreSolicitante != null &&
              pqr.primerNombreSolicitante!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Nombre: ',
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'Poppins',
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    '${pqr.primerNombreSolicitante} ${pqr.segundoNombreSolicitante} ${pqr.primerApellidoSolicitante} ${pqr.segundoApellidoSolicitante}',
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'Poppins',
                          fontSize: 19.0,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ],
              ),
            ),
          if (pqr.primerNombreSolicitante != null &&
              pqr.primerNombreSolicitante!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Tipo de identificación: ',
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'Poppins',
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    '${pqr.tipoIdSolicitante}',
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'Poppins',
                          fontSize: 19.0,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ],
              ),
            ),
          if (pqr.primerNombreSolicitante != null &&
              pqr.primerNombreSolicitante!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Identificación del solicitante: ',
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'Poppins',
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    '${pqr.idSolicitante}',
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'Poppins',
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'Tipo de PQRS: ',
                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                        fontFamily: 'Poppins',
                        fontSize: 19.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  '${pqr.tipoPQRS}',
                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                        fontFamily: 'Poppins',
                        fontSize: 19.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Tipo de medio de contacto:  ',
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'Poppins',
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                        )),
                Text(tipoMedioContacto(pqr.tipoMedioContacto),
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'Poppins',
                          fontSize: 19.0,
                          fontWeight: FontWeight.normal,
                        )),
              ],
            ),
          ),
          if (pqr.tipoMedioContacto < 4)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('Medio de contacto:  ',
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily: 'Poppins',
                            fontSize: 19.0,
                            fontWeight: FontWeight.bold,
                          )),
                  Text(pqr.medioContacto.toString(),
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily: 'Poppins',
                            fontSize: 19.0,
                            fontWeight: FontWeight.normal,
                          )),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Número de telefono:  ',
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'Poppins',
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                        )),
                Text(pqr.numTelefono.toString(),
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'Poppins',
                          fontSize: 19.0,
                          fontWeight: FontWeight.normal,
                        )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Descripción:  ',
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'Poppins',
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                        )),
                Text(pqr.descripcion.toString(),
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'Poppins',
                          fontSize: 19.0,
                          fontWeight: FontWeight.normal,
                        )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Archivo adjunto:  ',
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'Poppins',
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                        )),
                Text(pqr.nombreArchivoAdjunto.toString(),
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'Poppins',
                          fontSize: 19.0,
                          fontWeight: FontWeight.normal,
                        )),
              ],
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          color: FlutterFlowTheme.of(context).primary,
          child: Text('Corregir'),
          onPressed: () => Navigator.pop(context),
        ),
        DialogButton(
          color: FlutterFlowTheme.of(context).info,
          child: Text('Enviar'),
          onPressed: () async {
            String? idPQR = await ControladorPQRS().guardarPQR(pqr);
            if (idPQR != null && idPQR.isNotEmpty) {
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
