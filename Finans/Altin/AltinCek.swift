//
//  AltinCek.swift
//  Doviz
//
//  Created by Berkant Beğdilili on 15.05.2020.
//  Copyright © 2020 Berkant Beğdilili. All rights reserved.
//

import Foundation
import SwiftSoup

class AltinCek{
    
    func kurGetir(url:String) -> [String]{
        var veriListesi = [String]()
        
        guard let url = URL(string: url) else { return [String]() }
        
        do {
            
            let html = try String(contentsOf: url, encoding: .utf8)
            let element:Elements = try SwiftSoup.parse(html).select("div")
            
            for e in element.array(){
                let data = try e.getElementsByClass("col")
                let count = try data.text().count
                
                if data.hasText() && count<22{
                    try veriListesi.append(data.text())
                }
            }
            return veriListesi
        } catch  {
            print(error.localizedDescription)
            return veriListesi
        }
        
    }
    
    func kurOlustur() -> [Altin]{
        
        var kontrol = [String]()
        
        var altinlar = [Altin]()
        guard let url = URL(string: "https://altin.doviz.com/") else { return [Altin]() }
        
        do {
            let html = try String(contentsOf: url, encoding: .utf8)
            let elements:Elements = try SwiftSoup.parse(html).select("a")
            
            for link in elements.array(){
                
                let linkHref = try link.attr("href")
                let linkText = try link.text()
                
                if linkHref.contains("//altin.doviz.com/") && !linkText.contains("%") && !kontrol.contains(linkHref){
                    kontrol.append(linkHref)
                    
                    let url = "https:\(linkHref)"
                   
                    let kur = kurGetir(url: url)
                    
                    let altin = Altin(isim: linkText,alis: kur[0], satis: kur[1], fark: kur[2], guncelleme: kur[3])
                    
                    altinlar.append(altin)
                }
            }
            kontrol.removeAll()
            return altinlar
        } catch  {
            print(error.localizedDescription)
            return [Altin]()
        }
    }
    

}
