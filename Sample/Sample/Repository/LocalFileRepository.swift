import Foundation

class LocalFileRepository {
    
    func save(fileName: String, data: Data) -> LocalObject {
        
        let files = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsPath1 = NSURL(fileURLWithPath: files[0])
        let savePath = documentsPath1.appendingPathComponent(getDirName())
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
