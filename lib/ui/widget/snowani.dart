import 'package:flutter/material.dart';
import 'dart:math' as math;

class SnowAnimation extends StatefulWidget {
  final Widget child;
  final int snowflakeCount;
  final Color snowflakeColor;
  
  const SnowAnimation({
    super.key,
    required this.child,
    this.snowflakeCount = 100,
    this.snowflakeColor = Colors.white,
  });

  @override
  State<SnowAnimation> createState() => _SnowAnimationState();
}

class _SnowAnimationState extends State<SnowAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Snowflake> snowflakes;
  final math.Random random = math.Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    // Inicializar copos de nieve
    snowflakes = List.generate(widget.snowflakeCount, (index) {
      return Snowflake(
        x: random.nextDouble(),
        y: random.nextDouble(),
        radius: random.nextDouble() * 4 + 1,
        speed: random.nextDouble() * 2 + 1,
        opacity: random.nextDouble() * 0.6 + 0.4,
        horizontalSpeed: (random.nextDouble() - 0.5) * 0.5,
      );
    });

    _controller.addListener(() {
      setState(() {
        for (var snowflake in snowflakes) {
          snowflake.update();
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Contenido principal (tu login)
        widget.child,
        // Capa de copos de nieve
        Positioned.fill(
          child: CustomPaint(
            painter: SnowPainter(
              snowflakes: snowflakes,
              color: widget.snowflakeColor,
            ),
          ),
        ),
      ],
    );
  }
}

class Snowflake {
  double x;
  double y;
  final double radius;
  final double speed;
  final double opacity;
  final double horizontalSpeed;

  Snowflake({
    required this.x,
    required this.y,
    required this.radius,
    required this.speed,
    required this.opacity,
    required this.horizontalSpeed,
  });

  void update() {
    y += speed * 0.01;
    x += horizontalSpeed * 0.01;

    // Reiniciar posición cuando el copo sale de la pantalla
    if (y > 1.1) {
      y = -0.1;
      x = math.Random().nextDouble();
    }
    if (x > 1.1) {
      x = -0.1;
    } else if (x < -0.1) {
      x = 1.1;
    }
  }
}

class SnowPainter extends CustomPainter {
  final List<Snowflake> snowflakes;
  final Color color;

  SnowPainter({
    required this.snowflakes,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (var snowflake in snowflakes) {
      paint.color = color.withValues(alpha: snowflake.opacity);
      canvas.drawCircle(
        Offset(
          snowflake.x * size.width,
          snowflake.y * size.height,
        ),
        snowflake.radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}