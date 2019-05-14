//
//  PostViewController.swift
//  ServerTest
//
//  Created by ktds 10 on 14/05/2019.
//  Copyright © 2019 kt ds. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var userId: UITextField!
    @IBOutlet weak var name: UITextField!
    
    @IBAction func post(_ sender: Any) {
        let userId = (self.userId.text)!
        let name = (self.name.text)!
        
        let param = "userId=\(userId)&name=\(name)"
        let paramData = param.data(using: .utf8)
        
        let url = URL(string: "http://swiftapi.rubypaper.co.kr:2029/practice/echo")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = paramData
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(String(paramData!.count), forHTTPHeaderField: "Content-Length")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let e = error {
                print("An error has occured : \(e.localizedDescription)")
                return
            }
            
            // JSON
            DispatchQueue.main.async() {
                do {
                    let object = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                    
                    guard let jsonObject = object else {
                        return
                    }
                    
                    let result = jsonObject["result"] as? String
                    let timestamp = jsonObject["timestamp"] as? String
                    let userId = jsonObject["userId"] as? String
                    let name = jsonObject["name"] as? String
                    
                    
                    
                    
                    
                } catch let e as NSError {
                    print(e.localizedDescription)
                }
            }
        }
        
        task.resume()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
