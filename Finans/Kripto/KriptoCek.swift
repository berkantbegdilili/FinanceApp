//
//  KriptoCek.swift
//  Doviz
//
//  Created by Berkant Beğdilili on 15.05.2020.
//  Copyright © 2020 Berkant Beğdilili. All rights reserved.
//

import Foundation
import SwiftSoup

class KriptoCek{
    
    func kriptoGetir(url:String) -> [String]{
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
    
    
    func kriptoOlustur() -> [Kripto]{
        
        var kontrol = [String]()
        
        var kriptolar = [Kripto]()
        guard let url = URL(string: "https://www.doviz.com/kripto-paralar") else { return [Kripto]() }
        
        do {
            let html = try String(contentsOf: url, encoding: .utf8)
            let elements:Elements = try SwiftSoup.parse(html).select("a")
            
            for link in elements.array(){
                
                let linkHref = try link.attr("href")
                let linkText = try link.text()
                
                if linkHref.contains("/kripto-paralar/") && !linkText.contains("%") && !kontrol.contains(linkHref){
                    kontrol.append(linkHref)
                    
                    let url = "https://www.doviz.com\(linkHref)"
                   
                    let veri = kriptoGetir(url: url)
                    
                    let kripto = Kripto(isim: linkText, satisDolar: veri[0] , satisTurkLirasi: veri[1], fark: veri[2], guncelleme: veri[3])
                    
                    kriptolar.append(kripto)
                }
            }
            kontrol.removeAll()
            return kriptolar
        } catch  {
            print(error.localizedDescription)
            return [Kripto]()
        }
    }
    
    
}
