import XCTest
@testable import Superscript

final class NoHostProperties: HostContext, @unchecked Sendable {
  func computedProperty(name: String, args: String, callback: ResultCallback) {
    callback.onResult(result: "")
  }
  func deviceProperty(name: String, args: String, callback: ResultCallback) {
    callback.onResult(result: "")
  }
}

final class SuperscriptTests: XCTestCase {
  private func evaluate(_ expression: String) -> String {
    let definition = """
    {"variables":{"map":{"user":{"type":"map","value":{"age":{"type":"int","value":30},\
    "plan":{"type":"string","value":"pro"}}}}},"computed":{},"device":{},"expression":"\(expression)"}
    """
    return evaluateWithContext(definition: definition, context: NoHostProperties())
  }

  func testMatchingExpression() {
    let result = evaluate("user.age > 18 && user.plan == 'pro'")
    XCTAssertTrue(result.contains("true"), result)
  }

  func testNonMatchingExpression() {
    let result = evaluate("user.age < 18")
    XCTAssertTrue(result.contains("false"), result)
  }

  func testInvalidExpressionDoesNotCrash() {
    let result = evaluate("user.age >")
    XCTAssertFalse(result.isEmpty)
  }
}
