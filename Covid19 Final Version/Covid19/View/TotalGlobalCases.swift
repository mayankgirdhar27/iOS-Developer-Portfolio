//
//  SwiftUIView.swift
//  Covid19
//
//  Created by Mayank Girdhar on 08/09/2020.
//

import SwiftUI


struct TotalGlobalCases: View {
    
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
                            Text("\(self.main.Global.TotalConfirmed)")
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
                            Text("\(self.main.Global.TotalRecovered)")
                                .fontWeight(.bold)
                        }
                        HStack{
                            Image(systemName: "bed.double.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                            Text("Deaths")
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                            Spacer()
                            Text("\(self.main.Global.TotalDeaths)")
                                .fontWeight(.bold)
                        }
                        HStack{
                            Text("")
                        }
                    }
                }
            }

            Spacer()
        }.padding(.all)
        .onAppear{
            self.getData()
        }.navigationTitle("Global Cases")
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


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TotalGlobalCases()
    }
}
