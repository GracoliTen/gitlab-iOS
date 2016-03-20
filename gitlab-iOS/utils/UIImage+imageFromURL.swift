//
//  UIImage+imageFromURL.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/3/20.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import UIKit
import Alamofire
import PromiseKit


func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
    NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
        completion(data: data, response: response, error: error)
        }.resume()
}


extension UIImage {
    class func imageFromURL(URL URLString:URLStringConvertible?,completion:(UIImage?->Void)) {
        guard
            let URLString = URLString,
            let URL = NSURL(string: URLString.URLString)
            else {completion(nil); return}
        getDataFromUrl(URL) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard
                    let data = data where error == nil,
                    let image = UIImage(data: data)
                    else {completion(nil); return}
                completion(image)
            }
        }
    }
}
    
    //e
//extension UIImage {
//    class func imageFromURL(URL:URLStringConvertible) -> Promise<UIImage> {
//        return getDataFromUrl(NSURL(string: URL.URLString)!).then({ (data:NSData) -> Promise<UImage> in
//            return Promise { (fulfill:(UIImage->Void), reject:(ErrorType->Void)) in
//                guard let image = UIImage(data: data) else {
//                    reject(NSError(domain: "", code: 0, userInfo: nil))
//                    return
//                }
//                fulfill(image)
//            }
//        })
//    }
////        class func imageFromURL(URL:URLStringConvertible?) -> Promise<UIImage> {
////        return Promise { fulfill, reject in
////            guard let theURL = URL else {
////                reject(NSError(domain: "URL is nil", code: 0, userInfo: nil))
////                return
////            }
////            Alamofire.request(Alamofire.Method.GET, theURL).responseData { (res) -> Void in
////                if let err = res.result.error {
////                    reject(err)
////                } else if let data = res.result.value {
////                    let image = UIImage(data: data)
////                    if image == nil {
////                        
////                        print ("data corrupted,url \(theURL)")
////                    } else {
////                        fulfill(image!)
////                    }
////                }
////            }
////        }
////    }
//}
//
//
//func getDataFromUrl(url:NSURL) -> Promise<NSData> {
//    return Promise { fulfill, reject in
//        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
//            //        completion(data: data, response: response, error: error)
//            guard data != nil else {
//                reject(error!)
//                return
//            }
//            fulfill(data!)
//        }.resume()
//    }
//}
//
