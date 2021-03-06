//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//指数成分股及沪深市场涨跌平家数
import XCTest
import os.log
import SwiftyJSON

class IndexUpdownsTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.IndexUpdownsTestCase
    }
    
    func testIndexUpdowns() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MIndexUpdownsRequest()
        mRequest.code = param["CODE"].stringValue
        
        let resp = self.makeSyncRequest(request: mRequest)
        let indexUpdownsResponse = resp as! MIndexUpdownsResponse
        XCTAssertNotNil(indexUpdownsResponse)
    var resultJSON: JSON = [
            "upCount":indexUpdownsResponse.advanceCount,
            "downCount":indexUpdownsResponse.declineCount,
            "sameCount":indexUpdownsResponse.equalCount,
        ]
print(resultJSON)
onTestResult(param: param, result: resultJSON)
 }
}
