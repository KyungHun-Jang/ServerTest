//
//  ArtModel.swift
//  ServerTest
//
//  Created by ktds 10 on 14/05/2019.
//  Copyright © 2019 kt ds. All rights reserved.
//

import Foundation

class ArtModel {
    var title:String?
    var artist:String?
    var thumbImageURL:String
    
    init (title:String?, artist:String?, thumbImageURL:String) {
        self.title = title
        self.artist = artist
        self.thumbImageURL = thumbImageURL
    }
    

}
