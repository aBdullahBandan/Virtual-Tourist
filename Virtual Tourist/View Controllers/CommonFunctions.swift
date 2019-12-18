//
//  CommonFunctions.swift
//  Virtual Tourist
//
//  Created by Abdullah Bandan on 02/03/1441 AH.
//  Copyright © 1441 AbdullahBandan. All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension UIViewController{
    
    
    func showFailure(title: String, message: String, withOption: Bool) -> UIAlertController {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if(withOption){ return alertVC }else{
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
            return UIAlertController()
        }
    }
    
//    func LoadingActivityIndicator<T:UIView>(_ loadingIn: Bool,imageView: T,tag: Int)  {
//        if(loadingIn){
//            let activityIndicator = UIActivityIndicatorView()
//            activityIndicator.center = imageView.center
//            activityIndicator.color = UIColor.black
//            activityIndicator.startAnimating()
//            activityIndicator.frame = imageView.frame
//            let mainView = UIView()
//            mainView.frame = imageView.frame
//            mainView.center = imageView.center
//            mainView.alpha = 0.5
//            mainView.tag = tag
//            mainView.backgroundColor = UIColor.gray
//            mainView.addSubview(activityIndicator)
//            imageView.addSubview(mainView)
//        }else{ imageView.viewWithTag(tag)?.removeFromSuperview() }
//    }

    
    func LoadingActivityIndicator<T:UIView>(_ loadingIn: Bool,view: T,collectionView: UICollectionView?,tag: Int)  {
        if(loadingIn){
            let activityIndicator = UIActivityIndicatorView()
            activityIndicator.center = view.center
            activityIndicator.color = .gray
            activityIndicator.frame = view.frame
            activityIndicator.contentMode = UIView.ContentMode.scaleAspectFit
            activityIndicator.tag = tag
            activityIndicator.startAnimating()
            if(collectionView == nil){
                view.addSubview(activityIndicator)
            }else{
                collectionView!.backgroundView = activityIndicator
            }
        }else{
            if(collectionView == nil){
            view.viewWithTag(tag)?.removeFromSuperview()
            }else{
                collectionView?.backgroundView = nil
            }
        }
    }
}

extension Data
{
    func printJSON()
    {
        if let JSONString = String(data: self, encoding: String.Encoding.utf8)
        {
            print(JSONString)
        }
    }
    
}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill, completion: @escaping (UIImage) -> Void) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
                completion(image)
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill, completion: @escaping (UIImage) -> Void) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode) { (image) in
            completion(image)
        }
    }
}

