import 'mapper_context.dart';
import 'mapper_strategy.dart';
import 'parameter_type_resolver.dart';
import 'mapping_code_generator.dart';

class BidirectionalMapperStrategy implements MapperStrategy {
  late final _parameterResolver = ParameterTypeResolver();
  late final _codeGenerator = MappingCodeGenerator();

  @override
  StrategyResult generate(MapperContext context) {
    final dtoBuffer = StringBuffer();
    final domainBuffer = StringBuffer();
    if (context.enableToDomain) {
      dtoBuffer.write(_generateToDomain(context));
    }
    if (context.enableToData) {
      domainBuffer.write(_generateToData(context));
    }
    return StrategyResult(
      dtoExtension: dtoBuffer.toString(),
      domainExtension: domainBuffer.toString(),
    );
  }

  String _generateToDomain(MapperContext context) {
    final domainElement = _parameterResolver.findClassInLibrary(
      context.dtoElement.library2,
      context.domainName,
    );

    if (domainElement == null) {
      return '';
    }

    final domainFields = _parameterResolver
        .getParameterTypes(domainElement)
        .keys
        .toSet();
    final dtoParamTypes = _parameterResolver.getParameterTypes(
      context.dtoElement,
    );

    final fieldsToMap = context.fields
        .where((field) => domainFields.contains(field))
        .toList();

    return _codeGenerator.generateMappingMethod(
      methodName: 'toDomain',
      targetType: context.domainName,
      fields: fieldsToMap,
      parameterTypes: dtoParamTypes,
      transformationMethod: 'toDomain',
      fieldAnnotations: context.fieldAnnotations,
    );
  }

  String _generateToData(MapperContext context) {
    final domainElement = _parameterResolver.findClassInLibrary(
      context.dtoElement.library2,
      context.domainName,
    );

    if (domainElement == null) {
      return '';
    }

    final domainParamTypes = _parameterResolver.getParameterTypes(
      domainElement,
    );
    final domainFields = domainParamTypes.keys.toSet();

    final fieldsToMap = context.fields
        .where((field) => domainFields.contains(field))
        .toList();

    return _codeGenerator.generateMappingMethod(
      methodName: 'toData',
      targetType: context.dtoName,
      fields: fieldsToMap,
      parameterTypes: domainParamTypes,
      transformationMethod: 'toData',
      fieldAnnotations: context.fieldAnnotations,
    );
  }
}
