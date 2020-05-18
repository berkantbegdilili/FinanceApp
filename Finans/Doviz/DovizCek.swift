//
//  DovizCek.swift
//  Doviz
//
//  Created by Berkant Beğdilili on 14.05.2020.
//  Copyright © 2020 Berkant Beğdilili. All rights reserved.
//

import Foundation
import SwiftSoup

class DovizCek{
    
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
    
    func kurOlustur() -> [Doviz]{
        
        var kontrol = [String]()
        
        var dovizler = [Doviz]()
        guard let url = URL(string: "https://kur.doviz.com/") else { return [Doviz]() }
        
        do {
            let html = try String(contentsOf: url, encoding: .utf8)
            let elements:Elements = try SwiftSoup.parse(html).select("a")
            
            for link in elements.array(){
                
                let linkHref = try link.attr("href")
                let linkText = try link.text()
                
                if linkHref.contains("serbest-piyasa") && !linkText.contains("%") && !kontrol.contains(linkHref){
                    kontrol.append(linkHref)
                    
                    let url = "https:\(linkHref)"
                   
                    let kur = kurGetir(url: url)
                    
                    let doviz = Doviz(isim: linkText,alis: kur[0], satis: kur[1], fark: kur[2], guncelleme: kur[3])
                    
                    dovizler.append(doviz)
                }
            }
            kontrol.removeAll()
            return dovizler
        } catch  {
            print(error.localizedDescription)
            return [Doviz]()
        }
    }
}
