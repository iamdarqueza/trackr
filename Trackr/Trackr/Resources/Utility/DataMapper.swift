//
//  DataMapper.swift
//  Trackr
//
//  Created by Danmark Arqueza on 1/25/21.
//

import Foundation

class DataMapper {
    
    class func parseData(_ data: Data) -> [String: Any]? {
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
            return json
        }catch{
            print(NSString(data: data, encoding: String.Encoding.utf8.rawValue) ?? "Error Instantiating NSString")
            return nil
        }
    }
    
    class func parseListData(_ data: Data) -> [[String: Any]]? {
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String: Any]]
            return json
        }catch{
            print(NSString(data: data, encoding: String.Encoding.utf8.rawValue) ?? "Error Instantiating NSString")
            return nil
        }
    }
    
    class func parseNumberData(_ data: Data) -> NSNumber? {
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSNumber
            return json
        }catch{
            print(NSString(data: data, encoding: String.Encoding.utf8.rawValue) ?? "Error Instantiating NSString")
            return nil
        }
    }
    
    class func parseStringData(_ data: Data) -> String? {
        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        return json as String?
    }
    
    class func parseJSON(_ json: [String: Any]) -> Data? {
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            return data
        } catch let error {
            Console.logError(error: error, message: "Error parsing json to data.")
            return nil
        }
    }
}
