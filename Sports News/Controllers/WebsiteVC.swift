//
//  WebsiteVC.swift
//  Sports News
//
//  Created by Ahmed on 31/12/2022.
//

import UIKit
import WebKit
class WebsiteVC: UIViewController, UIWebViewDelegate, WKNavigationDelegate {

 
    @IBOutlet weak var webview: WKWebView!
    @IBOutlet weak var handelLbl: UILabel!
    
    
    var websitURL : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        websiteContent()
        print(websitURL!)
    }
    
    func websiteContent(){
     
         
            if NSURL(string: self.websitURL!) != nil{
                handelLbl.isHidden = true
                    self.webview.load(NSURLRequest(url: NSURL(string: self.websitURL!)! as URL) as URLRequest)
                    
            }else{
                print("not found")
                handelLbl.isHidden = false
            }
        }
    }
 
