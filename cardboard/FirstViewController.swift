//
//  FirstViewController.swift
//  cardboard
//
//  Created by Aakash Thumaty on 2/28/18.
//  Copyright © 2018 Aakash Thumaty. All rights reserved.
//

import UIKit
import Foundation
import Mixpanel

struct card: Codable {
    
    let name: String?
    let merchant: String?
    let features : [String]
    let tags: [String]
    let image: URL?
    let id: String?
    let rcss: [rcs]
    //let RCS: Array<Any>?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case merchant
        case features = "features"
        case image = "image"
        case id
        case tags = "tags"
        case rcss = "recommended_credit_scores"
        //case RCS = "recommended_credit_scores"
        
    }
}

struct feature: Codable {
    
    let f: [String]

}

struct tag: Codable {
    
    let t: [String]

}

struct rcs: Codable{
    let name: String?
}



class FirstViewController: UIViewController {

    @IBOutlet weak var questionCounter: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    
    //Outlet for Buttons
    @IBOutlet weak var optionA: UIButton!
    @IBOutlet weak var optionB: UIButton!
    @IBOutlet weak var optionC: UIButton!
    @IBOutlet weak var optionD: UIButton!
    
    //let allQuestions = apiPleaseWork()
    var questionNumber: Int = 0
    var score: Int = 0
    var selectedAnswer: Int = 0
    let allQuestions = QBank()
    var categories = [String: Int]()
    var cDat = [card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiPleaseWork();
        updateQuestion();

        //updateQuestion();
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func apiPleaseWork(){

        
        guard let gitUrl = URL(string: "https://techcase-cards-api.herokuapp.com/api/v1/cards") else { return }
        URLSession.shared.dataTask(with: gitUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                print("hello \(data)")
                let decoder =  JSONDecoder()
                //this line is special cause the json returns an immediate array of "card" objects
                let cardData = try decoder.decode([card].self, from: data)
                print(cardData)
                
                self.cDat = cardData
                for c in cardData{
                    

                        for item in c.rcss{
                            self.categories[item.name!] = 0
                        }
                        for item in c.features{
                            self.categories[item] = 0
                        }
                        for item in c.tags{
                            self.categories[item] = 0
                        }
//  print("got here \(self.categories)")
                    
                }

            } catch let err {
                print("Err", err)
            }
            }.resume()
    }

    func apiRequest(){


    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func updateQuestion(){
        
        if questionNumber <= allQuestions.list.count - 1{
            
            questionLabel.text = allQuestions.list[questionNumber].question
            questionLabel.numberOfLines = 0

            optionA.layer.cornerRadius = 10
            optionA.clipsToBounds = true
            optionA.titleLabel?.numberOfLines = 0

        optionA.setTitle(allQuestions.list[questionNumber].optionA, for: UIControlState.normal)
            
            optionB.layer.cornerRadius = 10
            optionB.clipsToBounds = true
            optionB.titleLabel?.numberOfLines = 0

        optionB.setTitle(allQuestions.list[questionNumber].optionB, for: UIControlState.normal)
            
            optionC.layer.cornerRadius = 10
            optionC.clipsToBounds = true
            optionC.titleLabel?.numberOfLines = 0

        optionC.setTitle(allQuestions.list[questionNumber].optionC, for: UIControlState.normal)
            
            optionD.layer.cornerRadius = 10
            optionD.clipsToBounds = true
            optionD.titleLabel?.numberOfLines = 0

        optionD.setTitle(allQuestions.list[questionNumber].optionD, for: UIControlState.normal)
            
            
            updateUI()
            
        }else {
            var idNum = ""
            
            let alert = UIAlertController(title: "End of Survey", message: "Are you ready to see the best Credit Card for you?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Reveal!", style: .default, handler: {action in self.showResults(text: idNum)})
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func answerPressed(_ sender: UIButton) {
        if sender.tag == 1 {
            categories[allQuestions.list[questionNumber].A!] = 1
            score += 1
            
            updateQuestion()
        }else if sender.tag == 2{

            
            score += 1
            
            categories[allQuestions.list[questionNumber].B!] = 1
            
        }else if sender.tag == 3{
            categories[allQuestions.list[questionNumber].C!] = 1
            score += 1
            
            updateQuestion()
            
        }else if sender.tag == 4{
            
            categories[allQuestions.list[questionNumber].D!] = 1
            score += 1
            
            updateQuestion()
        }
        
        questionNumber += 1
        updateQuestion()
        print(categories)
        
    }
    
    func showResults(text: String){
        
        var matches: [String] = []
        
        for cat in self.categories.keys{
            if(self.categories[cat] == 1){
                matches.append(cat)
            }
        }
        
        var cScores = [String : Int]()

        var cDict = [String: card]()
        
        for c in self.cDat{
            
            cDict[c.name!] = c
            var megaValues: [String] = []
            for stuff in c.rcss{
                megaValues.append(stuff.name!)
            }
            megaValues.append(contentsOf: c.features)
            megaValues.append(contentsOf: c.tags)
            var counter: IntegerLiteralType = 0
            for val in megaValues{
                if(matches.contains(val)){
                    counter += 1
                    
                }
                cScores[c.name!] = counter
            }
            
        }
        print(cScores)
        var current = 0
        var maxName = ""
        var fts = ""
        for score in cScores{
            if(score.value > current){
                maxName = score.key
                print(score.key)
                current = score.value
            }
        }

        
        
        let viewController:DetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detView") as UIViewController as! DetailViewController
        // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
        viewController.txt = cDict[maxName]?.features.joined(separator: ". ")
        viewController.img = cDict[maxName]?.image
        viewController.titleString = maxName
        
        //Mixpanel.sharedInstance().track("Card Selected",
                                      //properties: ["Card" : maxName])
        //Mixpanel.mainInstance().time(event: "Timer Started")

        
        self.present(viewController, animated: true, completion: nil)

    }
    
    func updateUI(){

        
    }
    

}

