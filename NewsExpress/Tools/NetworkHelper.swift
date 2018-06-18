
import Foundation
import Alamofire
import SDWebImage

open class NetworkHelper {
    
    class var sharedManager: NetworkHelper {
        struct Static{
            static let instance: NetworkHelper = NetworkHelper()
        }
        return Static.instance
    }
    
    func request(_ method: HTTPMethod
        , _ URLString: String
        , parameters: [String : AnyObject]? = [:]
        , headers: [String : String]? = [:]
        , onView: UIView?, vc: UIViewController, completion:@escaping (Any?) -> Void) {
        
        if let view = onView {
            LoadingOverlay.shared.showProgressView(view)
        }
        
        let URL = GlobalConstants.baseUrl + URLString
        Alamofire.request(URL, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                
                //LoadingOverlay.shared.hideProgressView()
                switch response.result {
                case .success:
                    completion(response.result.value!)
                case .failure(let error):
                    print(error)
                    //AppUtil.showMessage(error.localizedDescription, messageTitle: error.localizedDescription, buttonTitle: "Cancel")
                }
                LoadingOverlay.shared.hideProgressView()
        }
    }
    
    func requestWithoutJSONEncoding(_ method: HTTPMethod
        , _ URLString: String
        , parameters: [String : AnyObject]? = [:]
        , headers: [String : String]? = [:]
        , onView: UIView?, vc: UIViewController, completion:@escaping (Any?) -> Void) {
        
        if let view = onView {
            LoadingOverlay.shared.showProgressView(view)
        }
        let URL = GlobalConstants.baseUrl + URLString
        Alamofire.request(URL, method: method, parameters: parameters, headers: headers)
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    completion(response.result.value!)
                case .failure(let error):
                    print(error)
                }
                LoadingOverlay.shared.hideProgressView()
        }
    }
    
    //Download image in background
    func getImage(_ path: String, forImageView imageView: UIImageView, placeholderImage: String) {
        if URL(string: GlobalConstants.baseUrl + path) != nil {
            imageView.sd_setImage(with: URL(string: GlobalConstants.baseUrl + path), placeholderImage: UIImage(named: placeholderImage) , options:.refreshCached)
        }
    }
}
