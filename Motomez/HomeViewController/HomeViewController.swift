//
//  ViewController.swift
//  Motomez
//
//  Created by Maze Geek on 6/22/18.
//  Copyright © 2018 Amit Biswas. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController{
    
    
    //  declairing array for Barcode dictionary
    
    var barCodeData   = ["BM1200123","CH1240128", "MB1000788"]
    
    // Table View Function
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return barCodeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell( style: UITableViewCellStyle.default , reuseIdentifier: "Cell")
        cell.textLabel?.text = barCodeData[indexPath.row]
        return cell
    }
    
    // Button Outlet
    
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    
   
    @IBAction func scanButtonPressed(_ sender: UIButton) {
        
        let scanVC:ScanTypeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScanTypeViewController")  as! ScanTypeViewController
        self.navigationController?.pushViewController(scanVC, animated: true)
    }
    
   
    @IBAction func listButtonPressed(_ sender: UIButton) {
       
        let inventoryListVC:InventoryListViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InventoryListViewController")  as! InventoryListViewController
        self.navigationController?.pushViewController(inventoryListVC, animated: true)
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

}

