//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by unthinkable-mac-0025 on 06/07/21.
//

import UIKit
import CoreData

class CreateEmployeeVC: UIViewController {

    @IBOutlet var employeeImageView: UIImageView!
    @IBOutlet var employeeNameTextField: UITextField!
    @IBOutlet var employeeEmailidTextField: UITextField!
    
    private let employeeListButton : UIButton = {
        let button = UIButton()
        button.setTitle("Employee List", for: .normal)
        button.backgroundColor = .red
        return button
    }()
    
    private let manager = EmployeeManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(employeeListButton)
        employeeListButton.addTarget(self, action: #selector(didTapEmployeeListButton), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        self.employeeImageView.addGestureRecognizer(tapGesture)
        self.employeeImageView.isUserInteractionEnabled = true
        tapGesture.addTarget(self, action: #selector(selectImage))

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        employeeListButton.frame = CGRect(x: (view.frame.width - 250)/2, y: view.frame.height/2 + 200, width: 250, height: 50)
    }

    @IBAction func createEmployeeButtonPressed(_ sender: UIButton) {
            print("create button")
        createEmployee()
    }
    
    func createEmployee(){
        if let name = employeeNameTextField.text, !name.isEmpty, let email = employeeEmailidTextField.text, !email.isEmpty, let image = employeeImageView.image{
            
            let employee = Employee(name: name, email: email, profilePicture: image.pngData(), id: UUID())
            
            manager.createEmployee(employee: employee)
            self.performSegue(withIdentifier: SegueIdentifier.navigateToEmployeeList, sender: nil)
        }
    }

    @objc func selectImage(_ gesture : UITapGestureRecognizer ){
    
        let picker = UIImagePickerController()
        picker.sourceType = .savedPhotosAlbum
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func didTapEmployeeListButton() {
        self.performSegue(withIdentifier: SegueIdentifier.navigateToEmployeeList, sender: nil)
    }
    
}

// MARK: Image picker delegate
extension CreateEmployeeVC : UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let img = info[.originalImage] as? UIImage
        self.employeeImageView.image = img

        dismiss(animated: true, completion: nil)
    }
}

