import 'dart:developer';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mailto/mailto.dart';
import 'package:proyecto_p_q_r_s/modelo/pqrs.dart';
import 'package:proyecto_p_q_r_s/vistas/detalles_p_q_r/alert_decidir_estado.dart';
import 'package:proyecto_p_q_r_s/vistas/detalles_p_q_r/pdfApi.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controlador/controlador_pqrs.dart';
import '../../controlador/storage_helper.dart';
import '../../flutter_flow/flutter_flow_theme.dart';

class AlertRespuestaPQRS {
  final BuildContext contextPadre;
  final Pqrs pqr;
  final IconData iconEnvio;
  final String mensajeEnvio;
  TextEditingController textControllerDescripcionPqrs =
      new TextEditingController();

  AlertRespuestaPQRS({
    required this.contextPadre,
    required this.iconEnvio,
    required this.mensajeEnvio,
    required this.pqr,
  });

  void showConfirmationAlert(BuildContext context) {
    Alert(
      context: context,
      title: 'Escriba su respuesta',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 15, 5, 5),
            child: Container(
              width: 800,
              child: TextFormField(
                controller: textControllerDescripcionPqrs,
                autofocus: true,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'Indique su respuesta a esta solicitud....',
                  hintStyle: FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily: 'Poppins',
                        fontSize: 16.0,
                      ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).secondaryText,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).secondaryText,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).error,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).error,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Poppins',
                      fontSize: 16.0,
                    ),
                maxLines: 12,
                minLines: 6,
              ),
            ),
          )
        ],
      ),
      buttons: [
        DialogButton(
          color: FlutterFlowTheme.of(context).primary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.xmark,
                  color: FlutterFlowTheme.of(context).tertiary),
              Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: Text(
                  'Cancelar',
                  style:
                      TextStyle(color: FlutterFlowTheme.of(context).tertiary),
                ),
              ),
            ],
          ),
          onPressed: () => Navigator.pop(context),
        ),
        DialogButton(
          color: FlutterFlowTheme.of(context).info,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                iconEnvio,
                color: FlutterFlowTheme.of(context).tertiary,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: Text(mensajeEnvio,
                    style: TextStyle(
                        color: FlutterFlowTheme.of(context).tertiary)),
              ),
            ],
          ),
          onPressed: () async {
            pqr.respuesta = textControllerDescripcionPqrs.text;
            // await ControladorPQRS().actualizarPQR(pqr);
            if (pqr.tipoMedioContacto == 3) {
              sendWhatsAppMessage(
                  pqr.numTelefono.toString(), pqr.respuesta.toString());
            } else {
              if (pqr.tipoMedioContacto == 2) {
                SendMail(
                    destinatario: pqr.medioContacto.toString(),
                    asunto: 'Respuesta a su ${pqr.tipoPQRS} con N°${pqr.id}',
                    mensaje: pqr.respuesta.toString());
              } else {
                print('generar pdf');
                List<Pqrs> listPqrs = [Pqrs(tipoMedioContacto: 4)];
                var pdf =
                    await PdfApi().generarHojaSalida(listPqrs, 'observacion');

                // Genera el archivo PDF en formato Uint8List
                final Uint8List pdfBytes = await pdf.save();

                // Crea un objeto Blob con los datos del PDF
                final blob = Blob([pdfBytes], 'application/pdf');

                // Crea una URL del objeto Blob
                final url = Url.createObjectUrlFromBlob(blob);

                // Crea un elemento de enlace <a> para descargar el PDF
                final anchor = AnchorElement()
                  ..href = url
                  ..download = 'mi_pdf.pdf' // Nombre del archivo PDF
                  ..style.display = 'none';

                // Agrega el elemento de enlace al cuerpo del documento
                document.body?.append(anchor);

                // Simula un clic en el enlace para iniciar la descarga
                anchor.click();

                // Remueve el elemento de enlace del cuerpo del documento
                anchor.remove();

                // Libera la URL creada para el objeto Blob
                Url.revokeObjectUrl(url);
              }
            }
            /*
            AlertDecidirEstadoPQRS(
                    contextPadre: contextPadre,
                    iconEnvio: iconEnvio,
                    mensajeEnvio: mensajeEnvio,
                    pqr: pqr)
                .showConfirmationAlert(context);*/
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

  Future<void> SendMail(
      {required String destinatario,
      required String asunto,
      required String mensaje}) async {
    try {
      final mailto = Mailto(
        to: [
          destinatario,
        ],
        cc: [
          'Alejogaba@gmail.com',
        ],
        bcc: [
          'Alejogaba_1116@hotmail.com',
        ],
        subject: asunto,
        body: mensaje,
      );

      await launch('$mailto');
    } catch (e) {
      log('message: $e');
    }
  }

  void sendWhatsAppMessage(String phoneNumber, String message) async {
    final Uri whatsappUri = Uri(
      scheme: 'https',
      host: 'api.whatsapp.com',
      path: 'send',
      queryParameters: {
        'phone': phoneNumber,
        'text': message,
      },
    );

    final String url = whatsappUri.toString();

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      throw 'No se pudo abrir WhatsApp.';
    }
  }
}
