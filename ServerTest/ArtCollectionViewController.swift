//
//  ArtCollectionViewController.swift
//  ServerTest
//
//  Created by ktds 10 on 14/05/2019.
//  Copyright © 2019 kt ds. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ArtCollectionViewController: UICollectionViewController {
    
    var arts:[ArtModel] = [ArtModel]()
    let keyStr = "4b77617568676f793732634b6a7476" // Key

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        getData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.arts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ArtCollectionViewCell
    
        // Configure the cell
        
        let url = URL(string: self.arts[indexPath.row].thumbImageURL)!
//        let data = try! Data(contentsOf: url)
//
//        let image = UIImage(data: data)
//
//        if let img = image {
//            cell.artImageView.image = img
//        }
        cell.artImageView.load(url: url)
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    func getData() {
        let urlStr = "http://openAPI.seoul.go.kr:8088/\(keyStr)/json/SemaPsgudInfo/1/100"
        
        let serverUrl = URL(string: urlStr)!
        
        let serverData = try! Data(contentsOf: serverUrl)
        
        do {
            let dict = try JSONSerialization.jsonObject(with: serverData, options: []) as! NSDictionary
            
            print(dict)
            
            let root = dict["SemaPsgudInfo"] as! NSDictionary
            let results = root["row"] as! NSArray
            
            for result in results {
                let resultDict = result as! NSDictionary
                
                if let thumbImageURL = resultDict["THUMB_IMAGE"] as? String {
                    let art = ArtModel(title: resultDict["PRDCT_NM_KOREAN"] as? String, artist: resultDict["WRITR_NM"] as? String, thumbImageURL: thumbImageURL)
                    
                    arts.append(art)
                }
            }
            
        } catch let e as NSError {
            print(e.localizedDescription)
        }
        
    }

}

class ArtCollectionViewCell:UICollectionViewCell {
    
    @IBOutlet weak var artImageView: UIImageView!
    
    // 수업코드 :  zk6tQ
}

extension UIImageView {
    func load(url:URL) {
        DispatchQueue.global().async {
            [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
                
            }
        }
    }
}
