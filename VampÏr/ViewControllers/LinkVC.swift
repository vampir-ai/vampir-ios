//
//  LinkVC.swift
//  VampÏr
//
//  Created by 60436 on 4/13/18.
//  Copyright © 2018 Spencer Crow. All rights reserved.
//

import UIKit

class LinkVC: UIViewController {
    var realLink = false
    var histLink = false
    @IBOutlet weak var HistCheck: UILabel!
    @IBOutlet weak var RealCheck: UILabel!
    @IBAction func btnHist(_ sender: Any) {
        HistCheck.textColor = UIColor.green
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "hist")
        //defaults.setBool(value: true, forKey: "hist")
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
