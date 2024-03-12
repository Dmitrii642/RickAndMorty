//
//  APICacheManager.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 07.03.2024.
//

import Foundation

final class APICacheManager {
    
    private var cacheDictionary: [EndPoint: NSCache<NSString, NSData>] = [:]
    
    private var cache = NSCache<NSString, NSData>()
    
    init() {
        setUpCache()
    }
    
    public func cacheResponse(for endpoint: EndPoint, url:  URL?) -> Data? {
        guard let targetCache = cacheDictionary[endpoint],
        let url = url else {
            return nil
        }
        let key = url.absoluteString as NSString
        return targetCache.object(forKey: key) as? Data
    }
    
    public func setCache(for endpoint: EndPoint, url:  URL?, data: Data) {
        guard let targetCache = cacheDictionary[endpoint],
        let url = url else {
            return 
        }
        let key = url.absoluteString as NSString
        return targetCache.setObject(data as NSData, forKey: key)
    }
    
    private func setUpCache() {
        EndPoint.allCases.forEach { endpoint in
            cacheDictionary[endpoint] = NSCache<NSString, NSData>()
        }
    }
}
