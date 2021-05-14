//
//  NewTaskView.swift
//  TodoList
//
//  Created by Mayank Girdhar on 13/05/21.
//

import SwiftUI
import CoreData

struct NewTaskItemView: View {
  // MARK: - PROPERTY
  
  @AppStorage("isDarkMode") private var isDarkMode: Bool = false
  @Environment(\.managedObjectContext) private var viewContext
  @State private var task: String = ""
  @Binding var isShowing: Bool
  
  private var isButtonDisabled: Bool {
    task.isEmpty
  }
  
  // MARK: - FUNCTION
  
  private func addItem() {
    withAnimation {
      let newItem = Item(context: viewContext)
      newItem.timestamp = Date()
      newItem.task = task
      newItem.completion = false

      
      do {
        try viewContext.save()
      } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
      
      task = ""
      hideKeyboard()
      isShowing = false
    }
  }
  
  // MARK: - BODY
  
  var body: some View {
    VStack {
      Spacer()
      
      VStack(spacing: 16) {
        TextField("New Task", text: $task)
          .foregroundColor(.pink)
          .font(.system(size: 24, weight: .bold, design: .rounded))
          .padding()
          .background(
            isDarkMode ? Color(UIColor.tertiarySystemBackground) : Color(UIColor.secondarySystemBackground)
          )
          .cornerRadius(10)
        
        Button(action: {
          addItem()
          feedback.notificationOccurred(.success)
        }, label: {
          Spacer()
          Text("SAVE")
            .font(.system(size: 24, weight: .bold, design: .rounded))
          Spacer()
        })
        .disabled(isButtonDisabled)
        .onTapGesture {
          if isButtonDisabled {
          }
        }
        .padding()
        .foregroundColor(.white)
        .background(isButtonDisabled ? Color.blue : Color.pink)
        .cornerRadius(10)
      } //: VSTACK
      .padding(.horizontal)
      .padding(.vertical, 20)
      .background(
        isDarkMode ? Color(UIColor.secondarySystemBackground) : Color.white
      )
      .cornerRadius(16)
      .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
      .frame(maxWidth: 640)
    } //: VSTACK
    .padding()
  }
}

// MARK: - PREVIEW

struct NewTaskItemView_Previews: PreviewProvider {
  static var previews: some View {
    NewTaskItemView(isShowing: .constant(true))
      .previewDevice("iPhone 12 Pro")
      .background(Color.gray.edgesIgnoringSafeArea(.all))
  }
}


let feedback = UINotificationFeedbackGenerator()

#if canImport(UIKit)
extension View {
  func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
#endif
