import 'package:logger/logger.dart';
import 'package:sutil/util/utils.dart';

final log = debug
    ? Logger(output: ConsoleOutput(), filter: DevelopmentFilter())
    : Logger(
        output: ConsoleOutput(),
        filter: ProductionFilter(),
        level: Level.info,
      );
