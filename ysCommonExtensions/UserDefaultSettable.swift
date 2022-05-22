//
//  UserDefaultSettable.swift
//  ysCommonExtensions
//
//  Created by Ethan Lee on 2022/05/23.
//

import Foundation

enum UserDefaultSettableError: Error {
    case invalidValue, unableToEncode, unableToDecode
}

protocol UserDefaultNameSpace {}

extension UserDefaultNameSpace {
    
    static func namespace<T>(_ key: T) -> String where T :RawRepresentable {
        return "\(Self.self).\(key.rawValue)"
    }
    
}

protocol UserDefaultSettable: UserDefaultNameSpace {
    
    associatedtype UserDefaultKey: RawRepresentable
    
}

extension UserDefaultSettable where UserDefaultKey.RawValue == String {
    
    static func setObject<Object>(object: Object, forKey key: UserDefaultKey) throws where Object: Encodable {
        do {
            let data = try JSONEncoder().encode(object)
            UserDefaults.standard.set(data, forKey: namespace(key))
        } catch {
            throw UserDefaultSettableError.unableToEncode
        }
    }
    
    static func getObject<Object>(forKey key: UserDefaultKey, castTo type: Object.Type) throws -> Object where Object: Decodable {
        guard let data = UserDefaults.standard.data(forKey: namespace(key)) else {
            throw UserDefaultSettableError.invalidValue
        }
        
        do {
            let object = try JSONDecoder().decode(type, from: data)
            return object
        } catch {
            throw UserDefaultSettableError.unableToDecode
        }
    }
    
    static func set<T>(value: T, forKey key: UserDefaultKey){
        UserDefaults.standard.set(value, forKey: namespace(key))
    }
    
    static func get<T>(forKey key: UserDefaultKey) -> T? {
        return UserDefaults.standard.object(forKey: namespace(key)) as? T
    }
    
}

/// usage
///
//extension UserDefaults {
//
//    struct Sample: UserDefaultSettable {
//        enum UserDefaultKey: String {
//            case test
//        }
//    }
//
//}
//
//struct Job: Codable {
//    let index: Int?
//    let description: String?
//}
//
//UserDefaults.Sample.setObject(object: Job.init(index: 0, description: ""), forKey: .test)
//let obj = UserDefaults.Sample.getObject(forKey: .test, castTo: Job.self)
