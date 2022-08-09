//
//  AddNewTodo.swift
//  1_WatchTaskApp WatchKit Extension
//
//  Created by Park Sungmin on 2022/08/03.
//

import SwiftUI

struct AddNewTodo: View {
    
    var todoItem: Todo?
    
    var accentColor: String
    var folderName: String
    
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentationMode
    
    @State private var todoTitle = ""
    
    var body: some View {
        VStack(spacing: 15) {
            TextField("Add new todo", text: $todoTitle)
            
            Button(action: addUpdateTodo) {
                Text(todoItem == nil ? "Add todo" : "Update")
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color(accentColor))
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .buttonStyle(PlainButtonStyle())
            .disabled(todoTitle.isEmpty)
            
            Button(action: deleteTodo) {
                Text("Delete")
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color(accentColor))
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .buttonStyle(PlainButtonStyle())
            .opacity(todoItem == nil ? 0.0 : 1.0)
        }
        .navigationTitle(todoItem == nil ? "Add Todo" : "Update Todo")
        .onAppear {
            if let todo = todoItem {
                todoTitle = todo.title ?? ""
                
            }
        }
    }
    
    private func addUpdateTodo() {
        let todo = todoItem == nil ? Todo(context: context) : todoItem
        todo?.title = todoTitle
        todo?.dateAdded = Date()
        todo?.folder = folderName
        
        do {
            try context.save()
            presentationMode.wrappedValue.dismiss()
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    private func deleteTodo() {
        if let todo = todoItem {
            context.delete(todo)
            do {
                try context.save()
            } catch let err {
                print(err.localizedDescription)
            }
            
            presentationMode.wrappedValue.dismiss()
        }
    }
}
