//
//  ReceiveViewController.swift
//  Motomez
//
//  Created by Maze Geek on 7/2/18.
//  Copyright © 2018 Amit Biswas. All rights reserved.
// // last modify - 07/16 - 4.45 AM

import UIKit
import  BarcodeScanner


// Inventory Type Declared in Global
var inventoryType = ""
class ScanTypeViewController: UIViewController,BarcodeScannerCodeDelegate,BarcodeScannerDismissalDelegate {
    
    //MARK:- Outlets
    @IBOutlet weak var receiveButton: UIButton!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var damageReturnButton: UIButton!
    
    //MARK:- Variables
    var codeArrayReceive = [String]()
    var codeArrayReturn = [String]()
    var codeArrayDamage = [String]()
    
    //MARK:- View load Functions
    override func viewDidLoad() {
        super.viewDidLoad()
//        receiveButton.isHighlighted = false;
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        if  inventoryType != ""{
//            presentScannerView()
//        }
//        
        self.title = Constants.AppString.ScanTypeViewController.PageTitle
    }
    
    //MARK:- Button Press Actions
    @IBAction func receiveButton(_ sender: UIButton) {
        
        inventoryType = Constants.InventoryType.Receive
        presentScannerView()
    }
    
    @IBAction func returnButton(_ sender: UIButton) {
        
        inventoryType = Constants.InventoryType.Return
        presentScannerView()
    }
    
    @IBAction func damageReturnButton(_ sender: UIButton) {
        
        inventoryType = Constants.InventoryType.DamageReturn
        presentScannerView()
    }
    
    //MARK:- Present Scanner Function
    func presentScannerView(){
        
        let scanner = BarcodeScannerViewController()
        scanner.codeDelegate = self
        scanner.dismissalDelegate = self
        present(scanner, animated: true, completion: nil)
    }
    
    //MARK:- BarcodeScannerDelegate Functions
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        
        if inventoryType == "RECEIVE"{
            codeArrayReceive += [code]
        }
        else if inventoryType == "RETURN"{
            codeArrayReturn += [code]
        }
        else{
            codeArrayDamage += [code]
        }
        
        // Alert Implementation
        let alert = UIAlertController(title: "Partsnumber", message: "Product Added Succesfully ", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Scan Again", style: .default) { (action) in
            controller.reset(animated: true)
        }
        alert.addAction(addAction)
        
        // Cancel action when code array lenght is 0
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            self.codeArrayReceive.removeAll()
            controller.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancelAction)
        
        // if inventoryType == "RECEIVE"{
        let finishAction = UIAlertAction(title: "Proceed to list ", style: .default) { (action) in
            
            let inventoryVC:InventoryViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InventoryViewController")  as! InventoryViewController
            inventoryVC.barCodeData = self.codeArrayReceive
            
            if inventoryType == "RECEIVE"{
                inventoryVC.barCodeData = self.codeArrayReceive
            }
            else if inventoryType == "RETURN"{
                inventoryVC.barCodeData = self.codeArrayReturn
            }
            else{
                inventoryVC.barCodeData = self.codeArrayDamage
            }
            
            self.navigationController?.pushViewController(inventoryVC, animated: true)
            controller.dismiss(animated: true, completion: nil)
        }
        alert.addAction(finishAction)
        
        controller.present(alert, animated: true, completion: nil)
        
    }
    
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        print(codeArrayReceive)
        inventoryType = ""
        controller.dismiss(animated: true, completion: nil)
    }
    
}
