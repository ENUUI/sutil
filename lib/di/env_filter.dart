import 'package:injectable/injectable.dart';

class SingleFilter extends EnvironmentFilter {
  SingleFilter(this.environment, Set<String> environments) : super(environments);

  final String environment;

  @override
  bool canRegister(Set<String> depEnvironments) {
    if (depEnvironments.isEmpty) return true;

    final deps = depEnvironments.intersection(environments);

    return deps.isNotEmpty && deps.contains(environment);
  }
}

class EnvironmentFilters extends EnvironmentFilter {
  EnvironmentFilters(this.filters) : super(const {});
  final Iterable<SingleFilter> filters;

  @override
  bool canRegister(Set<String> depEnvironments) {
    return filters.any((filter) => filter.canRegister(depEnvironments));
  }
}

