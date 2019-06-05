import XCTest

import coauthorTests

var tests = [XCTestCaseEntry]()
tests += coauthorTests.__allTests()

XCTMain(tests)
