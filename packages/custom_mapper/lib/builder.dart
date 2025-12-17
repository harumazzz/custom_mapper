/// Builder configuration for the custom_mapper package.
///
/// This module exports the build configuration needed by build_runner
/// to generate mapping code from annotated classes.
library builder;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'src/mapper_generator.dart';

/// Creates a builder for generating mapping code.
///
/// This function is called by build_runner to create a [PartBuilder]
/// that generates `.map.dart` files containing the mapping methods
/// for classes annotated with `@Mapper`.
///
/// The [options] parameter contains build configuration options
/// passed from build.yaml or build_runner.
///
/// Returns a [PartBuilder] configured to use [MapperGenerator]
/// and generate files with the `.map.dart` extension.
Builder mapperBuilder(BuilderOptions options) =>
    PartBuilder([MapperGenerator()], '.map.dart');
