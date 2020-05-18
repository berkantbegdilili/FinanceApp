//
//  ViewController.swift
//  Doviz
//
//  Created by Berkant Beğdilili on 14.05.2020.
//  Copyright © 2020 Berkant Beğdilili. All rights reserved.
//

import UIKit

class DovizVC: UIViewController {
    
    
    @IBOutlet weak var loadingBar: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    var list = [Doviz]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTV()
        setupData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.isHidden = false
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        tableView.isHidden = true
    }
    func setupTV(){
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.isHidden = true
        tableView.addSubview(refreshControl)
        refreshControl.attributedTitle = NSAttributedString(string: "Veriler Güncelleniyor...", attributes: nil)
        refreshControl.addTarget(self, action: #selector(refreshTV), for: .valueChanged)
    }
    
    func setupData(){
        DispatchQueue.main.async {
            self.list = DovizCek().kurOlustur()
            
            self.loadingLabel.isHidden = true
            self.tableView.isHidden = false
            self.loadingBar.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    @objc func refreshTV(){
        tableView.isHidden = true
        setupData()
        self.refreshControl.endRefreshing()
    }

}

extension DovizVC: UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DovizTVCell", for: indexPath) as! DovizTVCell
        
        let data = list[indexPath.row]
        
       // Hücredeki Label'a Veri Atama
        cell.isim.text = data.isim!
        cell.alis.text = data.alis!.replacingOccurrences(of: " ", with: "\n")
        cell.satis.text = data.satis!.replacingOccurrences(of: " ", with: "\n")
        cell.guncelleme.text = data.guncelleme!
        cell.fark.text = data.fark!
        
        
        // Fark Renklendirme
        cell.farkImage.tintColor = UIColor.clear
        cell.fark.textColor = UIColor.clear
        
        if cell.fark.text!.contains("-"){
                UIView.animate(withDuration: 1, animations: {
                    
                    cell.farkImage.image = UIImage.init(systemName: "arrow.down.left")
                    cell.farkImage.tintColor = UIColor.red
                    cell.fark.textColor = UIColor.red
                    
                })
        }else{
            UIView.animate(withDuration: 1, animations: {
                
                cell.farkImage.image = UIImage.init(systemName: "arrow.up.right")
                cell.farkImage.tintColor = UIColor.green
                cell.fark.textColor = UIColor.green
                
            })
        }
        
        return cell
    }
    
    
}

