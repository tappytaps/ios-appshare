import XCTest
@testable import AppShare

final class AppShareTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(AppShare().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
