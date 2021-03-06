//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//沪股通和深股通额度数据接口
import XCTest
import os.log
import SwiftyJSON

class HSAmountTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.HSAmountTestCase
    }
    func testSAmount() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MHSAmountRequest()
        
        let resp = self.makeSyncRequest(request: mRequest)
        let hSAmountResponse = resp as! MHSAmountResponse
        XCTAssertNotNil(hSAmountResponse)
        var resultJSON: JSON = [
            "shInitialQuota":hSAmountResponse.shInitialAmount,
            "shRemainQuota":hSAmountResponse.shRemainingAmount,
            "szInitialQuota":hSAmountResponse.szInitialAmount,
            "szRemainQuota":hSAmountResponse.szRemainingAmount,
        ]
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}

