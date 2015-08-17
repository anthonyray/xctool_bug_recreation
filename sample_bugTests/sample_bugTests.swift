//
//  sample_bugTests.swift
//  sample_bugTests
//
//  Created by Anthony Reinette on 17/08/2015.
//
//
import UIKit
import XCTest
import ReactiveCocoa
import AFNetworkingFramework


class sample_bugTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHTTPNetworkReachable(){
        let expectation = expectationWithDescription("")

        let url = NSURL(string: "http://www.google.com")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!){(data, response, error) in
            if ((response) != nil){
                XCTAssert(true, "Passed")
                expectation.fulfill()
            }
            else {
                XCTFail("Network unreachable")
            }

        }
        
        task.resume()
        
        waitForExpectationsWithTimeout(5.0){ (error) in
            if error != nil {
                XCTFail(error.localizedDescription)
            }
        }
        
    }

    func testHTTPSNetworkReachable(){
        let expectation = expectationWithDescription("")
        
        let url = NSURL(string: "https://www.google.com")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!){(data, response, error) in
            if ((response) != nil){
                XCTAssert(true, "Passed")
                expectation.fulfill()
            }
            else {
                XCTFail("Network unreachable")
            }
            
        }
        
        task.resume()
        
        waitForExpectationsWithTimeout(5.0){ (error) in
            if error != nil {
                XCTFail(error.localizedDescription)
            }
        }
        
    }
    
}
