//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Pierre pc. CHARVOZ on 03/11/2016.
//  Copyright © 2016 Pierre pc. CHARVOZ. All rights reserved.
//

import UIKit

class RatingControl: UIView {

    
    //MARK : Properties
    
    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()
    let spacing = 5
    let starCount = 5
    
    
    
    //MARK : Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let emptyStarImage = UIImage(named: "emptyStar")
        let filledStarImage = UIImage(named: "filledStar")
        
        for _ in 0..<starCount {
        let button = UIButton()
            
            button.setImage(emptyStarImage, forState: .Normal)
            button.setImage(filledStarImage, forState: .Selected)
            button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
            
        button.adjustsImageWhenHighlighted = false
            
        button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(_:)), forControlEvents: .TouchDown)
            ratingButtons += [button]
        addSubview(button)
        }
        
    }
    
    override func layoutSubviews() {
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        //Offset each button's origin by the length plus spacing 
        for (index, button) in ratingButtons.enumerate(){
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        updateButtonSelectionStates()
    }
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize * starCount) + (spacing * (starCount - 1))
        
        return CGSize(width: width, height: buttonSize)
    }
    
    //MARK : Button Action 
    func ratingButtonTapped(button: UIButton)  {
        rating = ratingButtons.indexOf(button)! + 1
        
        updateButtonSelectionStates()
        
        print("Button pressed 👍")
    }
    
    func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerate(){
            // If the index of a button is less than the rating, that button should be selected.
            button.selected = index < rating
        }
    }

}
