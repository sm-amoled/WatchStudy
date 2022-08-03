//
//  FolderView.swift
//  1_WatchTaskApp WatchKit Extension
//
//  Created by Park Sungmin on 2022/08/03.
//

import SwiftUI

struct FolderView: View {
    
    @FetchRequest (entity: Folder.entity(),
                   // Folder 구조의 엔티티에 대해 Fetch를 요청함
                   sortDescriptors: [NSSortDescriptor(keyPath: \Folder.dateAdded, ascending: false)],
                   // Folder.dataAdded를 기준으로 내림차순으로 정렬하여 값들을 저장함
                   animation: .easeInOut)
    
    var results: FetchedResults<Folder>
    
    
    var body: some View {
        List{
            ForEach(results) { item  in
                HStack {
                    NavigationLink {
                        TodoListView(folderName: item.title ?? "", accentColor: item.colorString ?? "AGreen")
                    } label: {
                        Text(item.title ?? "")
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .contentShape(Rectangle())
                // ContentShape를 정해주면, 버튼에서 레이블이 아닌 빈 공간을 클릭하더라도 액션이 반응하게 만들어줄 수 있다!!
                    .background(LinearGradient(colors: [Color(item.colorString ?? "AGreen"),
                                                        Color(item.colorString ?? "AGreen").opacity(0.8),
                                                        Color(item.colorString ?? "AGreen")],
                                               startPoint: .top,
                                               endPoint: .bottom))
                    .cornerRadius(5)
                }
            }

            NavigationLink {
                AddNewFolder()
            } label: {
                HStack {
                    Spacer()
                    Image(systemName: "plus")
                    Text("New Folder")
                    Spacer()
                }
            }
        }
        .listStyle(CarouselListStyle())
        .navigationTitle("My Folders")
    }
}

struct FolderView_Previews: PreviewProvider {
    static var previews: some View {
        FolderView()
    }
}
