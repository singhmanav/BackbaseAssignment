import Foundation

// MARK: - AboutPresenter protocl

public protocol AboutPresenter {
    func loadAboutInfo()
    func aboutInfoDidLoad(aboutInfo: AboutInfoData)
    func aboutInfoDidFailLoading(error: ModelError)
}

// MARK: - Presenter implementation

public final class Presenter: AboutPresenter {
    private weak var view: AboutView?
    private let model: AboutModel
    private let city: City
    
    public init(view: AboutView?, model: AboutModel,city:City) {
        self.view = view
        self.model = model
        self.city = city
    }
    
    public func loadAboutInfo() {
        self.view?.setActivityIndicator(hidden: false)
        self.model.loadAboutInfo(with: self)
    }
    
    public func aboutInfoDidLoad(aboutInfo: AboutInfoData) {
        self.view?.setActivityIndicator(hidden: true)
        var aboutInfoData = aboutInfo
        aboutInfoData.city = self.city.name
        aboutInfoData.country = self.city.country
        aboutInfoData.longitude = "\(self.city.coord.lon)"
        aboutInfoData.latitude = "\(self.city.coord.lat)"
        self.view?.configure(with: aboutInfoData)
    }
    
    public func aboutInfoDidFailLoading(error: ModelError) {
        self.view?.setActivityIndicator(hidden: true)
        self.view?.display(error: error)
    }
}
