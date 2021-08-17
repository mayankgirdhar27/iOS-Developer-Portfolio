//
//  MediaButtonView.swift
//  PrivateEye
//
//  Created by Mayank Girdhar on 24/05/21.
//

import SwiftUI


struct MediaButton: View {
    
    let list: CaseEntity
    let fetchedResults: FetchRequest<SavedMediaEntity>
    init(list: CaseEntity) {
        self.list = list
        self.fetchedResults = FetchRequest<SavedMediaEntity>(fetchRequest: PersistenceProvider.default.savedMediaRequest(for: list))
    }
    
    var body: some View {
        HStack {
            Image(systemName: "folder.fill")
                .font(.system(size: 30))
                .foregroundColor(Color(#colorLiteral(red: 0.09019607843, green: 0.0862745098, blue: 0.137254902, alpha: 1)))
                .padding(.leading, 15)
            Spacer()
            VStack {
                Text("Digital Evidence")
                    .font(.system(size: 19, weight: .bold, design: .rounded))
                    .foregroundColor(Color(#colorLiteral(red: 0.09019607843, green: 0.0862745098, blue: 0.137254902, alpha: 1)))
                Text("\(count()) Photos & Videos")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
            }
            Spacer()

        }
        .frame(width: UIScreen.main.bounds.width - 100, height: 80)
        .cornerRadius(30)
        .padding(.top)
      
    }
    
    func count() -> Int{
        let totalCount = fetchedResults.wrappedValue.count
        return totalCount
    }
}
