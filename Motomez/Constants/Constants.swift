//
//  Constants.swift
//  Motomez
//
//  Created by MazeGeek iOS  on 7/20/18.
//  Copyright © 2018 Amit Biswas. All rights reserved.
//

import Foundation


struct Constants {
    
    //MARK:- Inventory Types
    struct InventoryType {
        static let Receive = "RECEIVE"
        static let Return = "RETURN"
        static let DamageReturn = "DAMAGE_RETURN"
    }
    
    //MARK:- Authorization keys and secrets.
    private struct Authorization {
        static let BearerToken = "4bde6bd718112fca2b509206a9972cb6"
    }
    
    private static let AccessToken = Authorization.BearerToken
    
    static func returnAccessToken() -> String {
        return AccessToken;
    }
    
    //MARK:- Api Urls
    struct APPURL {
        
        static let InventoryPostURL = "https://motomaze.mazegeek.com/api/v1/invoice/save"
        
    }
    
    struct APIRequestHeaders {
        
        static let ContentType = "application/json"
        static let X_Requested_With = "XMLHttpRequest"
    }
    
    //MARK:- API json Model constants
    struct InventoryPostModel {
        static let ProductIDKey = "number"
        static let PruductCountKey = "quantity"
    }
    
    //MARK:- App string for titles, labels, buttons etc.
    struct AppString {
        
        struct ScanTypeViewController {
            
            static let PageTitle = "Select Inventory"
            
        }
        
        struct InventoryViewController {
            
            static let InventoryPageTitle = "Inventory"
            
        }
        
        
    }
    
}
