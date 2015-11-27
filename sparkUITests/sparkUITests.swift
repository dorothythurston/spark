import XCTest
@testable import spark

class AuthenticationViewControllerUITests: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCorrectLoginCredentialsEnablesContinueButton() {
        let app = XCUIApplication()
        XCTAssertFalse(app.buttons["sign in"].enabled)
        let sparkElementsQuery = app.otherElements.containingType(.StaticText, identifier:"Spark")
        let textField = sparkElementsQuery.childrenMatchingType(.TextField).elementBoundByIndex(0)
        textField.tap()
        textField.typeText("d@d.com")
        
        let textField2 = sparkElementsQuery.childrenMatchingType(.TextField).elementBoundByIndex(1)
        textField2.tap()
        textField2.tap()
        textField2.typeText("d1H")
        XCTAssert(app.buttons["sign in"].enabled)
    }
    
    func testIncorrectLoginCredentialsDoesNotEnableContinueButton() {
        let app = XCUIApplication()
        XCTAssertFalse(app.buttons["sign in"].enabled)
        let sparkElementsQuery = app.otherElements.containingType(.StaticText, identifier:"Spark")
        let textField = sparkElementsQuery.childrenMatchingType(.TextField).elementBoundByIndex(0)
        textField.tap()
        textField.typeText("fffnotanemail")
        XCTAssertFalse(app.buttons["sign in"].enabled)
        
        textField.typeText("acorrectemail@address.com")
        let textField2 = sparkElementsQuery.childrenMatchingType(.TextField).elementBoundByIndex(1)
        textField2.tap()
        textField2.typeText("anincorrectpassword")
        XCTAssertFalse(app.buttons["sign in"].enabled)
        
        textField.tap()
        textField.typeText("")
        XCTAssertFalse(app.buttons["sign in"].enabled)
    }
}
