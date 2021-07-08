//
//  EmployeeDetailVC.swift
//  CoreDataDemo
//
//  Created by unthinkable-mac-0025 on 07/07/21.
//

import UIKit

class EmployeeDetailVC: UIViewController {

    @IBOutlet var employeeImageView: UIImageView!
    @IBOutlet var employeeNameTextField: UITextField!
    @IBOutlet var employeeEmailidTextField: UITextField!
    
    private let manager = EmployeeManager()
    var selectedEmployee : Employee? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewWillSetUp()
        // Do any additional setup after loading the view.
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        self.employeeImageView.addGestureRecognizer(tapGesture)
        self.employeeImageView.isUserInteractionEnabled = true
        tapGesture.addTarget(self, action: #selector(selectImage))
    }
    
    func viewWillSetUp()
    {
        self.employeeNameTextField.text = selectedEmployee?.name
        self.employeeEmailidTextField.text = selectedEmployee?.email
        self.employeeImageView.image = UIImage(data: (selectedEmployee?.profilePicture)!)
    }

    @IBAction func updateButtonPressed(_ sender: UIButton) {
        if let name = employeeNameTextField.text, !name.isEmpty, let email = employeeEmailidTextField.text, !email.isEmpty{
            let imageData = employeeImageView.image?.pngData()
            let uuid = selectedEmployee?.id
            let employee = Employee(name: name, email: email, profilePicture: imageData, id: uuid!)
            
            if(manager.updateEmployee(employee: employee))
            {
               displayAlert(alertMessage: "Record Updated")
            }else
            {
                displayErrorAlert()
            }
        }
    
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        if(manager.deleteEmployee(id: selectedEmployee!.id))
        {
            displayAlert(alertMessage: "Record deleted")
        }
        else
        {
            displayErrorAlert()
        }
    }
    
    @objc func selectImage(_ gesture : UITapGestureRecognizer ){
    
        let picker = UIImagePickerController()
        picker.sourceType = .savedPhotosAlbum
        picker.delegate = self
        present(picker, animated: true)
    }
   

    // MARK: Private functions
    private func displayAlert(alertMessage:String)
    {
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }

    private func displayErrorAlert()
    {
        let errorAlert = UIAlertController(title: "Alert", message: "Something went wrong, please try again later", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        errorAlert.addAction(okAction)
        self.present(errorAlert, animated: true)
    }
}


extension EmployeeDetailVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let img = info[.originalImage] as? UIImage
        self.employeeImageView.image = img

        dismiss(animated: true, completion: nil)
    }
}
