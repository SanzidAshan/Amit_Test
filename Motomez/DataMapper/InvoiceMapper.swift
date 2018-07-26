

import Foundation
import ObjectMapper

class InvoiceMapper : Mappable {
    
    
    @objc dynamic var number : String = ""
    @objc dynamic var id : Int = 0
    @objc dynamic var invoice_id : Int = 0
    @objc dynamic var quantity : Int = 0



    required convenience init?(map: Map) {
        
        
        self.init()
        
        
    }
    
    func mapping(map: Map) {
        number <- map["number"]
        id <- map["id"]
        invoice_id <- map["invoice_id"]
        quantity <- map["quantity"]

        
    }
}
