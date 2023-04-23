//
//  ImageInfo.swift
//  InstaWithoutDBAndCloud
//
//  Created by wzl on 2023/4/22.
//

import Foundation
import RealmSwift

class ImageInfo: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var location: String = ""
    @objc dynamic var image: Data? = nil
    
    override static func primaryKey() -> String? {
        return "title"
    }
    
    var img: UIImage? {
        get {
            guard let data = image else { return nil }
            return UIImage(data: data)
        }
        set {
            image = newValue?.jpegData(compressionQuality: 0.5)
        }
    }
}
