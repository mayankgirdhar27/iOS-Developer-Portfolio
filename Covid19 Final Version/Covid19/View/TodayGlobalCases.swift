//
//  GlobalView.swift
//  Covid19
//
//  Created by Mayank Girdhar on 16/08/20.
//

import SwiftUI

struct TodayGlobalCases: View {
    var body: some View {
        Home()
    }
    
}


struct GlobalView_Previews: PreviewProvider {
    static var previews: some View {
        TodayGlobalCases()
    }
}

struct Home: View {
    
    @State var index = 0
    @State var main: MainData!
    var body: some View{
        NavigationView{
        VStack(alignment:.center) {
            if self.main != nil{
                VStack {
                    VStack(spacing: 18) {
                        HStack(){
                            Image(systemName: "cross.case.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                            Text("Confirmed cases")
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                            Spacer()
                            Text("\(self.main.Global.NewConfirmed)")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                        }
                        HStack{
                            Image(systemName: "staroflife.circle.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                            Text("Recovered")
                                .font(.system(size: 18))
                                .fontWeight(.medium)                            
                            Spacer()
                            Text("\(self.main.Global.NewRecovered)")
                                .fontWeight(.bold)
                        }
                        HStack{
                            Image(systemName: "bed.double.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                            Text("Deaths")
                                .fontWeight(.medium)
                                .font(.system(size: 18))
                            Spacer()
                            Text("\(self.main.Global.NewDeaths)")
                                .fontWeight(.bold)
                        }
                    }
                }
            }
            Spacer()
        }.padding(.all)
        .onAppear{
            self.getData()
        }
        .navigationTitle(Text("Today"))
        }
    }
    
    func getData() {
        
        var url = ""
        
        if self.index == 0{
            url = "https://api.covid19api.com/summary"
        }
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) {(data, _, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            let decodedData = try! JSONDecoder().decode(MainData.self, from: data!)
            self.main = decodedData
            print(decodedData)
            
        }
        .resume()
    }
    
    
}

//DATA MODEL


struct MainData: Decodable {
    
    var Global: Globals
    
}

struct Globals: Decodable {
    var NewConfirmed: Int
    var TotalConfirmed: Int
    var NewRecovered: Int
    var TotalDeaths: Int
    var NewDeaths: Int
    var TotalRecovered: Int
}
