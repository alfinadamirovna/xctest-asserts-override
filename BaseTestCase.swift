import XCTest

class BaseTestCase: XCTestCase {
  
  override func setUpWithError() throws {
            self.setDefaultContinueAfterFailure()
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
}
