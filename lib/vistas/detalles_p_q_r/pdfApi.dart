import 'dart:developer';
import 'dart:html';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:proyecto_p_q_r_s/modelo/pqrs.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../flutter_flow/flutter_flow_util.dart';

class PdfApi {
  final PdfColor baseColor = PdfColor.fromHex('000000');
  final PdfColor accentColor = PdfColor.fromHex('1b800b');
  final PdfColor _accentTextColor = PdfColor.fromHex('000000');
  Uint8List? _logo1;
  Uint8List? _logo2;

  Future<Document> generarHojaSalida(Pqrs pqr, String observacion,
      {String numConsecutivo = 'GTI - 000', bcontext}) async {
    final Document pdf = Document();
    double alturaPrimeraFila = 3;
    double alturaFilas = 1;
    double separacionAltura = 1;
    _logo1 = (await rootBundle.load('assets/images/logo-jagua-1.jpg'))
        .buffer
        .asUint8List();
    _logo2 = (await rootBundle.load('assets/images/logo-jagua-2.jpg'))
        .buffer
        .asUint8List();
    pdf.addPage(MultiPage(
      footer: _buildFooter,
      margin: const EdgeInsets.only(
          left: 2.5 * PdfPageFormat.cm,
          right: 2.5 * PdfPageFormat.cm,
          bottom: 0.6 * PdfPageFormat.cm,
          top: 0.6 * PdfPageFormat.cm),
      pageFormat: PdfPageFormat.letter,
      build: (context) => [
        Row(children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(10),
            height: alturaPrimeraFila * PdfPageFormat.cm,
            decoration: BoxDecoration(
                border: Border(
              left: BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
              right: BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
              top: BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
              bottom: BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
            )),
            child: Container(
              alignment: pw.Alignment.center,
              padding: const pw.EdgeInsets.only(bottom: 0),
              height: 80,
              child: _logo1 != null
                  ? pw.Image(MemoryImage(_logo1!) as pw.ImageProvider)
                  : pw.PdfLogo(),
            ),
          )),
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(10),
            height: alturaPrimeraFila * PdfPageFormat.cm,
            decoration: BoxDecoration(
                border: Border(
              left: BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
              right: BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
              top: BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
              bottom: BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
            )),
            child: Container(
              alignment: pw.Alignment.center,
              padding: const pw.EdgeInsets.only(bottom: 0),
              height: 80,
              child: Text(
                  'REGISTRO DE QUEJA, RECLAMO, SUGERENCIA O FELICITACIÓN',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
            ),
          )),
          Expanded(
              child: Container(
                  padding: const EdgeInsets.all(2),
                  height: alturaPrimeraFila * PdfPageFormat.cm,
                  decoration: BoxDecoration(
                      border: Border(
                    left: BorderSide(
                        width: 0.5, color: PdfColor.fromHex("000000")),
                    right: BorderSide(
                        width: 0.5, color: PdfColor.fromHex("000000")),
                    top: BorderSide(
                        width: 0.5, color: PdfColor.fromHex("000000")),
                    bottom: BorderSide(
                        width: 0.5, color: PdfColor.fromHex("000000")),
                  )),
                  child: Container(
                    alignment: pw.Alignment.topLeft,
                    padding: const pw.EdgeInsets.only(bottom: 0),
                    height: 80,
                    child: Text('Radicación: ${pqr.descripcion}',
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            fontSize: 9, fontWeight: FontWeight.normal),
                        textAlign: TextAlign.justify),
                  ))),
        ]),
        SizedBox(height: separacionAltura * PdfPageFormat.cm),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildTextJustificado(
                  "1. DATOS PETICIONARIO", 10, FontWeight.normal),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                  padding: const EdgeInsets.only(left: 150, right: 10),
                  child: Container(
                      alignment: Alignment.center,
                      height: 27,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border(
                            left: BorderSide(
                                width: 0.5, color: PdfColor.fromHex("000000")),
                            right: BorderSide(
                                width: 0.5, color: PdfColor.fromHex("000000")),
                            top: BorderSide(
                                width: 0.5, color: PdfColor.fromHex("000000")),
                            bottom: BorderSide(
                                width: 0.5, color: PdfColor.fromHex("000000")),
                          )),
                      child: Container(
                        alignment: pw.Alignment.center,
                        child: Text('Fecha: ${pqr.fechaString}',
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border(
                          left: BorderSide(
                              width: 0.5, color: PdfColor.fromHex("000000")),
                          right: BorderSide(
                              width: 0.5, color: PdfColor.fromHex("000000")),
                          top: BorderSide(
                              width: 0.5, color: PdfColor.fromHex("000000")),
                          bottom: BorderSide(
                              width: 0.5, color: PdfColor.fromHex("000000")),
                        )),
                    child: Row(children: [
                      Container(
                        alignment: pw.Alignment.topLeft,
                        child: Text('ANÓNIMO',
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4, left: 4),
                        child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border: Border(
                                  left: BorderSide(
                                      width: 0.5,
                                      color: PdfColor.fromHex("000000")),
                                  right: BorderSide(
                                      width: 0.5,
                                      color: PdfColor.fromHex("000000")),
                                  top: BorderSide(
                                      width: 0.5,
                                      color: PdfColor.fromHex("000000")),
                                  bottom: BorderSide(
                                      width: 0.5,
                                      color: PdfColor.fromHex("000000")),
                                )),
                            child: Container(
                              height: 11,
                              width: 11,
                              alignment: pw.Alignment.center,
                              padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                              child: Text(pqr.esAnonimo ? 'X' : '',
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal),
                                  textAlign: TextAlign.center),
                            )),
                      ),
                    ]),
                  ),
                ),
              ]),
            ]),
        SizedBox(height: 0.2 * PdfPageFormat.cm),
        Row(children: [
          Container(
            width: 200,
            padding: const EdgeInsets.all(10),
            height: alturaFilas * PdfPageFormat.cm,
            decoration: BoxDecoration(
                border: Border(
              left: BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
              right: BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
              top: BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
              bottom: BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
            )),
            child: Container(
              alignment: pw.Alignment.center,
              padding: const pw.EdgeInsets.only(bottom: 0),
              height: 80,
              child: Text('NOMBRES Y APELLIDOS:',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center),
            ),
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(10),
            height: alturaFilas * PdfPageFormat.cm,
            decoration: BoxDecoration(
                border: Border(
              left: BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
              right: BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
              top: BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
              bottom: BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
            )),
            child: Container(
              alignment: pw.Alignment.center,
              padding: const pw.EdgeInsets.only(bottom: 0),
              height: 80,
              child: Text('${pqr.primerNombreSolicitante} ${pqr.segundoNombreSolicitante} ${pqr.primerApellidoSolicitante} ${pqr.segundoApellidoSolicitante} ',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center),
            ),
          )),
        ]),
        Row(children: [
          Container(
            width: 200,
            padding: const EdgeInsets.all(10),
            height: alturaFilas * PdfPageFormat.cm,
            decoration: BoxDecoration(
                border: Border(
              left: BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
              right: BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
              top: BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
              bottom: BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
            )),
            child: Container(
              alignment: pw.Alignment.center,
              padding: const pw.EdgeInsets.only(bottom: 0),
              height: 80,
              child: Text('Documento de Identidad:',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center),
            ),
          ),
          Container(
            width: 200,
            padding: const EdgeInsets.all(10),
            height: alturaFilas * PdfPageFormat.cm,
            decoration: BoxDecoration(
                border: Border(
              left: BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
              right: BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
              top: BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
              bottom: BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
            )),
            child: Container(
              alignment: pw.Alignment.center,
              padding: const pw.EdgeInsets.only(bottom: 0),
              height: 80,
              child: Text('${pqr.tipoIdSolicitante}',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center),
            ),
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(10),
            height: alturaFilas * PdfPageFormat.cm,
            decoration: BoxDecoration(
                border: Border(
              left: BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
              right: BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
              top: BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
              bottom: BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
            )),
            child: Container(
              alignment: pw.Alignment.center,
              padding: const pw.EdgeInsets.only(bottom: 0),
              height: 80,
              child: Text('${pqr.idSolicitante}',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center),
            ),
          )),
        ]),
        buildTextJustificado(
                  "1. DATOS PETICIONARIO", 10, FontWeight.normal),
        SizedBox(height: separacionAltura * PdfPageFormat.cm),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            buildTextJustificado("Señor", 11, FontWeight.bold),
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border(
                  left:
                      BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
                  right:
                      BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
                  top:
                      BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
                  bottom:
                      BorderSide(width: 0.5, color: PdfColor.fromHex("000000")),
                )),
                child: Column(children: [
                  Text('Consecutivo:          ',
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left),
                  Text(numConsecutivo,
                      style: TextStyle(
                          fontSize: 11, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center),
                ]))
          ]),
          buildTextJustificado(
              "_________________________________", 11, FontWeight.bold),
          buildTextJustificado("Celador - Vigilante ", 11, FontWeight.bold),
          buildTextJustificado(
              "Centro Administrativo Municipal - CAM", 11, FontWeight.bold),
          buildTextJustificado(
              "La Jagua de Ibirico, Cesar", 11, FontWeight.bold),
        ]),
        SizedBox(height: separacionAltura * PdfPageFormat.cm),
        buildTextJustificado(
            "REF: SALIDA DE EQUIPOS TECNOLOGICOS.", 11, FontWeight.bold),
        SizedBox(height: separacionAltura * PdfPageFormat.cm),
        buildTextJustificado(
            "Mediante la presente se le informa la autorización para la salida de los equipos a continuación:",
            12,
            FontWeight.normal),
        SizedBox(height: separacionAltura * PdfPageFormat.cm),
        //buildTableActivoPrestamo(listaActivo, funcionarioArea),
        SizedBox(height: 0.5 * PdfPageFormat.cm),
        //buildTableObservacion(observacion),
        SizedBox(height: 0.5 * PdfPageFormat.cm),
        buildTextJustificado("Cordialmente.", 11, FontWeight.normal),
        SizedBox(height: 2 * PdfPageFormat.cm),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          buildTextJustificado(
              "_________________________________", 11, FontWeight.bold),
          buildTextJustificado(
              "ALBA PATRICIA AMADOR OROZCO", 11, FontWeight.bold),
          buildTextJustificado("Jefe oficina de las Tic", 11, FontWeight.bold),
        ]),
      ],
    ));

    return pdf;
  }

  static Future<void> saveDocumentDesktop({
    String? name,
    Document? pdf,
  }) async {
    String? pickedFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Seleccione a ruta donde desea guardar el archivo:',
        fileName: name,
        type: FileType.custom,
        allowedExtensions: ['pdf']);

    if (pickedFile != null) {
      String extension = pickedFile.split('.').last;
      if (extension != 'pdf') {
        pickedFile = '$pickedFile.pdf';
      }
    } else {
      return null;
    }
  }

  pw.Widget _buildFooter(pw.Context context, {bool contarPag = true}) {
    double altura = 10;
    return pw.Column(
      children: [
        if (contarPag)
          pw.Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Center(
                  child: Text('- ${context.pageNumber} -',
                      style: const TextStyle(fontSize: 11),
                      textAlign: TextAlign.center),
                )
              ]),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Container(
                    height: 20,
                    padding: const pw.EdgeInsets.only(),
                    alignment: pw.Alignment.bottomLeft,
                    child: pw.Text(
                      ' ',
                      style: pw.TextStyle(
                        color: baseColor,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  pw.Container(
                    height: altura,
                    padding: const pw.EdgeInsets.only(),
                    alignment: pw.Alignment.bottomLeft,
                    child: pw.Text(
                      'EL PUEBLO PRIMERO',
                      style: pw.TextStyle(
                        color: baseColor,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  pw.Container(
                    height: altura,
                    padding: const pw.EdgeInsets.only(),
                    alignment: pw.Alignment.bottomLeft,
                    child: pw.Text(
                      'Página Web: www.lajaguaibirico-cesar.gov.co',
                      style: pw.TextStyle(
                        color: baseColor,
                        fontWeight: pw.FontWeight.normal,
                        fontSize: 8,
                      ),
                    ),
                  ),
                  pw.Container(
                    height: altura,
                    padding: const pw.EdgeInsets.only(),
                    alignment: pw.Alignment.bottomLeft,
                    child: pw.Text(
                      'Correo Institucional: alcaldía@lajaguadeibirico-cesar.gov.co',
                      style: pw.TextStyle(
                        color: baseColor,
                        fontWeight: pw.FontWeight.normal,
                        fontSize: 8,
                      ),
                    ),
                  ),
                  pw.Container(
                    height: altura,
                    padding: const pw.EdgeInsets.only(),
                    alignment: pw.Alignment.bottomLeft,
                    child: pw.Text(
                      'Teléfono (095)5769206 - Fax (095) 5769024',
                      style: pw.TextStyle(
                        color: baseColor,
                        fontWeight: pw.FontWeight.normal,
                        fontSize: 8,
                      ),
                    ),
                  ),
                  pw.Container(
                    height: altura,
                    padding: const pw.EdgeInsets.only(),
                    alignment: pw.Alignment.bottomLeft,
                    child: pw.Text(
                      'Calle 6 No. 3ª - 23 ',
                      style: pw.TextStyle(
                        color: baseColor,
                        fontWeight: pw.FontWeight.normal,
                        fontSize: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.Expanded(
              child: pw.Column(
                children: [
                  pw.Container(
                    alignment: pw.Alignment.topRight,
                    padding: const pw.EdgeInsets.only(bottom: 0),
                    height: 72,
                    child: _logo2 != null
                        ? pw.Image(MemoryImage(_logo2!))
                        : pw.PdfLogo(),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (context.pageNumber > 1) pw.SizedBox(height: 20)
      ],
    );
  }

  static buildText({
    String title = '',
    String value = '',
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) async {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }

  static Widget buildTitle(String texto, double tamano, FontWeight fuente) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            texto,
            style: TextStyle(fontSize: tamano, fontWeight: fuente),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildTextJustificado(
          String texto, double tamano, FontWeight fuente) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(texto,
              style: TextStyle(fontSize: tamano, fontWeight: fuente),
              textAlign: TextAlign.justify),
        ],
      );

  static Widget buildTextLeft(String texto, double tamano, FontWeight fuente) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(texto,
              style: TextStyle(fontSize: tamano, fontWeight: fuente),
              textAlign: TextAlign.left),
        ],
      );

  static Widget buildTextCentrado(
          String texto, double tamano, FontWeight fuente) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(texto,
              style: TextStyle(fontSize: tamano, fontWeight: fuente),
              textAlign: TextAlign.center),
        ],
      );

/*
  static Future openFilePersonal(String nombreArchivo) async {
    final dir = await getExternalStorageDirectory();
    final url = dir!.path+'/'+nombreArchivo;

    await OpenFile.open(url);
  }

*/

  static String definirEstadoActivo(int? estado) {
    switch (estado) {
      case 0:
        return 'Bueno';

      case 1:
        return 'Regular';

      case 2:
        return 'Malo';

      default:
        return 'No definido';
    }
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Column(
                children: [
                  pw.Container(
                    alignment: pw.Alignment.topLeft,
                    padding: const pw.EdgeInsets.only(bottom: 0),
                    height: 72,
                    child: _logo1 != null
                        ? pw.Image(MemoryImage(_logo1!) as pw.ImageProvider)
                        : pw.PdfLogo(),
                  ),
                ],
              ),
            ),
            pw.Expanded(
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Container(
                    height: 15,
                    padding: const pw.EdgeInsets.only(left: 20),
                    alignment: pw.Alignment.bottomRight,
                    child: pw.Text(
                      'Código: CRI - SGC - 001',
                      style: pw.TextStyle(
                        color: baseColor,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 8,
                      ),
                    ),
                  ),
                  pw.Container(
                    height: 15,
                    padding: const pw.EdgeInsets.only(left: 20),
                    alignment: pw.Alignment.bottomRight,
                    child: pw.Text(
                      'Versión: 4 / 04-01-2016',
                      style: pw.TextStyle(
                        color: baseColor,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (context.pageNumber > 1) pw.SizedBox(height: 20)
      ],
    );
  }

  String _formatDate(DateTime date) {
    final format = DateFormat.yMMMMEEEEd('es_CO');
    return format.format(date);
  }
}
