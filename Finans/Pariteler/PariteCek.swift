//
//  PariteCek.swift
//  Doviz
//
//  Created by Berkant Beğdilili on 15.05.2020.
//  Copyright © 2020 Berkant Beğdilili. All rights reserved.
//

import Foundation
import SwiftSoup

class PariteCek{
    
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
    
    func kurOlustur() -> [Parite]{
        
        var kontrol = [String]()
        
        var pariteler = [Parite]()
        guard let url = URL(string: "https://www.doviz.com/pariteler") else { return [Parite]() }
        
        do {
            let html = try String(contentsOf: url, encoding: .utf8)
            let elements:Elements = try SwiftSoup.parse(html).select("a")
            
            for link in elements.array(){
                
                let linkHref = try link.attr("href")
                let linkText = try link.text()
                
                if linkHref.contains("/pariteler/") && !linkText.contains("%") && !kontrol.contains(linkHref){
                    kontrol.append(linkHref)
                    
                    let url = "https://www.doviz.com\(linkHref)"
                   
                    let kur = kurGetir(url: url)
                    
                    let parite = Parite(isim: linkText,alis: kur[0], satis: kur[1], fark: kur[2], guncelleme: kur[3])
                    
                    pariteler.append(parite)
                }
            }
            kontrol.removeAll()
            return pariteler
        } catch  {
            print(error.localizedDescription)
            return [Parite]()
        }
    }
    

}
