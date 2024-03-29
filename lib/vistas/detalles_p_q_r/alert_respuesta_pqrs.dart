import 'dart:developer';
import 'dart:html';

import 'package:firebase_storage/firebase_storage.dart';
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
              print('generar pdf');

              var pdf = await PdfApi().generarHojaSalida(pqr, 'observacion');

              // Genera el archivo PDF en formato Uint8List
              final Uint8List pdfBytes = await pdf.save();
              String? url =
                  await uploadFileToFirebaseStorage(pdfBytes, '${pqr.id}.pdf');
              sendWhatsAppMessage('${pqr.medioContacto.toString().trim()}',
                  'Saludos de parte de la Alcaldía municipal de la Paz, esta es la respuesta a respuesta a su ${pqr.tipoPQRS} que usted realizo el día ${pqr.fechaString} con número de radicado #${pqr.id}:\n\n"${pqr.respuesta}"\n\nA continuación en el siguiente enlace encontrara una copia en formato PDF: \n$url');
               AlertDecidirEstadoPQRS(
                        contextPadre: contextPadre,
                        iconEnvio: iconEnvio,
                        mensajeEnvio: mensajeEnvio,
                        pqr: pqr)
                    .showConfirmationAlert(context);
            } else {
              if (pqr.tipoMedioContacto == 2) {
                print('generar pdf');

              var pdf = await PdfApi().generarHojaSalida(pqr, 'observacion');

              // Genera el archivo PDF en formato Uint8List
              final Uint8List pdfBytes = await pdf.save();
              String? url =
                  await uploadFileToFirebaseStorage(pdfBytes, '${pqr.id}.pdf');
                SendMail(
                    destinatario: pqr.medioContacto.toString(),
                    asunto: 'Respuesta a su ${pqr.tipoPQRS} con N° de radicado #${pqr.id}',
                    mensaje: 'Saludos de parte de la Alcaldía municipal de la Paz, esta es la respuesta a respuesta a su ${pqr.tipoPQRS} que usted realizo el día ${pqr.fechaString} con número de radicado #${pqr.id}:\n\n"${pqr.respuesta}"\n\nA continuación en el siguiente enlace encontrara una copia en formato PDF: \n$url');
              } else {
                print('generar pdf');

                var pdf = await PdfApi().generarHojaSalida(pqr, 'observacion');

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

                AlertDecidirEstadoPQRS(
                        contextPadre: contextPadre,
                        iconEnvio: iconEnvio,
                        mensajeEnvio: mensajeEnvio,
                        pqr: pqr)
                    .showConfirmationAlert(context);
              }
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

  Future<void> SendMail(
      {required String destinatario,
      required String asunto,
      required String mensaje}) async {
    try {
      final mailto = Mailto(
        to: [
          destinatario,
        ],
        cc: ['pqrd@lapazrobles-cesar.gov.co'],
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

  Future<String?> uploadFileToFirebaseStorage(
      Uint8List fileBytes, String fileName) async {
    try {
      // Obtén una referencia al almacenamiento de Firebase
      final FirebaseStorage storage = FirebaseStorage.instance;

      // Crea una referencia al archivo en Firebase Storage
      final Reference storageReference = storage.ref().child(fileName);

      // Sube el archivo
      final UploadTask uploadTask = storageReference.putData(fileBytes);

      // Espera a que se complete la carga
      await uploadTask.whenComplete(() => print('Archivo subido'));

      // Obtiene el enlace de descarga del archivo subido
      final String downloadUrl = await storageReference.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Error al subir el archivo: $e');
      return null;
    }
  }
}
