//
//  Items.swift
//  ToDoList
//
//  Created by Student on 12/1/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit

class Items: NSObject, NSCoding
{
    var title : String
    var completed = false
    
    init(title: String)
    {
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        title = aDecoder.decodeObject(forKey: "name") as! String
    }
    
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(title, forKey: "name")
    }

}
