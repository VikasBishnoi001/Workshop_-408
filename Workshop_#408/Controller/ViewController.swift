//
//  ViewController.swift
//  Workshop_#408
//
//  Created by Leewayhertz on 13/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    var myAllData = [MyCellModel] ()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myAllData = MyCellData.getMyAllData()
//        print(myAllData)
        
    }


}
extension UIImageView {
    func downloadImage (from url:URL)
    {
       
//        contentMode = .scaleToFill
        let dataTask = URLSession.shared.dataTask (with: url, completionHandler: {
            (data, response, error ) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode
                    == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage (data: data)
            else
            {
                print("Error Occured While Accesing Image From URL")
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        })
        dataTask.resume()
    }
}


extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myAllData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! MyCollectionViewCell
        let urlImage = URL (string: myAllData[indexPath.row].url)
        let title = myAllData[indexPath.row].title
        let words = title.components(separatedBy: " ")
        let truncatedTitle = words.prefix(2).joined(separator: " ")
        cell.myLableText.text = truncatedTitle
        cell.myImageView.downloadImage(from: urlImage!)
        cell.myImageView.contentMode = .scaleToFill
        cell.myImageView.layer.borderColor = UIColor.black.cgColor
        cell.myImageView.layer.borderWidth = 2
        cell.myImageView.layer.cornerRadius = 20
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width-10)/2
        return CGSize (width: size, height: size)
    }
    
    
    
    
}
