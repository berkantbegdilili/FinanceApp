//
//  Doviz.swift
//  Doviz
//
//  Created by Berkant Beğdilili on 14.05.2020.
//  Copyright © 2020 Berkant Beğdilili. All rights reserved.
//

import Foundation

class Doviz{
    
    var isim:String?
    var alis:String?
    var satis:String?
    var fark:String?
    var guncelleme:String?
    
    init(){ }
    
    init(isim:String, alis:String, satis:String, fark:String, guncelleme:String){
        self.isim = isim
        self.alis = alis
        self.satis = satis
        self.fark = fark
        self.guncelleme = guncelleme
    }
     
}
