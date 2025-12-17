import 'mapper_context.dart';

class StrategyResult {
  final String dtoExtension;
  final String domainExtension;

  StrategyResult({required this.dtoExtension, required this.domainExtension});
}

abstract class MapperStrategy {
  StrategyResult generate(MapperContext context);
}
