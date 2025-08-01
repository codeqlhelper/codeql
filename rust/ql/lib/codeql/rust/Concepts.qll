/**
 * Provides abstract classes representing generic concepts such as file system
 * access or system command execution, for which individual framework libraries
 * provide concrete subclasses.
 */

private import codeql.rust.dataflow.DataFlow
private import codeql.rust.dataflow.internal.DataFlowImpl
private import codeql.Locations
private import codeql.threatmodels.ThreatModels
private import codeql.rust.Frameworks
private import codeql.rust.dataflow.FlowSource
private import codeql.rust.controlflow.ControlFlowGraph as Cfg
private import codeql.rust.controlflow.CfgNodes as CfgNodes
private import codeql.concepts.ConceptsShared

private module ConceptsShared = ConceptsMake<Location, RustDataFlow>;

/**
 * A data flow source for a specific threat-model.
 *
 * Extend this class to refine existing API models. If you want to model new APIs,
 * extend `ThreatModelSource::Range` instead.
 */
final class ThreatModelSource = ThreatModelSource::Range;

/**
 * Provides a class for modeling new sources for specific threat-models.
 */
module ThreatModelSource {
  /**
   * A data flow source, for a specific threat-model.
   */
  abstract class Range extends DataFlow::Node {
    /**
     * Gets a string that represents the source kind with respect to threat modeling.
     *
     * See
     * - https://github.com/github/codeql/blob/main/docs/codeql/reusables/threat-model-description.rst
     * - https://github.com/github/codeql/blob/main/shared/threat-models/ext/threat-model-grouping.model.yml
     */
    abstract string getThreatModel();

    /**
     * Gets a string that describes the type of this threat-model source.
     */
    abstract string getSourceType();
  }
}

/**
 * A data flow source that is enabled in the current threat model configuration.
 */
class ActiveThreatModelSource extends ThreatModelSource {
  ActiveThreatModelSource() { currentThreatModel(this.getThreatModel()) }
}

/**
 * A data flow source corresponding to the program's command line arguments or path.
 */
final class CommandLineArgsSource = CommandLineArgsSource::Range;

/**
 * Provides a class for modeling new sources for the program's command line arguments or path.
 */
module CommandLineArgsSource {
  /**
   * A data flow source corresponding to the program's command line arguments or path.
   */
  abstract class Range extends ThreatModelSource::Range {
    override string getThreatModel() { result = "commandargs" }

    override string getSourceType() { result = "CommandLineArgs" }
  }
}

/**
 * An externally modeled source for command line arguments.
 */
class ModeledCommandLineArgsSource extends CommandLineArgsSource::Range {
  ModeledCommandLineArgsSource() { sourceNode(this, "commandargs") }
}

/**
 * A data flow source corresponding to the program's environment.
 */
final class EnvironmentSource = EnvironmentSource::Range;

/**
 * Provides a class for modeling new sources for the program's environment.
 */
module EnvironmentSource {
  /**
   * A data flow source corresponding to the program's environment.
   */
  abstract class Range extends ThreatModelSource::Range {
    override string getThreatModel() { result = "environment" }

    override string getSourceType() { result = "EnvironmentSource" }
  }
}

/**
 * An externally modeled source for data from the program's environment.
 */
class ModeledEnvironmentSource extends EnvironmentSource::Range {
  ModeledEnvironmentSource() { sourceNode(this, "environment") }
}

/**
 * A data flow source corresponding to a file access.
 */
final class FileSource = FileSource::Range;

/**
 * An externally modeled source for data from a file access.
 */
class ModeledFileSource extends FileSource::Range {
  ModeledFileSource() { sourceNode(this, "file") }
}

/**
 * Provides a class for modeling new sources for file accesses.
 */
module FileSource {
  /**
   * A data flow source corresponding to a file access.
   */
  abstract class Range extends ThreatModelSource::Range {
    override string getThreatModel() { result = "file" }

    override string getSourceType() { result = "FileSource" }
  }
}

/**
 * A data flow source corresponding to standard input.
 */
final class StdInSource = StdInSource::Range;

/**
 * An externally modeled source for data from standard input.
 */
class ModeledStdInSourceSource extends StdInSource::Range {
  ModeledStdInSourceSource() { sourceNode(this, "stdin") }
}

/**
 * Provides a class for modeling new sources for standard input.
 */
module StdInSource {
  /**
   * A data flow source corresponding to standard input.
   */
  abstract class Range extends ThreatModelSource::Range {
    override string getThreatModel() { result = "stdin" }

    override string getSourceType() { result = "StdInSource" }
  }
}

/**
 * A data flow source corresponding to the program's database reads.
 */
final class DatabaseSource = DatabaseSource::Range;

/**
 * Provides a class for modeling new sources for the program's database reads.
 */
module DatabaseSource {
  /**
   * A data flow source corresponding to the program's database reads.
   */
  abstract class Range extends ThreatModelSource::Range {
    override string getThreatModel() { result = "database" }

    override string getSourceType() { result = "DatabaseSource" }
  }
}

/**
 * An externally modeled source for data from the program's database.
 */
