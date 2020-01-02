//
//  MVVMExTests.swift
//  MVVMExTests
//
//  Created by User on 12/15/19.
//  Copyright © 2019 Adel. All rights reserved.
//

import XCTest
@testable import MVVMEx

class MVVMExTests: XCTestCase {
    var student1 = Student(studentId: 123, studentName: "Mohamed")
    var student2 = Student(studentId: 124, studentName: "George")
    var student3 = Student(studentId: 125, studentName: "Adel")
    
    var sortedArr = [Student]()
    var arr = [Student]()
    override func setUp() {
        arr.append(student1)
        arr.append(student2)
        arr.append(student3)
        sortedArr.append(student3)
        sortedArr.append(student2)
        sortedArr.append(student1)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
//    func testCourseViewModel() {
//        let course = Course(id: 0, name: "My Course Name", number_of_lessons: 10)
//        let courseViewModel = CourseViewModel(course: course)
//
//        // what is it that we want to test?
//        XCTAssertEqual(course.name, courseViewModel.name)
//        XCTAssertEqual("Lessons: \(course.number_of_lessons)", courseViewModel.detailTextString)
//        XCTAssertEqual(.none, courseViewModel.accessoryType)
//    }
    func testStudentViewModelOnSucess(){
        let viewmodel = StudentListViewModel()
        viewmodel.cellViewModels = arr
        viewmodel.sortList()
        XCTAssertEqual(viewmodel.cellViewModels, sortedArr)
        
        
    }
    func testStudentViewModelOnFailer(){
        let viewmodel = StudentListViewModel()
        viewmodel.cellViewModels = arr
        viewmodel.sortList()
        XCTAssertTrue(viewmodel.cellViewModels[2].studentId != sortedArr[1].studentId)

    }
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
