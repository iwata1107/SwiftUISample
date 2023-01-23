//
//  Home.swift
//  TaskApp
//
//  Created by Balaji on 26/09/20.
//

import SwiftUI
import CoreData

struct Home: View {
    @State var today = Date()
    @StateObject var homeData = HomeViewModel()
    /*
    // Fetching Data.....
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)],animation: .spring()) var results : FetchedResults<Task>
    */
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .forward)])
    private var results: FetchedResults<Task>
    
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
            
            VStack(spacing: 0){
                
                HStack{
                    
                    Text("Tasks")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                    Spacer(minLength: 0)
                }
                .padding()
                //.padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                .background(Color.white)
                
                // Empty View....
                
                if results.isEmpty{
                    
                    Spacer()
                    
                    Text("No Tasks !!!")
                        .font(.title)
                        .foregroundColor(.black)
                        .fontWeight(.heavy)
                    
                    Spacer()
                }
                else{
                    
                    ScrollView(.vertical, showsIndicators: false, content: {
                        
                        LazyVStack(alignment: .leading,spacing: 20){
                            
                            ForEach(getAllDataByDate(dates:today)){task in
                                
                                VStack(alignment: .leading, spacing: 5, content: {
                                    
                                    Text(task.content ?? "")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        
                                    Text(task.date ?? Date(),style: .date)
                                        .fontWeight(.bold)
                                })
                                .foregroundColor(.black)
                                .contextMenu{
                                    
                                    Button(action: {homeData.EditItem(item: task)}, label: {
                                        Text("Edit")
                                    })
                                    
                                    Button(action: {
                                        context.delete(task)
                                        try! context.save()
                                    }, label: {
                                        Text("Delete")
                                    })
                                }
                            }
                        }
                        .padding()
                    })
                    //Text(String(getAllDataByPriority(date:Date())))
                    SectionView()
                }
            }
            
            // Add Button...
            
            Button(action: {homeData.isNewData.toggle()}, label: {
                
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(
                    
                        AngularGradient(gradient: .init(colors: [Color("Color"),Color("Color1")]), center: .center)
                    )
                    .clipShape(Circle())
            })
            .padding()
        })
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.black.opacity(0.06)
        .ignoresSafeArea(.all, edges: .all))
        .sheet(isPresented: $homeData.isNewData, content: {
            
            NewDataView(homeData: homeData)
        })
    }
    func getAllData() -> [Task]{
        let persistenceController = PersistenceController.shared
        let context = persistenceController.container.viewContext
        
        let request = NSFetchRequest<Task>(entityName: "Task")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        do {
            let tasks = try context.fetch(request)
            return tasks
        }
        catch {
            fatalError()
        }
    }
    
    func getAllDataByDate(dates:Date) -> [Task]{
            let persistenceController = PersistenceController.shared
            let context = persistenceController.container.viewContext
            
            let request = NSFetchRequest<Task>(entityName: "Task")
            request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
            
        let predicate = NSPredicate(format: "date == %@",dates as CVarArg)
            request.predicate = predicate
            do {
                let tasks = try context.fetch(request)
                return tasks
            }
            catch {
                fatalError()
            }
        }
    
    
    func getAllDataByDayAndPriority(priority:Int) -> [Task]{
            let persistenceController = PersistenceController.shared
            let context = persistenceController.container.viewContext
            
            let request = NSFetchRequest<Task>(entityName: "Task")
            request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
            
            let predicate = NSPredicate(format: "price >= %d",priority)
            request.predicate = predicate
            do {
                let tasks = try context.fetch(request)
                return tasks
            }
            catch {
                fatalError()
            }
        }
    
}

