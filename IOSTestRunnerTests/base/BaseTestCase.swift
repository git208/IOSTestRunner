//
//  Root.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/26.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//

import XCTest
import SwiftyJSON

class BaseTestCaseRun : XCTestCaseRun {
    override func start() {
        super.start()
        print("XCTestRun start")
    }
    
    override func stop() {
        super.stop()
        print("XCTestRun end")
    }
    
    override func recordFailure(withDescription description: String, inFile filePath: String?, atLine lineNumber: Int, expected: Bool) {
        super.recordFailure(withDescription: description, inFile: filePath, atLine: lineNumber, expected: expected)
    }
}

class BaseTestCase : ParametrizedTestCase {
    static var allowedTestNames: [_SelectedTestCase] = RunnerSetup.sharedInstance.getTestcaseNames().map{ item in
        return _SelectedTestCase(name: item.rawValue)
    }
    static var testCaseConfigDict: [StockTestCaseName: StockTesting_TestcaseConfig] = RunnerSetup.sharedInstance.getTestCaseConfigDict()
    
    internal var stockTestCaseName: StockTestCaseName {
        fatalError("Must be overridden by subclasses.")
    }
    
    override var testName: String {
        get {
            return self.stockTestCaseName.rawValue
        }
        set {
            fatalError("Must be overridden by subclasses.")
        }
    }
    
    override var testRunClass: AnyClass? {
        return BaseTestCaseRun.self
    }
    
    override func _allowedTestNames() -> [_SelectedTestCase] {
        return BaseTestCase.allowedTestNames
    }
    
//    override func setUp() {
//        super.setUp()
//    }
//
//    override func beforeAll() {
//        super.beforeAll()
//    }
    
    internal func makeSyncRequest(request: MRequest) -> MResponse {
        var reqResponse: MResponse? = nil
        let runLoop = CFRunLoopGetCurrent()
        MApi.send(request, completionHandler: { resp in
            reqResponse = resp
            CFRunLoopStop(runLoop)
        })
        let result = CFRunLoopRunInMode(CFRunLoopMode.defaultMode, CFTimeInterval(5.0), false)
        XCTAssert(result == .stopped)
        XCTAssertNotNil(reqResponse)
        return reqResponse!
    }
    
    internal var testCaseRoundConfig: TestCaseRoundConfig = TestCaseRoundConfig()

    override func invokeTest() {
        if let cfg = BaseTestCase.testCaseConfigDict[self.stockTestCaseName] {
            testCaseRoundConfig = TestCaseRoundConfig(caseCfg: cfg)
            while testCaseRoundConfig.shouldRun() {
                super.invokeTest()
                testCaseRoundConfig.nextRound()
                sleep(testCaseRoundConfig.sleepIntervalSec)
            }
        }
    }
    
    override var continueAfterFailure: Bool {
        get {
            return testCaseRoundConfig.continueWhenFailed
        }
        set {
        }
    }
    
    internal func onTestResult(param: JSON, result: JSON) {
        RunnerSetup.sharedInstance.resultCollector.onTestResult(testName: self.testName, param: param, result: result)
    }
}
