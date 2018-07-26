//
//  InventoryListViewController.swift
//  Motomez
//
//  Created by Maze Geek on 7/23/18.
//  Copyright © 2018 Amit Biswas. All rights reserved.
//

import UIKit
import ObjectMapper


class InventoryListViewController: UIViewController,ApiRequestingDelegate,UIPickerViewDelegate {

    var request = ApiClassViewController()
    var InventoryTypeList = ""
    // Save Get Data
    var InvoiceArray : Array<InvoiceMapper> = []
    let datePicker = UIDatePicker()

    
    @IBOutlet weak var selectDateTextField: UITextField!
    @IBOutlet weak var tableViewBottomConstrains: NSLayoutConstraint!
    
    func getInventoryListSuccess(data:[String:Any])  {
        
        if let invoices = data["data"] as? [[String : Any]]?{
            for item in invoices!{
                 if let parts = item["parts"] as? [[String : Any]]?{
                        for items in parts!{
                            print(items)
                            guard  let NInvoiceArray = Mapper<InvoiceMapper>().map(JSON: item) else {
                             continue
                        }
                    self.InvoiceArray.append(NInvoiceArray)
        
                    }
        
                }
            }
        
        }
        listTableView.reloadData()
    }
    
    
    func getInventoryListFail(data:[String:Any]){
        
        print(data)
        
    }
    

    
    @IBOutlet weak var listTableView: UITableView!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       request.delegate = self
       showDatePicker()

    
        
    }
    
    // DatePickerSelection
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.bordered, target: self, action: #selector(InventoryListViewController.donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.bordered, target: self, action: #selector(InventoryListViewController.cancelDatePicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        selectDateTextField.inputAccessoryView = toolbar
        selectDateTextField.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        selectDateTextField.text = formatter.string(from: datePicker.date)
        InvoiceArray.removeAll()
        self.request.getRequest(date: selectDateTextField.text!, type: self.InventoryTypeList, page: 1, per_page: 100)
        self.view.endEditing(true)
    }

    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }

    
    
    // Inventory Selection List
    @IBAction func selectInventoryAction(_ sender: Any) {
        var actions: [(String, UIAlertActionStyle)] = []
        actions.append(("Receive Inventory List", UIAlertActionStyle.default))
        actions.append(("Return Inventory List", UIAlertActionStyle.default))
        actions.append(("Damage Inventory List", UIAlertActionStyle.default))
        actions.append(("Cancel", UIAlertActionStyle.cancel))

        //self = ViewController
        Alerts.showActionsheet(viewController: self, title: "Select Inventory", message: "Please Select Inventory List", actions: actions) { (index) in
            print("call action \(index)")
            switch (index){
            case 0:
                self.InventoryTypeList = Constants.InventoryType.Receive
                self.tableViewBottomConstrains.constant = 60.0
            case 1:
                self.InventoryTypeList = Constants.InventoryType.Return
                self.tableViewBottomConstrains.constant = 60.0


            case 2:
                self.InventoryTypeList = Constants.InventoryType.DamageReturn
                self.tableViewBottomConstrains.constant = 60.0
            default:
                self.InventoryTypeList = ""
                self.tableViewBottomConstrains.constant = 0.0

            }
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension InventoryListViewController:UITableViewDelegate,UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

       return InvoiceArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: InventoryListCell! = tableView.dequeueReusableCell(withIdentifier: "InventoryListCell") as? InventoryListCell

        if cell == nil {
            let nibName = UINib.init(nibName: "InventoryListCell", bundle: nil)
            
            // register nib
            tableView.register(nibName, forCellReuseIdentifier: "InventoryListCell")
            cell  = tableView.dequeueReusableCell(withIdentifier: "InventoryListCell") as? InventoryListCell
            
        }
        
        cell.invoiceNumber.text = String(InvoiceArray[indexPath.row].number)

        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0

    }






}
