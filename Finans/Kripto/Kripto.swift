//
//  Kripto.swift
//  Doviz
//
//  Created by Berkant Beğdilili on 15.05.2020.
//  Copyright © 2020 Berkant Beğdilili. All rights reserved.
//

import Foundation

class Kripto{
    
    var isim:String?
    var satisDolar:String?
    var satisTurkLirasi:String?
    var fark:String?
    var guncelleme:String?
    
    init(){ }
    
    init(isim:String, satisDolar:String, satisTurkLirasi:String, fark:String, guncelleme:String){
        self.isim = isim
        self.satisDolar = satisDolar
        self.satisTurkLirasi = satisTurkLirasi
        self.fark = fark
        self.guncelleme = guncelleme
    }
    
}
