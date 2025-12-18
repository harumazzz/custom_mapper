import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';

class ParameterTypeResolver {
  Map<String, DartType> getParameterTypes(ClassElement2 element) {
    final paramTypes = <String, DartType>{};
    final constructor = element.constructors2.firstOrNull;

    if (constructor == null) {
      return paramTypes;
    }

    constructor.formalParameters
        .where((param) => param.isNamed || param.isRequiredPositional)
        .forEach((param) {
          final paramName = param.name3;
          if (paramName != null) {
            paramTypes[paramName] = param.type;
          }
        });

    return paramTypes;
  }

  ClassElement2? findClassInLibrary(LibraryElement2 library, String className) {
    final namespace = library.exportNamespace;
    final element = namespace.get2(className);
    if (element is ClassElement2) {
      return element;
    }
    for (final fragment in library.fragments) {
      for (final import in fragment.libraryImports2) {
        final importedLibrary = import.importedLibrary2;
        if (importedLibrary != null) {
          final importedNamespace = importedLibrary.exportNamespace;
          final importedElement = importedNamespace.get2(className);
          if (importedElement is ClassElement2) {
            return importedElement;
          }
        }
      }
    }

    return null;
  }
}
