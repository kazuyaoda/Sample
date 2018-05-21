import Foundation

struct LocalObject {
    let fileName: String
    let ext: String
    let path: URL
    lazy var data: Data! = {
        var filePath = path.appendingPathComponent(fileName)
        filePath.appendPathExtension(ext)
        do {
            return try Data(contentsOf: filePath)
        } catch {
            return nil
        }
    }()
    
    init(fileName: String, ext: String, path: URL) {
        self.fileName = fileName
        self.ext = ext
        self.path = path
    }
}
