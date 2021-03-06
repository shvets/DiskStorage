import XCTest
import Files
import Await

@testable import DiskStorage

class ConfigFileTests: XCTestCase {
  static let fileName = "test.config"

  let subject: ConfigFile<String> = {
    let path = URL(fileURLWithPath: NSTemporaryDirectory())

    return ConfigFile<String>(path: path, fileName: fileName)
  }()

  func testSave() throws {
    //try File(path: subject.fileName).delete()

    subject.items["key1"] = "value1"
    subject.items["key2"] = "value2"

    if let items = (try Await.await() { handler in
      self.subject.write(handler)
    }) {
      print(try items.prettify())

      XCTAssertEqual(items.keys.count, 2)
    }
    else {
      XCTFail("Error: empty response")
    }
  }

  func testLoad() throws {
    let data = "{\"key1\": \"value1\", \"key2\": \"value2\"}".data(using: .utf8)

    let folder = try Folder(path: ".")
    try folder.createFile(named: ConfigFileTests.fileName, contents: data!)

    if let items = (try Await.await() { handler in
      self.subject.read(handler)
    }) {
      print(try items.prettify())

      XCTAssertEqual(items.keys.count, 2)
    }
    else {
      XCTFail("Error: empty response")
    }
  }
}
