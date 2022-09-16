import XCTest

struct AssertMessage {

    let message: () -> String

    func formattedMessage() -> String {
        return "Expected result: \(self.message())"
    }
}

struct AssertExpression<T> {

    let message: AssertMessage

    let expression: () -> T
}

struct AssertCollectionsExpression<T, U> {

    let message: AssertMessage

    let expression: () -> T
}

func assert(_ message: @escaping @autoclosure () -> String) -> AssertMessage {
    return AssertMessage(message: message)
}

// MARK: - AssertMessage + Methods

extension AssertMessage {

    func expressionTrue(_ expression: @autoclosure () -> Bool,
                        file: StaticString = #file,
                        line: UInt = #line) {
        performAssert(self.message()) {
            let expression = expression()
            XCTAssertTrue(expression, self.formattedMessage(), file: file, line: line)
        }
    }

    func expressionFalse(_ expression: @autoclosure () -> Bool,
                         file: StaticString = #file,
                         line: UInt = #line) {
        performAssert(self.message()) {
            let expression = expression()
            XCTAssertFalse(expression, self.formattedMessage(), file: file, line: line)
        }
    }

    func expressionNil(_ expression: @autoclosure () -> Any?,
                       file: StaticString = #file,
                       line: UInt = #line) {
        performAssert(self.message()) {
            let expression = expression()
            XCTAssertNil(expression, self.formattedMessage(), file: file, line: line)
        }
    }

    func expressionNotNil(_ expression: @autoclosure () -> Any?,
                          file: StaticString = #file,
                          line: UInt = #line) {
        performAssert(self.message()) {
            let expression = expression()
            XCTAssertNotNil(expression, self.formattedMessage(), file: file, line: line)
        }
    }

    func expression<T>(_ expression: @escaping @autoclosure () -> T) -> AssertExpression<T> {
        return AssertExpression(message: self, expression: expression)
    }

    func expression<T, U>(_ expression: @escaping @autoclosure () -> T) -> AssertCollectionsExpression<T, U> {
        return AssertCollectionsExpression(message: self, expression: expression)
    }
}

// MARK: - AssertExpression + Methods

extension AssertExpression where T: Equatable {

    func equalsTo(_ expression: @autoclosure () -> T,
                  file: StaticString = #file,
                  line: UInt = #line) {
        performAssert(self.message.message()) {
            let firstExpression = self.expression()
            let secondExpression = expression()
            XCTAssertEqual(firstExpression,
                           secondExpression,
                           self.message.formattedMessage(),
                           file: file,
                           line: line)
        }
    }

    func notEqualsTo(_ expression: @autoclosure () -> T,
                     file: StaticString = #file,
                     line: UInt = #line) {
        performAssert(self.message.message()) {
            let firstExpression = self.expression()
            let secondExpression = expression()
            XCTAssertNotEqual(firstExpression,
                              secondExpression,
                              self.message.formattedMessage(),
                              file: file,
                              line: line)
        }
    }
}

extension AssertExpression where T: Comparable {

    func greaterThan(_ expression: @autoclosure () -> T,
                     file: StaticString = #file,
                     line: UInt = #line) {
        performAssert(self.message.message()) {
            let firstExpression = self.expression()
            let secondExpression = expression()
            XCTAssertGreaterThan(firstExpression,
                                 secondExpression,
                                 self.message.formattedMessage(),
                                 file: file,
                                 line: line)
        }
    }

    func greaterThanOrEqualsTo(_ expression: @autoclosure () -> T,
                               file: StaticString = #file,
                               line: UInt = #line) {
        performAssert(self.message.message()) {
            let firstExpression = self.expression()
            let secondExpression = expression()
            XCTAssertGreaterThanOrEqual(firstExpression,
                                        secondExpression,
                                        self.message.formattedMessage(),
                                        file: file,
                                        line: line)
        }
    }

    func lessThan(_ expression: @autoclosure () -> T,
                  file: StaticString = #file,
                  line: UInt = #line) {
        performAssert(self.message.message()) {
            let firstExpression = self.expression()
            let secondExpression = expression()
            XCTAssertLessThan(firstExpression,
                              secondExpression,
                              self.message.formattedMessage(),
                              file: file,
                              line: line)
        }
    }

    func lessThanOrEqualsTo(_ expression: @autoclosure () -> T,
                            file: StaticString = #file,
                            line: UInt = #line) {
        performAssert(self.message.message()) {
            let firstExpression = self.expression()
            let secondExpression = expression()
            XCTAssertLessThanOrEqual(firstExpression,
                                     secondExpression,
                                     self.message.formattedMessage(),
                                     file: file,
                                     line: line)
        }
    }
}

extension AssertExpression where T: FloatingPoint {

    func equalsTo(_ expression: @autoclosure () -> T,
                  accuracy: T,
                  file: StaticString = #file,
                  line: UInt = #line) {
        performAssert(self.message.message()) {
            let firstExpression = self.expression()
            let secondExpression = expression()
            XCTAssertEqual(firstExpression,
                           secondExpression,
                           accuracy: accuracy,
                           self.message.formattedMessage(),
                           file: file,
                           line: line)
        }
    }
}

extension AssertExpression where T: StringProtocol {

    func contains(_ expression: @autoclosure () -> T,
                  file: StaticString = #file,
                  line: UInt = #line) {
        performAssert(self.message.message()) {
            let firstExpression = self.expression()
            let secondExpression = expression()
            XCTAssertTrue(firstExpression.contains(secondExpression),
                          self.message.formattedMessage(),
                          file: file,
                          line: line)
        }
    }
}

extension AssertCollectionsExpression where T == Array<U>, U: Equatable {

    func contains(_ expression: U,
                  file: StaticString = #file,
                  line: UInt = #line) {
        performAssert(self.message.message()) {
            let firstExpression = self.expression()
            let secondExpression = expression
            XCTAssertTrue(firstExpression.contains(secondExpression),
                          self.message.formattedMessage(),
                          file: file,
                          line: line)
        }
    }
}

private func performAssert(_ description: String, _ block: () -> Void) {
  runActivity?([Assert] \(description)) {
        block()
    }
}

// MARK: Soft Assertation

    /// Set `continueAfterFailure` by default. (`false`)
    func setDefaultContinueAfterFailure() {
        self.continueAfterFailure = false
    }

    func softAssertation(_ block: () throws -> Void) rethrows {
        self.continueAfterFailure = true
        try block()
        self.setDefaultContinueAfterFailure()
    }
