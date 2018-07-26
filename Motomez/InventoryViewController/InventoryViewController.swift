//
//  InventoryViewController.swift
//  Motomez
//
//  Created by Maze Geek on 7/10/18.
//  Copyright © 2018 Amit Biswas. All rights reserved.


import UIKit
import BarcodeScanner

class InventoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    //MARK:- variables
    var postType = String()
    var barCodeData = [String]()
    var arrayPost = [Dictionary<String, Any>]()
    var productsWithCount : [String: Int] = [:]
    
    //MARK:- ApiRequest Object
    var request = ApiClassViewController()
    
    //MARK:- Outlets
    @IBOutlet weak var inventoryTableView: UITableView!
    @IBOutlet weak var invoiceNumberTextfield: UITextField!
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for item in barCodeData {
            productsWithCount[item] = (productsWithCount[item] ?? 0) + 1
        }
        
        for (key, value) in productsWithCount {
            arrayPost.append([Constants.InventoryPostModel.ProductIDKey : key, Constants.InventoryPostModel.PruductCountKey : value])
        }
        
//        print(arrayPost)
        
        inventoryTableView.dataSource = self
        inventoryTableView.delegate = self
        inventoryTableView.allowsSelection = false
        
    }
    
    //MARK:- TableView Delegate Functions
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: InventoryTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "InventoryTableViewCell") as? InventoryTableViewCell
        
        if cell == nil {
            let nibName = UINib.init(nibName: "InventoryTableViewCell", bundle: nil)
            
            // register nib
            tableView.register(nibName, forCellReuseIdentifier: "InventoryTableViewCell")
            cell  = tableView.dequeueReusableCell(withIdentifier: "InventoryTableViewCell") as? InventoryTableViewCell
            
        }
        
        //Adding action to cell buttons
        cell.plusButton.addTarget(self, action: #selector(plusButtonTapped(_:)), for: .touchUpInside)
        cell.minusButton.addTarget(self, action: #selector(minusButtonTapped(_:)), for: .touchUpInside)
        
        let productGroup : [String : Any] = self.arrayPost[indexPath.row]
        
        if let partNumber = productGroup[Constants.InventoryPostModel.ProductIDKey] as? String{
            cell.partnumberLabel.text = partNumber
        } else {
            cell.partnumberLabel.text = "Unknown"
        }
        
        if let numberValue = productGroup[Constants.InventoryPostModel.PruductCountKey] as? Int{
            cell.quantityLabel.text = String(numberValue)
        } else {
            cell.quantityLabel.text = "0"
        }
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsWithCount.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    //MARK:- Button action method
    
    @objc func plusButtonTapped(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: inventoryTableView)
        let indexPath = inventoryTableView.indexPathForRow(at: buttonPosition)
        
        if (indexPath != nil) {
            var cellData = self.arrayPost[(indexPath?.row)!]
            
            var quantity: Int = cellData[Constants.InventoryPostModel.PruductCountKey] as! Int
            quantity += 1
            
            cellData[Constants.InventoryPostModel.PruductCountKey] = quantity
            
            self.arrayPost[(indexPath?.row)!] = cellData
            
            inventoryTableView.reloadRows(at: [indexPath!], with: UITableViewRowAnimation.none)
        }
    }
    
    @objc func minusButtonTapped(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: inventoryTableView)
        let indexPath = inventoryTableView.indexPathForRow(at: buttonPosition)
        
        if (indexPath != nil) {
            var cellData = self.arrayPost[(indexPath?.row)!]
            
            var quantity: Int = cellData[Constants.InventoryPostModel.PruductCountKey] as! Int
            if quantity > 0 {
                
                quantity -= 1
                cellData[Constants.InventoryPostModel.PruductCountKey] = quantity
                self.arrayPost[(indexPath?.row)!] = cellData

                inventoryTableView.reloadRows(at: [indexPath!], with: UITableViewRowAnimation.none)
            }
        }
    }
    
    @IBAction func sendShipmnetData(_ sender: UIButton) {
        
        request.postRequest(invoiceNumber: invoiceNumberTextfield.text!, type:inventoryType, partsArray: arrayPost)
        
    }

    
}
