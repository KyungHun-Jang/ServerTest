//
//  ViewController.swift
//  ServerTest
//
//  Created by ktds 10 on 14/05/2019.
//  Copyright © 2019 kt ds. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentTime: UILabel!
    
    @IBAction func callCurrentTime(_ sender: Any) {
        print("touch button!!")
        
        do {
            //1. URL 설정 및 GET방식으로 API 호출
            let url = URL(string: "http://swiftapi.rubypaper.co.kr:2029/practice/currentTime")
            
            let response = try String(contentsOf: url!)
            
            //2. 읽어온 값을 레이블에 표시
            self.currentTime.text = response
            //self.currentTime.sizeToFit()
            
        } catch let e as NSError {
            print(e.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

