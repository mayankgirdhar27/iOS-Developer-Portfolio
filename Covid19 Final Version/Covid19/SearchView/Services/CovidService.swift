



import Foundation
class CovidService {
    func fetchData(country: String,completion: @escaping(CountryResponse?) -> () ) {
        guard let url = URL(string: "https://api.covid19api.com/total/country/\(country)") else {
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) {data,response,error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let responseData = try? JSONDecoder().decode([CountryResponse].self, from: data)
            let covidLast = responseData?.last
            if let countryResponse = covidLast{
                completion(countryResponse)
            }else{
                completion(nil)
            }
        }.resume()
    }
}
