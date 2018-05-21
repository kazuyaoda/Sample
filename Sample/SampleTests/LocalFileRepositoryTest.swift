import XCTest
@testable import Sample

class LocalFileRepositoryTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSave() {
        let sampleText = "This is test"
        let repository = LocalFileRepository()
        var object: LocalObject = repository.save(fileName: "sample-test.txt", data: sampleText.data(using: .utf8)!)
        
        XCTAssertEqual("sample-test", object.fileName)
        XCTAssertEqual("txt", object.ext)
        let text = String(data: object.data!, encoding: .utf8)
        XCTAssertEqual(sampleText, text)
    }
}
