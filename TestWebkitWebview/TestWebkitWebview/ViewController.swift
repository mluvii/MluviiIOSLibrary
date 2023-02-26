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
    var chat: MluviiChatLibrary? = nil
    
    // Funkce, která zpracovává změnu stavu widgetu
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
    
    public func navigationActionDelegate(webView: WKWebView, navigationAction: WKNavigationAction) -> WKWebView? {
        if navigationAction.targetFrame == nil, let url = navigationAction.request.url {
          if url.description.lowercased().range(of: "http://") != nil ||
            url.description.lowercased().range(of: "https://") != nil ||
            url.description.lowercased().range(of: "mailto:") != nil {
            UIApplication.shared.open(url)
          }
        }
      return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        chat = MluviiChatLibrary()
        
        // Nastavení funkce, která určuje, co se má stát při zavření chatu
        chat?.setChatEnded {
            print("Minimize view")
            self.minimizeView()
        }
        
        // Nastavení funkce, která zpracovává změnu stavu
        chat?.setStatusUpdater(statusF: statusUpdate)
        
        // Nastavení funkce, která relaci zpracovává, končí
        chat?.setMluviiEventCallbackFunc(eventF: { event, sessionId in
            print("Event and sessionID", event, sessionId ?? 0)
        })
        
        // Vytvoření WKWebView, které načte url podle zadaného serveru, company GUID, tenant ID, preset name a požadovaného jazyku
        // url, companyGuid a tenantId jsou povinné proměnné, presetName, language a scope můžou být nil
        webView = chat?.createWebView(
            url: "apptest.mluvii.com",
            companyGuid: "295b1064-cf5b-4a5d-9e05-e7a74f86ae5e",
            tenantId: "1",
            presetName: "MluviiSDK",
            language: nil,
            scope: nil,
            navigationActionCustomDelegate: nil
        )
        self.view.addSubview(webView)
    }
    
    // Funkce, která otevře chat ve WebView a maximalizuje ho
    func maximizeWebView(){
        chat?.openChat()
    }
    
    // Funkce, která nastaví rozměry webView na 0,0 a změní url zpět na požadovaný widget
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

