//  ViewController.swift
//  InstragramLogin
//  Created by Administrator on 7/4/18.
//  Copyright © 2018 softprodigy. All rights reserved.

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func push(_ sender: Any) {
        
        
        let defaults = UserDefaults.standard
        var savedArray = [String]()
        if let _ = defaults.array(forKey: "SavedBoolArray")  as? [String] {
        savedArray = defaults.array(forKey: "SavedBoolArray")  as! [String]
        }
        
        if savedArray.count == 0
        {
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(controller, animated: true)
        }
        else
        {
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let controller = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        
    }
    
}
