//
//  ViewController2.swift
//  sportzinteracttest
//
//  Created by AKSHAY VAIDYA on 15/11/2022 Saka.
//

import UIKit

class ViewController2: UIViewController{
   
    

  
    @IBOutlet weak var listview: UITableView!
    
    var teammodel:[Team]? = nil
    
    var primeteammodel:[Team]? = nil
    
    var playermodel:[Player]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
       primeteammodel = teammodel
        // Do any additional setup after loading the view.
        preparenavigationbar()
   
        prepareTable()
    }
    
    func preparenavigationbar(){
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .white
        
      self.title = "PLAYER INFORMATION"
     let listbutton = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target: self, action: #selector(filterlist))

     
   

        navigationItem.rightBarButtonItem = listbutton
    }
    
   
    func prepareTable(){
        
        listview.delegate = self
        listview.dataSource = self
        listview.separatorColor = .clear
        listview.register(UINib(nibName: "nameCell", bundle: nil), forCellReuseIdentifier: "nameCell")
        
        
    }
    
 
  

}

extension ViewController2: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return teammodel?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     
        return teammodel?[section].nameFull
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view1 = UIView()
        
     view1.backgroundColor = UIColor(red: 233/255, green: 160/255, blue: 122/255, alpha: 1)
        
        let lbl = UILabel()
        let img = UIImageView()
        
        lbl.text = teammodel?[section].nameFull
        img.image = UIImage(named: teammodel?[section].nameShort ?? "")
        
        view1.addSubview(lbl)
        view1.addSubview(img)
      
        lbl.translatesAutoresizingMaskIntoConstraints = false
        img.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([lbl.centerYAnchor.constraint(equalTo: img.centerYAnchor), lbl.leadingAnchor.constraint(equalTo: img.trailingAnchor, constant: 10)])
        
        NSLayoutConstraint.activate([img.centerYAnchor.constraint(equalTo: view1.centerYAnchor), img.leadingAnchor.constraint(equalTo: view1.leadingAnchor, constant: 10), img.widthAnchor.constraint(equalToConstant: 45), img.heightAnchor.constraint(equalToConstant: 30)])
        
        return view1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       
        return teammodel?[section].players.values.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell") as! nameCell
        playermodel = Array((teammodel?[indexPath.section].players.values)!)
        
        cell.selectionStyle = .none
        
        if let playermodel = playermodel {
            cell.setData(model: playermodel[indexPath.row])
        }
       
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        playermodel = Array((teammodel?[indexPath.section].players.values)!)
   
        
        showAlert(indexPath: indexPath)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

}


extension ViewController2{
    
    @objc func filterlist(){
        
        let teamA = primeteammodel?[0].nameFull
        let teamB = primeteammodel?[1].nameFull
        
        let alert = UIAlertController(title: "Choose Team", message: "", preferredStyle: .actionSheet)
        
        let teamAaction = UIAlertAction(title: teamA, style: .default, handler: {action in
            
            self.teammodel = self.primeteammodel?.filter{$0.nameFull == teamA}
            self.listview.reloadData()
        })
        
        let teamBaction = UIAlertAction(title: teamB, style: .default, handler: {action in
            
            self.teammodel = self.primeteammodel?.filter{$0.nameFull == teamB}
            self.listview.reloadData()
        })
        let teamaction = UIAlertAction(title: "All", style: .default, handler: {action in
            
            self.teammodel = self.primeteammodel
            self.listview.reloadData()
        })
        alert.addAction(teamAaction)
        alert.addAction(teamBaction)
        alert.addAction(teamaction)
        
        self.present(alert, animated: true)
        
    }
    
    
    func showAlert(indexPath:IndexPath){
        
        let lbl = UILabel()
        let lbl2 = UILabel()
        var style = playermodel?[indexPath.row].bowling.style ?? ""
        
        style = (style == "") ? "N/A" : style
        
        let battinstyle = "Batting Style: \(playermodel?[indexPath.row].batting.style.rawValue ?? "")"
        let bowlingstyle = "Bowling Style: \(style)"
      
      
        lbl.text = bowlingstyle
        lbl.font = lbl.font.withSize(16)
        lbl2.text = battinstyle
        lbl2.font = lbl2.font.withSize(16)
        
        let alert = UIAlertController(title: "\(playermodel?[indexPath.row].nameFull ?? "")", message: "\n\n\n\n\n", preferredStyle: .alert)
        
        lbl.frame = CGRect(x: 70, y: 80, width: 200, height: 30)
        lbl2.frame = CGRect(x: 70, y: 50, width: 200, height: 30)
        alert.view.addSubview(lbl)
        alert.view.addSubview(lbl2)
        
        let action = UIAlertAction(title: "Ok", style: .cancel)
        
        alert.addAction(action)
        
        self.present(alert, animated: true)
        
    }
    
}
