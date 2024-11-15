import Foundation
import Moya

final class CacheManager {
    
    static let shared = CacheManager()
    
    private var cache: [String: Data] = [:] // 값의 타입을 String에서 Data로 변경

    private init() {}

    // 데이터를 캐시
    func cacheData(forKey key: String, data: Answer) {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(data) {
            cache[key] = encodedData
        }
    }

    // 캐시된 데이터 조회
    func getCachedData(forKey key: String) -> Answer? {
        guard let cachedData = cache[key] else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(Answer.self, from: cachedData)
    }

    // 특정 캐시 삭제
    func clearCache(forKey key: String) {
        cache[key] = nil
    }

    // 모든 캐시 삭제
    func clearAllCache() {
        cache.removeAll()
    }
}
