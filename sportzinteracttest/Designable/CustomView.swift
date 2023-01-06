//
//  CustomView.swift
//  sportzinteracttest
//
//  Created by AKSHAY VAIDYA on 15/11/2022 Saka.
//

import Foundation
import UIKit

@IBDesignable
class CustomView:UIView{
    
  @IBInspectable var borderwidth:CGFloat = 0{
        
        didSet{
            
            self.layer.borderWidth = borderwidth
            
        }
        
    }
    

    
    
    @IBInspectable var borderColor: UIColor? {
           set {
               layer.borderColor = newValue?.cgColor
           }
           get {
               guard let color = layer.borderColor else {
                   return nil
               }
               return UIColor(cgColor: color)
           }
       }
    
//    @IBInspectable var shadowradius: CGFloat = 0 {
//        didSet{
//            
//            self.layer.shadowRadius = shadowradius
//            
//        }
//       }
    
    
    @IBInspectable var cornerRadius:CGFloat = 0{
          
          didSet{
              
              self.layer.cornerRadius = cornerRadius
              
          }
          
      }
}
