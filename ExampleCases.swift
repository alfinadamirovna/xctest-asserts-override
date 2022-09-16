class ExampleCases: BaseTestCase {

  func testExample() {
  
  let a = 1
  let b = 2
  
    self.softAssertation {
  
  assert("First Expression is true")
      .expressionTrue(true)
   
  assert("Second Expression is true")
      .expressionTrue(false)
      
  assert("Expression a is greater than b")
      .expression(a)
      .lessThan(b)
    }
  }
}
