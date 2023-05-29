import 'dart:html';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'dart:html' as html;
import 'package:file_picker/file_picker.dart';
import 'package:proyecto_p_q_r_s/controlador/storage_helper.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import 'dart:convert';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;
import 'package:quickalert/quickalert.dart';
import '../../flutter_flow/flutter_flow_util.dart';

class HoverContainer extends HookWidget {
  HoverContainer({
    Key? key,
  }) : super(key: key);
  
  String nombreArchivo = window.localStorage['nombreAdjuntoPQRS'] ?? 'Arrastre aquí su archivo o haga clic para añadir';
  bool tieneArchivo = false;
  String archivoAdjunto = '';

  @override
  Widget build(BuildContext context) {
    final isHovered = useState(false);
    DropzoneViewController? controllerDropzone;

    return Stack(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.2,
              child: DropzoneView(
                operation: DragOperation.copy,
                cursor: CursorType.pointer,
                onCreated: (DropzoneViewController ctrl) =>
                    controllerDropzone = ctrl,
                onLoaded: () => print('Zone loaded'),
                onError: (String? ev) => print('Error: $ev'),
                onHover: () => print('Zone hovered'),
                onDrop: (dynamic ev) async {
                  dynamic tipoArchivo =
                      await controllerDropzone!.getFileMIME(ev);

                  bool isAllowed = isFileFormatAllowed(tipoArchivo);
                  print('tipo  archivo: $tipoArchivo');
                  dynamic tamArchivo =
                      await controllerDropzone!.getFileSize(ev);
                  print('tamno  archivo: ' +
                      bytesToMegabytes(tamArchivo).toString());

                  if (!isAllowed) {
                    // El archivo tiene un formato permitido
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.warning,
                        title: 'Advertencia',
                        confirmBtnText: 'Ok',
                        confirmBtnColor: FlutterFlowTheme.of(context).info,
                        text:
                            'Ese no es un tipo de archivo válido, solo se permiten archivos en los siguientes formatos: doc, txt, xls, xlsx, docx, ppt, pptx, pdf, mp4, mp3, zip, jpg, jpeg, png, gif, rar.');
                  } else {
                    if (bytesToMegabytes(tamArchivo) > 2.0) {
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.warning,
                          title: 'Advertencia',
                          confirmBtnText: 'Ok',
                          confirmBtnColor: FlutterFlowTheme.of(context).info,
                          text:
                              'El tamaño máximo de archivo permitido es de 2 MB');
                    } else {
                      print('Zone 2 drop: ${ev.name}');
                      print('${ev.name}');
                      nombreArchivo = '${ev.name}';
                      Uint8List fileData =
                          await controllerDropzone!.getFileData(ev);
                      archivoAdjunto = base64Encode(fileData);
                      window.localStorage['nombreAdjuntoPQRS'] = nombreArchivo;
                      window.localStorage['adjuntoPQRS'] = archivoAdjunto;
                    }
                  }
                },
                onLeave: () => print('Zone left'),
              ),
            )
          ],
        ),
        InkWell(
          onTap: () {
            _selectFile(context);
          },
          child: MouseRegion(
            onEnter: (_) {
              isHovered.value = true;
            },
            onExit: (_) {
              isHovered.value = false;
            },
            child: DottedBorder(
              strokeWidth: 3,
              dashPattern: [5, 5],
              borderType: BorderType.RRect,
              radius: Radius.circular(10),
              padding: EdgeInsets.all(6),
              color: isHovered.value
                  ? FlutterFlowTheme.of(context).info
                  : Colors.transparent,
              child: ClipRect(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: !isHovered.value
                          ? FlutterFlowTheme.of(context).info
                          : Colors.transparent,
                      width: 2.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.04,
                        height: MediaQuery.of(context).size.height * 0.07,
                        decoration: BoxDecoration(
                          color: isHovered.value
                              ? FlutterFlowTheme.of(context).tertiary
                              : FlutterFlowTheme.of(context).info,
                          borderRadius: BorderRadius.circular(13.0),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).info,
                          ),
                        ),
                        alignment: AlignmentDirectional(
                            0.050000000000000044, 0.050000000000000044),
                        child: Icon(
                          Icons.attach_file,
                          color: isHovered.value
                              ? FlutterFlowTheme.of(context).info
                              : FlutterFlowTheme.of(context).tertiary,
                          size: 35.0,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                25.0, 0.0, 0.0, 0.0),
                            child: Text(
                              nombreArchivo,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontSize: 19.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom,
  allowedExtensions: [
    'doc',
    'txt',
    'xls',
    'xlsx',
    'docx',
    'ppt',
    'pptx',
    'pdf',
    'mp4',
    'mp3',
    'zip',
    'jpg',
    'jpeg',
    'png',
    'gif',
    'rar',
  ],);

    if (result != null) {

      PlatformFile file = result.files.first;
  int maxSizeInBytes = 2 * 1024 * 1024; // 2 MB en bytes

  if (file.size > maxSizeInBytes) {
     QuickAlert.show(
                          context: context,
                          type: QuickAlertType.warning,
                          title: 'Advertencia',
                          confirmBtnText: 'Ok',
                          confirmBtnColor: FlutterFlowTheme.of(context).info,
                          text:
                              'El tamaño máximo de archivo permitido es de 2 MB');
  } else {
    final file = result.files.single;

      final blob = html.Blob([file.bytes], file.name);

      final reader = html.FileReader();
      reader.readAsDataUrl(blob);

      reader.onLoadEnd.listen((event) {
        if (reader.readyState == html.FileReader.DONE) {
          archivoAdjunto = reader.result as String;
          nombreArchivo = file.name;
          List<String> parts = nombreArchivo.split('.');
          String extension = parts.last;
          String? mimeType = lookupMimeType(extension);
         window.localStorage['nombreAdjuntoPQRS'] = nombreArchivo;
         window.localStorage['adjuntoPQRS'] = archivoAdjunto;
          // Aquí puedes guardar el archivo en el almacenamiento local o realizar cualquier otra acción con los datos del archivo.
        }
      });
  }
      
      
    }
  }
}

double bytesToMegabytes(int bytes) {
  double megabytes = bytes / (1024 * 1024);
  return megabytes;
}

class DottedBorderPainter extends CustomPainter {
  final Color color;
  final double height;

  DottedBorderPainter({required this.color, required this.height});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final space = 4.0;
    final dashedWidth = 4.0;
    final startX = 0.0;
    final endX = size.width;
    final startY = height / 2;
    final segments = ((endX - startX) / (space + dashedWidth)).floor();

    for (int i = 0; i < segments; i++) {
      final x = startX + (space + dashedWidth) * i;
      canvas.drawLine(
          Offset(x, startY), Offset(x + dashedWidth, startY), paint);
    }
  }

  @override
  bool shouldRepaint(DottedBorderPainter oldDelegate) =>
      color != oldDelegate.color;
}

bool isFileFormatAllowed(String fileMime) {
  List<String> allowedFormats = [
    'application/msword',
    'text/plain',
    'application/vnd.ms-excel',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    'application/vnd.ms-powerpoint',
    'application/vnd.openxmlformats-officedocument.presentationml.presentation',
    'application/pdf',
    'video/mp4',
    'audio/mp3',
    'application/zip',
    'image/jpeg',
    'image/png',
    'image/gif',
    'application/x-rar-compressed'
  ];

  return allowedFormats.contains(fileMime);
}
