import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/type.dart';

class IterableInfo {
  final DartType elementType;
  final String containerMethod;

  const IterableInfo({
    required this.elementType,
    required this.containerMethod,
  });
}

class MapInfo {
  final DartType valueType;

  const MapInfo({required this.valueType});
}

class IterableTransformationHandler {
  static const _iterableTypes = ['List', 'Set', 'Iterable', 'Queue'];
  static const _primitiveTypes = {
    'String',
    'int',
    'double',
    'bool',
    'num',
    'BigInt',
    'Duration',
    'DateTime',
    'Uri',
  };

  IterableInfo? getIterableInfo(DartType type) {
    if (type is! InterfaceType) return null;

    final element = type.element3;
    final className = element.name3;
    if (className == null ||
        className == 'Map' ||
        !_isIterableType(className, element) ||
        type.typeArguments.isEmpty) {
      return null;
    }

    return IterableInfo(
      elementType: type.typeArguments.first,
      containerMethod: _getContainerMethod(className),
    );
  }

  MapInfo? getMapInfo(DartType type) {
    if (type is! InterfaceType) return null;
    final element = type.element3;
    final className = element.name3;
    if (className == null ||
        className != 'Map' ||
        type.typeArguments.length < 2) {
      return null;
    }
    return MapInfo(valueType: type.typeArguments[1]);
  }

  bool isCustomClassType(DartType? type) {
    if (type == null) return false;

    if (type is! InterfaceType) return false;

    final element = type.element3;
    final className = element.name3;
    if (className == null ||
        _primitiveTypes.contains(className) ||
        className == 'Map' ||
        _isIterableType(className, element)) {
      return false;
    }
    return element is ClassElement2;
  }

  bool _isIterableType(String className, Element2 element) {
    if (_iterableTypes.contains(className)) return true;

    if (element is! InterfaceElement2) return false;

    return element.interfaces.any(
      (interface) => _iterableTypes.contains(interface.getDisplayString()),
    );
  }

  String _getContainerMethod(String className) {
    return switch (className) {
      'Set' => 'toSet()',
      'Queue' => 'toList()',
      _ => 'toList()',
    };
  }
}
