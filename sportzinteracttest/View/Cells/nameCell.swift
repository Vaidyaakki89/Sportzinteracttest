//
//  nameCell.swift
//  sportzinteracttest
//
//  Created by AKSHAY VAIDYA on 15/11/2022 Saka.
//

import UIKit

class nameCell: UITableViewCell {

    @IBOutlet weak var namelbl: UILabel!
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(model:Player){
        
        if (model.iscaptain ?? false) &&  (model.iskeeper ?? false){
            
            namelbl.text = "\(model.nameFull) (c & wk)"
            
        }
        
       else if model.iscaptain ?? false{
            
            namelbl.text = "\(model.nameFull) (c)"
            
        }
        else if model.iskeeper ?? false{
            
            namelbl.text = "\(model.nameFull) (wk)"
            
        }
        
        else{
            namelbl.text = model.nameFull
            
        }
    }
    
}
