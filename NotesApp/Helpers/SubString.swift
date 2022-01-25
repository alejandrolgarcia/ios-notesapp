//
//  SubString.swift
//  NotesApp
//
//  Created by Luis Garcia on 23/01/22.
//

import Foundation

class SubString {
    
    func subString(str: String) -> String {
        
        let cadena = str
        
        if str.count < 10 {
            return str
        } else {
            let index = cadena.index(cadena.startIndex, offsetBy: 15)
            return String(cadena.prefix(upTo: index))
        }
    }
    
}
