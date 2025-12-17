import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';

class ParameterTypeResolver {
  Map<String, DartType> getParameterTypes(ClassElement element) {
    final paramTypes = <String, DartType>{};
    final constructor = element.constructors.firstOrNull;

    if (constructor == null) {
      return paramTypes;
    }

    constructor.parameters
        .where((param) => param.isNamed || param.isRequiredPositional)
        .forEach((param) => paramTypes[param.name] = param.type);

    return paramTypes;
  }

  ClassElement? findClassInLibrary(LibraryElement library, String className) {
    return library.topLevelElements.whereType<ClassElement>().firstWhereOrNull(
      (element) => element.name == className,
    );
  }
}
