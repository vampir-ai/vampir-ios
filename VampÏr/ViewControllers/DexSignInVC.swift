//
//  DexSignInVC.swift
//  VampÏr
//
//  Created by 60436 on 4/13/18.
//  Copyright © 2018 Spencer Crow. All rights reserved.
//

import UIKit
import ObjectMapper

class DexSignInVC: UIViewController {
    
    @IBOutlet weak var lblUser: UITextField!
    @IBOutlet weak var lblPass: UITextField!
    
    @IBAction func btnLogin(_ sender: Any) {
        login()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vcc = segue.destination as? LinkVC {
            vcc.realLink = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(SignUpVC.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func login() {
        let parameters = ["username":lblUser.text,"password":lblPass.text]
        NetworkCallManager.baseURLRequest(urlString: Endpoints.base + Endpoints.encrypt, parameters: parameters, method: .post, completion: {json in
            let map = Map(mappingType: MappingType.fromJSON, JSON: json)
            let message = Message(map: map)
            UserDefaults.standard.set(message!.message, forKey: "message")
        }, errorHandler: {_ in
            //error modal
            //remove
            fatalError()
        })
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
