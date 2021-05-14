//
//  ContentView.swift
//  TodoList
//
//  Created by Mayank Girdhar on 13/05/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

//    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State var task: String = ""
    @State private var showNewTaskItem: Bool = false
    
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
          ZStack {
            VStack {
              HStack(spacing: 10) {
                Text("Todo List")
                  .font(.system(.largeTitle, design: .rounded))
                  .fontWeight(.heavy)
                  .padding(.leading, 4)
                Spacer()
                EditButton()
                  .font(.system(size: 16, weight: .semibold, design: .rounded))
                  .padding(.horizontal, 10)
                  .frame(minWidth: 70, minHeight: 24)
                  .background(
                    Capsule().stroke(Color.white, lineWidth: 2)
                  )

              } //: HSTACK
              .padding()
              .foregroundColor(.white)
              Spacer(minLength: 80)
              // MARK: - NEW TASK BUTTON
              
              Button(action: {
                showNewTaskItem = true
                feedback.notificationOccurred(.success)
              }, label: {
                Image(systemName: "plus.circle")
                  .font(.system(size: 30, weight: .semibold, design: .rounded))
                Text("New Task")
                  .font(.system(size: 24, weight: .bold, design: .rounded))
              })
              .foregroundColor(.white)
              .padding(.horizontal, 20)
              .padding(.vertical, 15)
              .background(
                LinearGradient(gradient: Gradient(colors: [Color.black, Color.red]), startPoint: .leading, endPoint: .trailing)
                  .clipShape(Capsule())
              )
              .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0.0, y: 4.0)
              
              // MARK: - TASKS
              
              List {
                ForEach(items) { item in
                  ListRowItemView(item: item)
                }
                .onDelete(perform: deleteItems)
              } //: LIST
              .listStyle(InsetGroupedListStyle())
              .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
              .padding(.vertical, 0)
              .frame(maxWidth: 640)
            } //: VSTACK
            .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
            .transition(.move(edge: .bottom))
            .animation(.easeOut(duration: 0.5))
            
            // MARK: - NEW TASK ITEM
            
            if showNewTaskItem {
              NewTaskItemView(isShowing: $showNewTaskItem)
            }
            
          } //: ZSTACK
          .onAppear() {
            UITableView.appearance().backgroundColor = UIColor.clear
          }
          .navigationBarTitle("Daily Tasks", displayMode: .large)
          .navigationBarHidden(true)
          .background(
            backgroundGradient.ignoresSafeArea(.all)
          )
        } //: NAVIGATION
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

var backgroundGradient: LinearGradient {
  return LinearGradient(gradient: Gradient(colors: [Color.black, Color.red]), startPoint: .leading, endPoint: .topTrailing)
}

