import 'package:flutter/material.dart';
import 'package:tickoyakovendors/core/colors.dart';

enum ShapeType { circle, roundedRectangle, polygon, customPath }

class AnimatedBackground extends StatelessWidget {
  final AnimationController controller;

  const AnimatedBackground({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Stack(
          children: [
            // Large Main Shape
            Positioned(
              top: -40 + (50 * controller.value),
              right: -60,
              child: _buildShape(
                width: 220,
                height: 220,
                color: AppColors.primaryColor,
                scale: 1 + controller.value * 0.1,
                rotation: controller.value * 0.3,
                shape: ShapeType.roundedRectangle,
              ),
            ),
            // Second Large Shape
            Positioned(
              bottom: 150 - (50 * controller.value),
              left: 40,
              child: _buildShape(
                width: 180,
                height: 180,
                color: AppColors.secondaryColor,
                scale: 1 + controller.value * 0.08,
                rotation: -controller.value * 0.2,
                shape: ShapeType.polygon,
              ),
            ),
            // Small Moving Shape
            Positioned(
              bottom: 20 + (120 * controller.value),
              left: 280,
              child: _buildShape(
                width: 90,
                height: 90,
                color: AppColors.accentColor,
                scale: 1 + controller.value * 0.1,
                rotation: controller.value * 0.1,
                shape: ShapeType.circle,
              ),
            ),
            // Another Layered Shape
            Positioned(
              top: 120 - (30 * controller.value),
              left: -50,
              child: _buildShape(
                width: 130,
                height: 130,
                color: AppColors.primaryColor.withOpacity(0.7),
                scale: 1 + controller.value * 0.06,
                rotation: controller.value * 0.15,
                shape: ShapeType.customPath,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildShape({
    required double width,
    required double height,
    required Color color,
    required double scale,
    required double rotation,
    required ShapeType shape,
  }) {
    return Transform.scale(
      scale: scale,
      child: Transform.rotate(
        angle: rotation,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color,
                color.withOpacity(0.6),
                color.withOpacity(0.3),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: shape == ShapeType.roundedRectangle
                ? BorderRadius.circular(20)
                : null,
            shape: shape == ShapeType.circle
                ? BoxShape.circle
                : BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 15,
                spreadRadius: 5,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: shape == ShapeType.polygon || shape == ShapeType.customPath
              ? ClipPath(
                  clipper: shape == ShapeType.polygon
                      ? HexagonClipper()
                      : CustomShapeClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          color,
                          color.withOpacity(0.5),
                          color.withOpacity(0.2),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final height = size.height;
    final width = size.width;
    final offset = height * 0.15;

    path.moveTo(width * 0.5, 0);
    path.lineTo(width - offset, offset);
    path.lineTo(width, height - offset);
    path.lineTo(width * 0.5, height);
    path.lineTo(offset, height - offset);
    path.lineTo(0, offset);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width * 0.5, 0);
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.3,
      size.width,
      size.height * 0.45,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.75,
      size.width * 0.5,
      size.height,
    );
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.75,
      0,
      size.height * 0.45,
    );
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.3,
      size.width * 0.5,
      0,
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
