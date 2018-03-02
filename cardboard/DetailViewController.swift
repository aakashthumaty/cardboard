//
//  DetailView.swift
//  cardboard
//
//  Created by Aakash Thumaty on 3/1/18.
//  Copyright © 2018 Aakash Thumaty. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController{
    
    @IBOutlet weak var imgView: UIImageView!
    var txt: String?
    var img: URL?
    var titleString: String?
    @IBOutlet weak var txtField: UITextView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtField.text = txt
        titleLabel.text = titleString
        
        let imageUrl = img
        //create a URL Session, this time a shared one since its a simple app
        let session = URLSession.shared
        //then create a URL data task since we are getting simple data
        let task = session.dataTask(with:imageUrl!) { (data, response, error) in
            if error == nil {
                //incase of success, get the data and pass it to the UIImage class
                let downloadedImage = UIImage(data: data!)
                //then we run the UI updating on the main thread.
                DispatchQueue.main.async {
                    self.imgView.image = downloadedImage
                }
            }
        }
        //then start the task or resume it
        task.resume()
        
        //updateQuestion();
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
}
