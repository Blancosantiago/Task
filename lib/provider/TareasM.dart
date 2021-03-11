import 'dart:convert';

NuevoProceso nuevoProcesoFromJson(String str) =>
    NuevoProceso.fromJson(json.decode(str));

String nuevoProcesoToJson(NuevoProceso data) => json.encode(data.toJson());

class NuevoProceso {
  NuevoProceso({
    this.data,
    this.meta,
  });

  List<Datum> data;
  Meta meta;

  factory NuevoProceso.fromJson(Map<String, dynamic> json) => NuevoProceso(
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta == null ? null : meta.toJson(),
      };
}

class Datum {
  Datum({
    this.uid,
    this.attributes,
  });

  String uid;
  TaskMode attributes;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        uid: json["uid"] == null ? null : json["uid"],
        attributes: json["attributes"] == null
            ? null
            : TaskMode.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid == null ? null : uid,
        "attributes": attributes == null ? null : attributes.toJson(),
      };
}

class TaskMode {
  TaskMode({
    this.id,
    this.titulo,
    this.terminado,
    this.descripcion,
    this.horaFinal,
    this.hora,
  });
  String id;
  String titulo;
  bool terminado;
  String descripcion;
  var horaFinal;
  DateTime hora;

  factory TaskMode.fromJson(Map<String, dynamic> json) => TaskMode(
        titulo: json["titulo"] == null ? null : json["titulo"],
        terminado: json["terminado"] == null ? null : json["terminado"],
        descripcion: json["descripcion"] == null ? null : json["descripcion"],
        horaFinal: json["horaFinal"] == null
            ? null
            : DateTime.parse(json["horaFinal"]),
        hora: json["hora"] == null ? null : DateTime.parse(json["hora"]),
      );

  Map<String, dynamic> toJson() => {
        "titulo": titulo == null ? null : titulo,
        "terminado": terminado == null ? null : terminado,
        "descripcion": descripcion == null ? null : descripcion,
        "horaFinal": horaFinal == null ? null : horaFinal.toIso8601String(),
        "hora": hora == null ? null : hora.toIso8601String(),
      };
}

class Meta {
  Meta({
    this.total,
  });

  int total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "total": total == null ? null : total,
      };
}
