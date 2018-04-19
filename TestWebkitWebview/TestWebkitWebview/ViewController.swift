//
//  ViewController.swift
//  TestWebkitWebview
//
//  Created by Mluvi Mac on 15.03.18.
//  Copyright © 2018 Mluvii. All rights reserved.
//

import UIKit
import WebKit
import MluviiChat

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate{
    
    //MARK: Properties
    
    @IBOutlet weak var OpenButton: UIButton!
    var webView:WKWebView!
    var widgetState:Int32 = -1
    var chat: MluviiChat? = nil
    
    func statusUpdate(status: Int32) -> Void{
        print("Update status \(status)")
        widgetState = status
        if(widgetState == 0){
            OpenButton.backgroundColor = UIColor.gray
        }else if(widgetState == 1){
            OpenButton.backgroundColor = UIColor.green
        }else if(widgetState == 2){
            OpenButton.backgroundColor = UIColor.orange
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        chat = MluviiChat()
        chat?.setChatEnded {
            print("Minimize view")
            self.minimizeView()
        }
        chat?.setStatusUpdater(statusF: statusUpdate)
        
        webView = chat?.createWebView(url: "ptr.mluvii.com", companyGuid: "295b1064-cf5b-4a5d-9e05-e7a74f86ae5e", tenantId: "1", presetName: nil, language: nil)
        //webView.frame = CGRect(x: 0,y: 0,width: 0,height: 0)
        self.view.addSubview(webView)
    }
    
    func maximizeWebView(){
        chat?.openChat()
    }
    
    func minimizeView(){
        chat?.resetUrl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Did receive memory warning")
    }
    
    
    //MARK: Actions

    @IBAction func TouchInside(_ sender: Any) {
        if(widgetState != -1){
            maximizeWebView()
        }
    }
    /**/
}

