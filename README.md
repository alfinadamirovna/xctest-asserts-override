# xctest-asserts-override

  ## Usage examples
  
  ### Simple Asserts
  
  1. Simple boolean checks
  
  
  ```
  let expression = { true }
  
  assert("Expression is true")
      .expressionTrue(expression)
      
  assert("Expression is true")
      .expressionFalse(!expression)
  ```
  
  2. Simple nil/not nil checks

```
 let expression = { nil }
  
 assert("Expression is nil")
      .expressionNil(expression)
      
 assert("Expression is NOT nil")
      .expressionNotNil(!expression)
  ```
  
  ### Comparable asserts
  
  1. Equals/Not equals checks

```
  let a = "start"
  let b = "finish"
  
 assert("Expression a is equals to b")
      .expression(a)
      .equalsTo(b)
      
 assert("Expression a is NOT equals to b")
      .expression(a)
      .notEqualsTo(b)
  ```
  
  2. Greater/Less than something checks
```
  let a = 1
  let b = 2
  
 assert("Expression a is greater than b")
      .expression(a)
      .greaterThan(b)
      
 assert("Expression a is greater or equal to b")
      .expression(a)
      .greaterThanOrEqualsTo(b)
      
 assert("Expression a is greater than b")
      .expression(a)
      .lessThan(b)
      
 assert("Expression a is greater or equal to b")
      .expression(a)
      .lessThanOrEqualsTo(b)
  ```
  
  ### Contains asserts

```
let string = "Alf, stop eat cats!"
let word = "cats"

assert("String contains word")
      .expression(a)
      .contains(b)
      
let array = ["cat", "dog"]
let item = "alien"

assert("Array contains item")
      .expression(a)
      .contains(b)
```

### Soft Assertion usage

When you need to make assert with `setDefaultContinueAfterFailure = true` use this construction:

```
self.softAssertation {

  let a = 1
  let b = 2
  
  assert("First Expression is true")
      .expressionTrue(true)
   
  assert("Second Expression is true")
      .expressionTrue(false)
      
  assert("Expression a is greater than b")
      .expression(a)
      .lessThan(b)
}
```
