//
//  SectionView.swift
//  AccountBookSample
//
//  Created by 岩田照太 on 2022/02/09.
//

import SwiftUI
import CoreData

struct SectionView: View {
    @StateObject var homeData = HomeViewModel()
    @Environment(\.managedObjectContext) var context
    @Environment(\.managedObjectContext) var price
    
    /*
    //Fetching Data...
     @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.date, ascending: true)],animation: .spring()) var results : FetchedResults<Task>
     */
    
    @SectionedFetchRequest(
        // グルーピングに利用する要素を指定
        sectionIdentifier: \Task.date?,
        // ソートの指定
        
        sortDescriptors: [NSSortDescriptor(keyPath: \Task.date, ascending: true),
                          NSSortDescriptor(keyPath: \Task.content, ascending: true)],
        animation: .default) var results: SectionedFetchResults<Date?, Task>
    
    var body: some View {
        VStack{
            List {
                ForEach(results) { section in
                    Section(content: {
                        ForEach(section) { item in
                            Text(item.content ?? "")
                        }
                    }, header: {
                        // `section.id` で指定した要素(カテゴリ)を取得可能
                        Text(section.id ?? Date(),style:.date)
                    })
                }
            }
            
        }
    }
}

