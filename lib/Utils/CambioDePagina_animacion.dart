import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
CambioDePaginaAnimado(pagina, duracion, context) {
  return Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: duracion),
        pageBuilder: (context, animation, secondaryAnimation) => pagina,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ));
}

// ignore: non_constant_identifier_names
CambioDePaginaAnimadoNuevaruta(pagina, duracion, context) {
  return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: duracion),
        pageBuilder: (context, animation, secondaryAnimation) => pagina,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ));
}

// ignore: non_constant_identifier_names
constCambioDePaginaAnimadoSinVuelta(pagina, duracion, context) {
  return Navigator.removeRoute(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: duracion),
        pageBuilder: (context, animation, secondaryAnimation) => pagina,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ));
}
