//
//  UserDefaults.swift
//  WebBrowser
//
//  Created by MahmoudRamadan on 12/10/20.
//  Copyright © 2020 MahmoudRamadan. All rights reserved.
//

import UIKit

extension UserDefaults{
    var lastURL  : URL?{
        get{
           return  url(forKey: "url.last") ??
            URL(string: "https://visualgo.net/en")
        }
        set{
            set(newValue, forKey: "url.last")
        }
    }
}

extension UIBarButtonItem{
    convenience init(fixedSpaceWidth : CGFloat) {
        self.init(barButtonSystemItem : .fixedSpace ,target:nil , action:nil)
        width = fixedSpaceWidth
    }
}
