import XCTest
import AsyncAlgorithms
@testable import SwiftGoJq

final class QueryTests: XCTestCase {
    func testInit() throws {
        XCTAssertNoThrow(try Query(".valid"))
    }

    func testInit_fail() throws {
        XCTAssertThrowsError(try Query("\\invalid")) { error in
            XCTAssertEqual(error.localizedDescription, """
            unexpected token "\\\\"
            """)
        }
    }

    func testRun() async throws {
        let query = try Query(".key")
        let results1 = try await Array(try query.run("""
        {"key": "value"}
        """))
        XCTAssertEqual(results1, ["\"value\""])
        let results2 = try await Array(try query.run("""
        {"key": ["value"]}
        """))
        XCTAssertEqual(results2, ["[\"value\"]"])
    }

    func testRun_array() async throws {
        let query = try Query(".[].key")
        let results = try await Array(try query.run("""
        [{"key": "value1"}, {"key": "value2"}]
        """))
        XCTAssertEqual(results, ["\"value1\"", "\"value2\""])
    }
}
