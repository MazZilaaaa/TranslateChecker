import Foundation

public protocol FileReader {
    func read(fileURL: URL, completion: @escaping (Result<Data,  Error>) -> Void)
}

public final class DefaultFileReader {
    private let cache: NSCache<NSURL, NSData>
    private let queue: DispatchQueue
    
    init(
        queue: DispatchQueue = DispatchQueue(label: "DefaultFileReader"),
        cache: NSCache<NSURL, NSData> = NSCache()
    ) {
        self.queue = queue
        self.cache = cache
    }
}

extension DefaultFileReader: FileReader {
    public func read(fileURL: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        if let data: NSData = cache.object(forKey: fileURL as NSURL) {
            completion(.success(data as Data))
        }
        
        queue.async {
            var result: Result<Data, Error>
            do {
                let data = try Data(contentsOf: fileURL)
                result = .success(data)
            } catch {
                result = .failure(error)
            }
            
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
