//
//  ViewController.swift
//  MVVMEx
//
//  Created by User on 12/15/19.
//  Copyright © 2019 Adel. All rights reserved.
//

import UIKit

class StudentListViewController: UIViewController {

    @IBOutlet weak var activityIndicator :UIActivityIndicatorView!
    @IBOutlet weak var studentsTableView :UITableView!
     @IBOutlet weak var barButtonSort :UIBarButtonItem!
    //let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    lazy var viewModel: StudentListViewModel = {
        return StudentListViewModel()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initFetchStudents()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortList))

    }
    @objc func sortList(_ sender :UIBarButtonItem){
        viewModel.sortList()
    }
    private func initUI(){
        studentsTableView.delegate = self
        studentsTableView.dataSource = self
        self.navigationItem.title = "Students"
        studentsTableView.estimatedRowHeight = 150
        studentsTableView.rowHeight = UITableView.automaticDimension
    }
   
    func initFetchStudents() {
        // Naive binding
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                   self?.showAlert( message )
                }
            }
        }
        viewModel.updateLoadingStatus = { [weak self] () in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                switch self.viewModel.state {
                case .empty, .error:
                    self.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.studentsTableView.alpha = 0.0
                    })
                case .loading:
                    self.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.studentsTableView.alpha = 0.0
                    })
                case .populated:
                    self.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.studentsTableView.alpha = 1.0
                    })
                }
            }
        }
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.studentsTableView.reloadData()
            }
        }
        
        viewModel.getStudent()
        
    }
    // MARK:- Show Alert
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
extension StudentListViewController :UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath) as! StudentCell
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.studentListCellViewModel = cellVM
        
        return cell
    }
}
