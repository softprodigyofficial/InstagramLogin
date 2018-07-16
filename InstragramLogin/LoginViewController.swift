//
//  LoginViewController.swift
//  InstragramLogin
//
//  Created by Administrator on 7/5/18.
//  Copyright © 2018 softprodigy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController,UIWebViewDelegate{
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        webView.delegate = self
        
        signInRequest()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    func signInRequest() {
        URLCache.shared.removeAllCachedResponses()
        
        let url = String(format : "%@?client_id=%@&redirect_uri=%@&response_type=token&scope=%@&DEBUG=True",arguments: [INSTAGRAM_IDS.AUTHURL,INSTAGRAM_IDS.CLIENTID,INSTAGRAM_IDS.REDIRECTURI,INSTAGRAM_IDS.SCOPE])
        let request  = URLRequest.init(url: URL.init(string: url)!)
        webView.loadRequest(request)
    }
    
    func checkRequestForCallingBaseUrl(request : URLRequest)-> Bool   {
        
        let URLSTRING = (request.url?.absoluteString)! as String
        if URLSTRING.hasPrefix(INSTAGRAM_IDS.REDIRECTURI) {
            let range : Range<String.Index> = URLSTRING.range(of: "#access_token")!
            
            getAuthToken(authToken: URLSTRING.substring(from: range.upperBound))
            
            return false
        }
        
        return  true
    }
    
    func getAuthToken(authToken: String) {
        
        print(authToken)
        let url = String(format : "http://api.instagram.com/v1/users/self/media/recent/?access_token%@",authToken)
        
        let req : NSMutableURLRequest = NSMutableURLRequest(url:URL(string: url)!)
        req.httpMethod = "GET"
        req.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        req.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: req as URLRequest) { (data ,respose,error) -> Void in
            if let data = data {
                
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                
                
                let obj = ILListModel.init(object: json ?? [:])

                
                DispatchQueue.main.async {
                    
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
                    
                    vc?.data = obj
                    self.navigationController?.pushViewController(vc!, animated: true)
                }
                
                
                
            }
            }.resume()
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return checkRequestForCallingBaseUrl(request: request)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        activityIndicator.stopAnimating()
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
        activityIndicator.startAnimating(activityData)
    }
}
