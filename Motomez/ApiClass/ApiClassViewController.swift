//
//  ApiClassViewController.swift
//  Motomez
//
//  Created by MazeGeek iOS  on 7/20/18.
//  Copyright © 2018 Amit Biswas. All rights reserved.
//

import UIKit
import Alamofire

@objc protocol ApiRequestingDelegate {
    
    
    @objc optional  func getInventoryListSuccess(data: [String:Any])
    @objc optional  func getInventoryListFail(data:[String:Any])
    
}

    
class ApiClassViewController: UIViewController {
    
    var delegate: ApiRequestingDelegate?
    
    
    func postRequest(invoiceNumber:String, type:String, partsArray:[[String : Any]]){
        
        
        let parameters: [String : Any]? = [
            "token": Constants.returnAccessToken(),
            "number":invoiceNumber,
            "type" :type,
            "parts" : partsArray
        ]
        
        // API head
        
        let headers = ["Content-Type": Constants.APIRequestHeaders.ContentType,
                       
                       "X-Requested-With": Constants.APIRequestHeaders.X_Requested_With
            
        ]
        
        //// Base URL and End point
        
        let url = Constants.APPURL.InventoryPostURL
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            print(response)
            
            if response.result.value != nil {
                switch response.result {
                case .success:
                    if let jsonRoot = response.result.value as? [String:Any]!{
                        
                        
                    }
                case .failure(let error):
                    
                    print(error)
                    
                }
            } else{
                print("Check Internet")
            }
            
        }
        
    }

    
    // Get request
    func getRequest(){
        
        let url = "https://motomaze.mazegeek.com/api/v1/invoices"
        print(url)
        let parameters: [String : Any]? = [
            "token": "4bde6bd718112fca2b509206a9972cb6",
            "date":"2018-07-18",
            "type" :"RECEIVE",
            "page" : 1,
            "per_page" : 5
            
        ]
        
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            print(response)
            
            if response.result.value != nil {
                switch response.result {
                case .success:
                    if let jsonRoot = response.result.value as? [String:Any]!{
                        
                       // delegate?.getInventoryListSuccess()
                        
                    }
                    
                case .failure(let error):
                    
                    print(error)
                }
            } else {
                
                print("Check Internet")
                
                
            }
            
        }
        
    }
    
    
    
}
