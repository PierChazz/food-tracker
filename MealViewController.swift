//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Pierre pc. CHARVOZ on 03/11/2016.
//  Copyright © 2016 Pierre pc. CHARVOZ. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    //MARK: Properties

    @IBOutlet weak var nameTF: UITextField!
    
        
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    @IBOutlet weak var ratingControl: RatingControl!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
     This value is either passed by 'MealTableViewController' in 
     'prepareForSegue(_:sender:)'
     or constructed as part of adding a new meal.
     */
    var meal : Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field's user input through delegate callbacks.
        nameTF.delegate = self
        
        //Set up views if editing an existing Meal 
        if let meal = meal {
            navigationItem.title = meal.name
            nameTF.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        
        //Enable the Save button only if the text field has a valid Meal name
        checkValidMealName()
    }
    
    // MARK : UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        //Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField){
        checkValidMealName()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        //Disable the Save button while editing
        saveButton.enabled = false
    }
    
    func checkValidMealName() {
        //Disable the Save button if the text field is empty 
        
        let text = nameTF.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    //MARK: Navigation
    //This method lets you configure a view controller before it's presented
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        //Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode{
            dismissViewControllerAnimated(true, completion: nil)
        }
        else{
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = nameTF.text ?? ""
            let photo = photoImageView.image
            let rating = ratingControl.rating
            
            //Set the meal to be passed to MealViewController after the unwind segue. 
            meal = Meal(name: name, photo: photo, rating: rating)
        }
    }
        
    
    // MARK : Actions

    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        
        //Hide the keyboard
        nameTF.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        
        let imagePickerController = UIImagePickerController()
        //Only allow photos to be picked, not taken
        
        imagePickerController.sourceType = .PhotoLibrary
        
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    
    
    //MARK : UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        //dismiss the picker if the user canceled
     dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        photoImageView.image = selectedImage
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    

}

