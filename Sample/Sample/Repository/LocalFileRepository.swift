import Foundation

class LocalFileRepository {
    
    func save(fileName: String, data: Data) -> LocalObject {
        
        let files = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsPath = NSURL(fileURLWithPath: files[0])
        let savePath = documentsPath.appendingPathComponent("data")?.appendingPathComponent(getDirName())
        print(savePath!.path)
        do {
            if !FileManager.default.fileExists(atPath: savePath!.path) {
                try FileManager.default.createDirectory(atPath: savePath!.path,
                                                    withIntermediateDirectories: true,
                                                    attributes: nil)
            }
            let filePath = savePath?.appendingPathComponent(fileName)
            try data.write(to: filePath!)
            
            let fileUrl = URL(string: fileName)
            let onlyFileName = fileUrl?.deletingPathExtension().lastPathComponent
            let fileExt = fileUrl?.pathExtension
            
            return LocalObject(fileName: onlyFileName!, ext: fileExt!, path: savePath!)
            
        } catch let error {
            NSLog("Unable to create directory \(error)")
            fatalError("\(error)")
        }
    }
    
    func getAll() -> [LocalObject]? {
        
        if let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            
            do {
                let documentsPath = NSURL(fileURLWithPath: documentDirectory)
                let savePath = documentsPath.appendingPathComponent("data")
                let items = try FileManager.default.contentsOfDirectory(atPath: String(contentsOf: savePath!))
                var isDir : ObjCBool = false
                
                items.forEach { dir in
                    let path = savePath?.appendingPathComponent(dir)
                    do {
                        try FileManager.default.fileExists(atPath: String(contentsOf: path!), isDirectory: &isDir)
                        if !isDir.boolValue {
                            
                        }
                    } catch {
                        
                    }
                }
                
            } catch let error {
                print(error)
            }
        }
        return nil
    }
    
    private func getFilePaths(paths: [String]) -> [String] {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            
        let documentsPath = NSURL(fileURLWithPath: documentDirectory!)
        let savePath = documentsPath.appendingPathComponent("data")
        let items = try FileManager.default.contentsOfDirectory(atPath: String(contentsOf: savePath!))
        var isDir : ObjCBool = false
        
        paths.forEach { dir in
            let path = savePath?.appendingPathComponent(dir)
            do {
                try FileManager.default.fileExists(atPath: String(contentsOf: path!), isDirectory: &isDir)
                if !isDir.boolValue {
                    
                }
            } catch {
                
            }
        }
    }
    
    private func getDirName() -> String {
        let now = Date() // 現在日時の取得
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US") // ロケールの設定
        dateFormatter.dateFormat = "yyyyMMddHHmmsss" // 日付フォーマットの設定
        return dateFormatter.string(from: now)
        /*
        let formatter = DateFormatter()
        formatter.setTemplate(.fullWithoutSlash)
        let now = Date()
        return formatter.string(from: now)
         */
    }
}
