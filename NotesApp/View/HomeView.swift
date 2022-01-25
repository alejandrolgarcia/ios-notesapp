//
//  Home.swift
//  NotesApp
//
//  Created by Luis Garcia on 22/01/22.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var model = ViewModel()
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Notes.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)], animation: .spring()) var results: FetchedResults<Notes>
    
    
    var body: some View {
        NavigationView{
            List{
                ForEach(results) { item in
                    VStack(alignment: .leading){
                        Text(subString(str: item.note ?? "") )
                            .font(.title)
                            .bold()
                        Text(item.date ?? Date(), style: .date)
                    }.contextMenu(ContextMenu(menuItems: {
                        
                        Button(action: {
                            model.sendData(item: item)
                        }){
                            Label(title: { Text("Editar") }, icon: { Image(systemName: "pencil") })
                        }
                        
                        Button(action: {
                            model.deleteData(item: item, context: context)
                        }){
                            Label(title: { Text("Eliminar") }, icon: { Image(systemName: "trash") })
                        }
                        
                    }))

                }
            }
            .navigationBarTitle("Notas")
            .navigationBarItems(trailing: Button( action: {
                model.show.toggle()
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.blue)
            })
            .sheet(isPresented: $model.show, content: {
                AddView(model: model)
            })
        }
    }
    
    func subString(str: String) -> String {
        
        let cadena = str
        
        if str.count < 45 {
            return str
        } else {
            let index = cadena.index(cadena.startIndex, offsetBy: 45)
            return String(cadena.prefix(upTo: index)) + "..."
        }
    }
}
