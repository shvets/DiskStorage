import XCTest
import Await

@testable import DiskStorage

final class DiskStorageTests: XCTestCase {
  func testStorage() throws {
    struct Timeline: Codable, Equatable {
      let tweets: [String]
    }

    let path = URL(fileURLWithPath: NSTemporaryDirectory())
    let storage = DiskStorage(path: path)

    let timeline = Timeline(tweets: ["Hello", "World", "!!!"])

    try Await.await() { handler in
      storage.write(timeline, for: "timeline", handler)
    }

    let result = try Await.await() { handler in
     storage.read(Timeline.self, for: "timeline", handler)
    }

    if let result = result {
      print(try result.prettify())

      XCTAssertEqual(result, timeline)
    }
    else {
      XCTFail("Error: empty response")
    }
  }
}
