//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//机构预测
import XCTest
import os.log
import SwiftyJSON

class ForecastYeareTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.ForecastYeareTestCase
    }

    func testForecastYeare() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MForecastYearRequest()
        mRequest.code = param["CODE"].stringValue
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
        }
        
        
        let resp = self.makeSyncRequest(request: mRequest)
        let forecastYearResponse = resp as! MForecastYearResponse
        XCTAssertNotNil(forecastYearResponse.record)
        if let record: NSDictionary = forecastYearResponse.record as NSDictionary{
            var resultJSON: JSON = [
                "NETEPS_": record["NETEPS"]!,
                "AVGCOREREVENUE_": record["AVGCOREREVENUE"]!,
                "FORECASTYEAR_": record["FORECASTYEAR"]!,
                "STATISTICDATE_": record["STATISTICDATE"]!,
                "AVGPROFIT_": record["AVGPROFIT"]!,
                "ForecastYYYY": record["FORECASTYYYY"]!,
                "FORECASTCOUNT_": record["FORECASTCOUNT"]!
            ]
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
    }
}

