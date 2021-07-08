//
//  EmployeeListVC.swift
//  CoreDataDemo
//
//  Created by unthinkable-mac-0025 on 07/07/21.
//

import UIKit

class EmployeeListVC: UIViewController {

    @IBOutlet var employeeListTableView: UITableView!
    
    private let manager = EmployeeManager()
    var employees : [Employee]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Employee List"
        
        employeeListTableView.delegate = self
        employeeListTableView.dataSource = self
        employeeListTableView.register(UINib(nibName: "EmployeeListCell", bundle: nil), forCellReuseIdentifier: "employeeCellId")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        employees = manager.fetchEmployee()
        
        if employees != nil && employees?.count != 0{
            employeeListTableView.reloadData()
        }
    }
    
    // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == SegueIdentifier.navigateToEmployeeDetailView)
        {
            let detailsView = segue.destination as? EmployeeDetailVC
            guard detailsView != nil else { return }
            detailsView?.selectedEmployee = self.employees![self.employeeListTableView.indexPathForSelectedRow!.row]
        }
     }

}

extension EmployeeListVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.employees!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = employeeListTableView.dequeueReusableCell(withIdentifier: "employeeCellId", for: indexPath) as! EmployeeListCell
        let employee = self.employees![indexPath.row]
        cell.configureCell(employeeImage: UIImage(data: employee.profilePicture!)!, employeeName: employee.name!, employeeEmailid: employee.email!)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: SegueIdentifier.navigateToEmployeeDetailView, sender: nil)
    }
    
}
