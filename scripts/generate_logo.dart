import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

void main() {
  // Создаем изображение 1024x1024
  final image = img.Image(width: 1024, height: 1024);
  
  // Заливаем фон синим цветом (#2196F3)
  img.fill(image, color: img.ColorRgb8(33, 150, 243));
  
  // Рисуем белый прямоугольник (основание дома)
  img.fillRect(image, 
    x1: 200, y1: 400, 
    x2: 624, y2: 824, 
    color: img.ColorRgb8(255, 255, 255));
  
  // Рисуем крышу (треугольник)
  final roof = img.Image(width: 424, height: 200);
  img.fill(roof, color: img.ColorRgb8(255, 255, 255));
  // Упрощенная крыша - прямоугольник
  img.fillRect(image,
    x1: 200, y1: 200,
    x2: 624, y2: 400,
    color: img.ColorRgb8(255, 255, 255));
  
  // Окна (синие квадраты)
  img.fillRect(image, x1: 300, y1: 500, x2: 400, y2: 600, color: img.ColorRgb8(33, 150, 243));
  img.fillRect(image, x1: 424, y1: 500, x2: 524, y2: 600, color: img.ColorRgb8(33, 150, 243));
  img.fillRect(image, x1: 300, y1: 650, x2: 400, y2: 750, color: img.ColorRgb8(33, 150, 243));
  img.fillRect(image, x1: 424, y1: 650, x2: 524, y2: 750, color: img.ColorRgb8(33, 150, 243));
  
  // Дверь
  img.fillRect(image, x1: 450, y1: 750, x2: 550, y2: 824, color: img.ColorRgb8(33, 150, 243));
  
  // Галочка контроля (белый круг с синей галочкой)
  img.fillCircle(image, x: 800, y: 300, radius: 100, color: img.ColorRgb8(255, 255, 255));
  
  // Сохраняем изображение
  final png = img.encodePng(image);
  File('assets/icons/app_logo.png').writeAsBytesSync(png);
  
  print('Логотип создан: assets/icons/app_logo.png');
}

