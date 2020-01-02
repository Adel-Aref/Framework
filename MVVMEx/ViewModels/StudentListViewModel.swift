//
//  studentViewModel.swift
//  MVVMEx
//
//  Created by User on 12/15/19.
//  Copyright © 2019 Adel. All rights reserved.
//

import Foundation

class StudentListViewModel {
    let client = StudentClient()
    var reloadTableViewClosure :(()->())?
    var updateLoadingStatus :(()->())?
    var showAlertClosure :(()->())?
    
     var cellViewModels: [Student] = [Student]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    // callback for interfaces
    var state: State = .empty {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    //
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    //
    var numberOfCells: Int {
        return cellViewModels.count
    }
    func sortList(){
       cellViewModels =  cellViewModels.sorted { $0.studentName.lowercased() < $1.studentName.lowercased() }
    }
    func getStudent(){
        state = .loading
        client.getStudents {  [weak self] (res) in
    
            switch res {
            case .success(let students):
                if let students = students as? Students {
                    self?.processFetchedStudents(students: students)
                    self?.state = .populated
                }
            case .failure(let error):
                    self?.state = .error
                    self?.alertMessage = error.localizedDescription
                return
            }
        }
    }
    func getCellViewModel( at indexPath: IndexPath ) -> Student {
        return cellViewModels[indexPath.row]
    }
    private func processFetchedStudents( students: Students ) {
        var vms = [Student]()
        if let students = students.data {
            for student in students {
                vms.append( Student(studentId: student.studentId, studentName: student.studentName))
            }
            self.cellViewModels = vms
        }

    }
    
}
