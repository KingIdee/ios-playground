import Siesta

class UtmePrepAPI {
    
    static let sharedInstance = UtmePrepAPI()
    
    private let service = Service(baseURL: "https://api.yelp.com/v3", standardTransformers: [.text, .image, .json])
    
    private init() {
        
        SiestaLog.Category.enabled = [.network, .pipeline, .observers]
        
        service.configure("**") {
            
            $0.headers["Authorization"] =
            "Bearer B6sOjKGis75zALWPa7d2dNiNzIefNbLGGoF75oANINOL80AUhB1DjzmaNzbpzF-b55X-nG2RUgSylwcr_UYZdAQNvimDsFqkkhmvzk6P8Qj0yXOQXmMWgTD_G7ksWnYx"
            
            $0.expirationTime = 60 * 60 // 60s * 60m = 1 hour
        }
    }
    
    func restaurantList(for location: String) -> Resource {
        return service
            .resource("/businesses/search")
            .withParam("term", "pizza")
            .withParam("location", "Atlanta")
    }
    
}
