//
//  LinkVC.swift
//  VampÏr
//
//  Created by 60436 on 4/13/18.
//  Copyright © 2018 Spencer Crow. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class LinkVC: UIViewController, UIWebViewDelegate {
    var realLink = false
    var histLink = false
    var sessionId:SessionId?
    @IBOutlet weak var HistCheck: UILabel!
    @IBOutlet weak var RealCheck: UILabel!
    @IBAction func btnHist(_ sender: Any) {
        let parameters: HTTPHeaders = ["Authorization": UserDefaults.standard.object(forKey: "token") as! String]
        NetworkCallManager.baseURLRequest(urlString: Endpoints.base + Endpoints.oauth, parameters:[:], method: .post, header: parameters, completion: {json in
            let map = Map(mappingType: MappingType.fromJSON, JSON: json)
            self.sessionId = SessionId(map: map)
            
            let webV:UIWebView = UIWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            webV.loadRequest(URLRequest(url: URL(string: "https://api.dexcom.com/v1/oauth2/login?client_id=Nqsx3FAK4N0xLcDvkQH0ACFhuMNS86Rb&redirect_uri=http://vampirai.ryanberger.me/api/oauth&response_type=code&scope=offline_access&state=" + self.sessionId!.sessionId!)!))
            webV.delegate = self;
            self.view.addSubview(webV)
            
        }, errorHandler: {_ in})
    }
    
        

    @IBAction func btnReal(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        histLink = defaults.bool(forKey: "hist")
        if histLink == true{
            HistCheck.textColor = UIColor.green
        }
        if realLink == true{
            RealCheck.textColor = UIColor.green
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        if (histLink == true && realLink == true) {
            self.performSegue(withIdentifier: "Graph", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool{
        if request.url?.absoluteString == "https://api.dexcom.com/v1/oauth2/login?client_id=Nqsx3FAK4N0xLcDvkQH0ACFhuMNS86Rb&redirect_uri=http://vampirai.ryanberger.me/api/oauth&response_type=code&scope=offline_access&state=" + self.sessionId!.sessionId! {
        } else if (request.url?.absoluteString.contains("http://vampirai.ryanberger.me"))!{
            webView.removeFromSuperview()
        }
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
