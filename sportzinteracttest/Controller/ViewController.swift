//
//  ViewController.swift
//  sportzinteracttest
//
//  Created by AKSHAY VAIDYA on 15/11/2022 Saka.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var secondflagimg: UIImageView!
    
    @IBOutlet weak var firstflagimg: UIImageView!
    
    @IBOutlet weak var holderview: UIView!
    @IBOutlet weak var teamAlbl: UILabel!
    
    @IBOutlet weak var teamBlbl: UILabel!
    
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var venuelbl: UILabel!
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    
    var teammodel:[Team]?
//    var playermodel = [Player]()
    var strmodel = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        holderview.layer.cornerRadius = 10
        holderview.layer.borderColor = UIColor.lightGray.cgColor
        
        segment.selectedSegmentTintColor = .systemBlue
        holderview.layer.borderWidth = 1
        triggerApi(matchapi: "https://demo.sportz.io/nzin01312019187360.json")
    }

    @IBAction func segmentAct(_ sender: Any) {
        
        segment.selectedSegmentTintColor = .systemBlue
        
        if segment.selectedSegmentIndex == 0 {
            
            let api = "https://demo.sportz.io/nzin01312019187360.json"
            triggerApi(matchapi: api)
        }
        
        if segment.selectedSegmentIndex == 1 {
            
            let api = "https://demo.sportz.io/sapk01222019186652.json"
            triggerApi(matchapi: api)
        }
        
    }
    
    func preparenavigationbar(){
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
     
      
    }

    override func viewWillAppear(_ animated: Bool) {
        preparenavigationbar()
    }
    
    
    func triggerApi(matchapi:String){
        
        Networkrequest.getData(api:matchapi, completion: {model in
            
          //  print(model?.teams["4"]?.nameShort ?? "")
            
            DispatchQueue.main.async { [self] in
                teammodel = Array((model?.teams.values)!)
                
                teammodel = teammodel?.sorted{(a,b)-> Bool in
                    a.nameShort < b.nameShort
                }
                
//                firstflagimg.image = UIImage(named: teammodel?[0].nameShort ?? "")
//                secondflagimg.image = UIImage(named: teammodel?[1].nameShort ?? "")
                
                teamAlbl.text = teammodel?[0].nameFull ?? ""
                teamBlbl.text = teammodel?[1].nameFull ?? ""
                venuelbl.text = model?.matchdetail.venue.name
                timelbl.text = "\(model?.matchdetail.match.date.getDate() ?? ""), \(model?.matchdetail.match.time.getTime() ?? "")"
                //print

                
                print(teammodel ?? [])
                
              
            }
            
        })
        
    }
    
    
    
    @IBAction func navigateToSecond(_ sender: Any) {
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        
        controller.teammodel = teammodel
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension String{
    
    func getDate()->String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let date = formatter.date(from: self)
        
        formatter.dateFormat = "MMM d, yyyy"
        
        let datestr = formatter.string(from: date ?? Date())
        
        return datestr
    }
    
    func getTime()->String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let time = formatter.date(from: self)
        
        formatter.dateFormat = "h:mm a"
        
        let timestr = formatter.string(from: time ?? Date())
        
        return timestr
    }
    
    
    
}
