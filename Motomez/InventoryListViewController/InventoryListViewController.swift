//
//  InventoryListViewController.swift
//  Motomez
//
//  Created by Maze Geek on 7/23/18.
//  Copyright © 2018 Amit Biswas. All rights reserved.
//

import UIKit

class InventoryListViewController: UIViewController,ApiRequestingDelegate {
   
    var request = ApiClassViewController()
    
    func getInventoryListSuccess(data:[String:Any])  {
    
        
    }
    
    
    func getInventoryListFail(data:[String:Any]){
        
        
        
    }
    

    
    @IBOutlet weak var listTableView: UITableView!
   
    var inventoryList: [String: Any] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        request.delegate = self
       request.getRequest()
    
        
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
