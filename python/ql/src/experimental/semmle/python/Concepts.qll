/**
 * This version resides in the experimental area and provides a space for
 * external contributors to place new concepts, keeping to our preferred
 * structure while remaining in the experimental area.
 *
 * Provides abstract classes representing generic concepts such as file system
 * access or system command execution, for which individual framework libraries
 * provide concrete subclasses.
 */

private import python
private import semmle.python.dataflow.new.DataFlow
private import semmle.python.dataflow.new.RemoteFlowSources
private import semmle.python.dataflow.new.TaintTracking
private import experimental.semmle.python.Frameworks

/** Provides classes for modeling JWT encoding-related APIs. */
module JWTEncoding {
  /**
   * A data-flow node that collects methods encoding a JWT token.
   *
   * Extend this class to model new APIs. If you want to refine existing API models,
   * extend `JWTEncoding` instead.
   */
  abstract class Range extends DataFlow::Node {
    /**
     * Gets the argument containing the encoding payload.
     */
    abstract DataFlow::Node getPayload();

    /**
     * Gets the argument containing the encoding key.
     */
    abstract DataFlow::Node getKey();

    /**
     * Gets the algorithm Node used in the encoding.
     */
    abstract DataFlow::Node getAlgorithm();

    /**
     * Tries to get the algorithm used in the encoding.
     */
    abstract string getAlgorithmString();
  }
}

/**
 * A data-flow node that collects methods encoding a JWT token.
 *
 * Extend this class to refine existing API models. If you want to model new APIs,
 * extend `JWTEncoding::Range` instead.
 */
class JWTEncoding extends DataFlow::Node {
  JWTEncoding::Range range;

  JWTEncoding() { this = range }

  /**
   * Gets the argument containing the payload.
   */
  DataFlow::Node getPayload() { result = range.getPayload() }

  /**
   * Gets the argument containing the encoding key.
   */
  DataFlow::Node getKey() { result = range.getKey() }

  /**
   * Gets the algorithm Node used in the encoding.
   */
  DataFlow::Node getAlgorithm() { result = range.getAlgorithm() }

  /**
   * Tries to get the algorithm used in the encoding.
   */
  string getAlgorithmString() { result = range.getAlgorithmString() }
}

/** Provides classes for modeling JWT decoding-related APIs. */
module JWTDecoding {
  /**
   * A data-flow node that collects functions escaping regular expressions.
   *
   * Extend this class to model new APIs. If you want to refine existing API models,
   * extend `JWTDecoding` instead.
   */
  abstract class Range extends DataFlow::Node {
    /**
     * Gets the argument containing the encoding payload.
     */
    abstract DataFlow::Node getPayload();

    /**
     * Gets the argument containing the encoding key.
     */
    abstract DataFlow::Node getKey();

    /**
     * Gets the algorithm Node used in the encoding.
     */
    abstract DataFlow::Node getAlgorithm();

    /**
     * Tries to get the algorithm used in the encoding.
     */
    abstract string getAlgorithmString();

    /**
     * Gets the options Node used in the encoding.
     */
    abstract DataFlow::Node getOptions();

    /**
     * Checks if the signature gets verified while decoding.
     */
    abstract boolean verifiesSignature();
  }
}

/**
 * A data-flow node that collects methods encoding a JWT token.
 *
 * Extend this class to refine existing API models. If you want to model new APIs,
 * extend `JWTDecoding::Range` instead.
 */
class JWTDecoding extends DataFlow::Node {
  JWTDecoding::Range range;

  JWTDecoding() { this = range }

  /**
   * Gets the argument containing the payload.
   */
  DataFlow::Node getPayload() { result = range.getPayload() }

  /**
   * Gets the argument containing the encoding key.
   */
  DataFlow::Node getKey() { result = range.getKey() }

  /**
   * Gets the algorithm Node used in the encoding.
   */
  DataFlow::Node getAlgorithm() { result = range.getAlgorithm() }

  /**
   * Tries to get the algorithm used in the encoding.
   */
  string getAlgorithmString() { result = range.getAlgorithmString() }

  /**
   * Gets the options Node used in the encoding.
   */
  DataFlow::Node getOptions() { result = range.getOptions() }

  /**
   * Checks if the signature gets verified while decoding.
   */
  boolean verifiesSignature() { result = range.verifiesSignature() }
}
