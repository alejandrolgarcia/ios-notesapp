//
//  ViewModel.swift
//  NotesApp
//
//  Created by Luis Garcia on 22/01/22.
//

import Foundation
import CoreData
import SwiftUI

class ViewModel: ObservableObject {
    @Published var note = ""
    @Published var date = Date()
    @Published var show = false
    @Published var updateItem : Notes!
    
    // CoreData
    
    func saveData(context: NSManagedObjectContext) {
        let newNote = Notes(context: context)
        newNote.note = note
        newNote.date = date
        
        do {
            try context.save()
            print("Nota guardada con exito!")
            show.toggle()
        } catch let error as NSError {
            // Aqui se coloca una alerta para indicarle al usuario que no se pudo guardar la data
            print("Error al guardar", error.localizedDescription)
        }
    }
    
    func deleteData(item: Notes, context: NSManagedObjectContext) {
        context.delete(item)
        
        do {
            try context.save()
            print("Nota eliminada con exito!")
        } catch let error as NSError {
            // Aqui se coloca una alerta para indicarle al usuario que no se pudo guardar la data
            print("Error al eliminar nota", error.localizedDescription)
        }
    }
    
    func sendData(item: Notes) {
        updateItem = item
        note = item.note ?? ""
        date = item.date ?? Date()
        show.toggle()
    }
    
    func editData(context: NSManagedObjectContext){
        updateItem.note = note
        updateItem.date = date
        do {
            try context.save()
            print("Item guardado")
            show.toggle()
        } catch let error as NSError {
            print("Error en la edicion,", error.localizedDescription)
        }
        
    }
}
