//
//  AddNewFolder.swift
//  1_WatchTaskApp WatchKit Extension
//
//  Created by Park Sungmin on 2022/08/03.
//

import SwiftUI

struct AddNewFolder: View {
    
    @State private var folderTitle = ""
    @State private var selectedColor = "AGreen"
    
    private var folderColors = ["AGreen", "AJinGreen", "ALightGreen", "ALightYellow"]
    
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentationModel
    
    var body: some View {
        VStack(spacing: 15) {
            TextField("Folder Name", text: $folderTitle)
            
            HStack {
                ForEach(folderColors, id: \.self) { colorName in
                    Circle()
                        .fill(Color(colorName))
                        .frame(width: 20, height: 20)
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: selectedColor == colorName ? 2 : 0)
                        )
                        .onTapGesture {
                            selectedColor = colorName
                        }
                }
            }
            .padding(.horizontal)
            
            Button {
                addFolder()
            } label: {
                Text("Add Folder")
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color.orange)
                    .cornerRadius(15)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.horizontal)
            .disabled(folderTitle.isEmpty)

        }
    }
    
    private func addFolder() {
        let folder = Folder(context: PersistentController.shared.container.viewContext)
        folder.title = folderTitle
        folder.dateAdded = Date()
        folder.colorString = selectedColor
        
        do {
            try context.save()
            presentationModel.wrappedValue.dismiss()
        } catch let err {
            print(err.localizedDescription)
        }
    }
}

struct AddNewFolder_Previews: PreviewProvider {
    static var previews: some View {
        AddNewFolder()
    }
}
