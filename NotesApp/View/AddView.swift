//
//  AddView.swift
//  NotesApp
//
//  Created by Luis Garcia on 22/01/22.
//

import SwiftUI

struct AddView: View {
    
    @ObservedObject var model : ViewModel
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack{
            Text(model.updateItem != nil ? "Editar nota" : "Nueva nota")
                .font(.largeTitle)
                .bold()
            Spacer()
            TextEditor(text: $model.note)
            Divider()
            DatePicker("Fecha", selection: $model.date)
            Spacer()
            
            Button(action: {
                
                if model.updateItem != nil {
                    model.editData(context: context)
                } else {
                    model.saveData(context: context)
                }
                
            }) {
                Label(
                    title: { Text("Guardar").foregroundColor(.white).bold() },
                    icon: { Image(systemName: "plus").foregroundColor(.white) }
                )
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width - 30) // expander en base al tamaño de la pantalla
            .background(model.note == "" ? Color.gray : Color.blue)
            .cornerRadius(8)
            .disabled(model.note == "" ? true : false)
        }
        .padding()
    }
}