class ModeledDatabaseSource extends DatabaseSource::Range {
  ModeledDatabaseSource() { sourceNode(this, "database") }
}

/**
 * A data flow source for remote (network) data.
 */
final class RemoteSource = RemoteSource::Range;

/**
 * Provides a class for modeling new sources of remote (network) data.
 */
module RemoteSource {
  /**
   * A data flow source for remote (network) data.
   */
  abstract class Range extends ThreatModelSource::Range {
    override string getThreatModel() { result = "remote" }

    override string getSourceType() { result = "RemoteSource" }
  }
}

/**
 * An externally modeled source for remote (network) data.
 */
class ModeledRemoteSource extends RemoteSource::Range {
  ModeledRemoteSource() { sourceNode(this, "remote") }
}

/**
 * A data flow sink that is used in a query.
 *
 * Extend this class to refine existing API models. If you want to model new APIs,
 * extend `QuerySink::Range` instead.
 */
final class QuerySink = QuerySink::Range;

/**
 * Provides a class for modeling new query sinks.
 */
module QuerySink {
  /**
   * A data flow sink that is used in a query.
   */
  abstract class Range extends DataFlow::Node {
    /**
     * Gets a string that describes the type of this sink (usually the query it applies to).
     */
    abstract string getSinkType();
  }
}

/**
 * A data flow node that constructs a SQL statement (for later execution).
 *
 * Often, it is worthy of an alert if a SQL statement is constructed such that
 * executing it would be a security risk.
 *
 * If it is important that the SQL statement is executed, use `SqlExecution`.
 *
 * Extend this class to refine existing API models. If you want to model new APIs,
 * extend `SqlConstruction::Range` instead.
 */
final class SqlConstruction = SqlConstruction::Range;

/**
 * Provides a class for modeling new SQL execution APIs.
 */
module SqlConstruction {
  /**
   * A data flow node that constructs a SQL statement.
   */
  abstract class Range extends DataFlow::Node {
    /**
     * Gets the argument that specifies the SQL statements to be constructed.
     */
    abstract DataFlow::Node getSql();
  }
}

/**
 * A data flow node that constructs and executes SQL statements.
 *
 * If the context of interest is such that merely constructing a SQL statement
 * would be valuable to report, consider also using `SqlConstruction`.
 *
 * Extend this class to refine existing API models. If you want to model new APIs,
 * extend `SqlExecution::Range` instead.
 */
final class SqlExecution = SqlExecution::Range;

/**
 * Provides a class for modeling new SQL execution APIs.
 */
module SqlExecution {
  /**
   * A data flow node that executes SQL statements.
   */
  abstract class Range extends DataFlow::Node {
    /**
     * Gets the argument that specifies the SQL statements to be executed.
     */
    abstract DataFlow::Node getSql();
  }
}

/**
 * A data flow node that performs SQL sanitization.
 */
final class SqlSanitization = SqlSanitization::Range;

/**
 * Provides a class for modeling new SQL sanitization APIs.
 */
module SqlSanitization {
  /**
   * A data flow node that performs SQL sanitization.
   */
  abstract class Range extends DataFlow::Node { }
}

/**
 * Provides models for cryptographic things.
 */
module Cryptography {
  import ConceptsShared::Cryptography as SC

  final class CryptographicOperation = SC::CryptographicOperation;

  class EncryptionAlgorithm = SC::EncryptionAlgorithm;

  class HashingAlgorithm = SC::HashingAlgorithm;

  class PasswordHashingAlgorithm = SC::PasswordHashingAlgorithm;

  module CryptographicOperation = SC::CryptographicOperation;

  class BlockMode = SC::BlockMode;

  class CryptographicAlgorithm = SC::CryptographicAlgorithm;
}

/** Provides classes for modeling path-related APIs. */
module Path {
  final class PathNormalization = PathNormalization::Range;

  /** Provides a class for modeling new path normalization APIs. */
  module PathNormalization {
    /**
     * A data-flow node that performs path normalization. This is often needed in order
     * to safely access paths.
     */
    abstract class Range extends DataFlow::Node {
      /** Gets an argument to this path normalization that is interpreted as a path. */
      abstract DataFlow::Node getPathArg();
    }
  }

  /** A data-flow node that checks that a path is safe to access in some way, for example by having a controlled prefix. */
  class SafeAccessCheck extends DataFlow::ExprNode {
    SafeAccessCheck() { this = DataFlow::BarrierGuard<safeAccessCheck/3>::getABarrierNode() }
  }

  private predicate safeAccessCheck(CfgNodes::AstCfgNode g, Cfg::CfgNode node, boolean branch) {
    g.(SafeAccessCheck::Range).checks(node, branch)
  }

  /** Provides a class for modeling new path safety checks. */
  module SafeAccessCheck {
    /** A data-flow node that checks that a path is safe to access in some way, for example by having a controlled prefix. */
    abstract class Range extends CfgNodes::AstCfgNode {
      /** Holds if this guard validates `node` upon evaluating to `branch`. */
      abstract predicate checks(Cfg::CfgNode node, boolean branch);
    }
  }
}
