//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//最新指标
import XCTest
import os.log
import SwiftyJSON

class LatestIndexTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.LatestIndexTestCase
    }
   
    func testLatestIndex() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MLatestIndexRequest()
        mRequest.code = param["CODE"].stringValue
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
        }
    
        
        let resp = self.makeSyncRequest(request: mRequest)
        let latestIndexResponse = resp as! MLatestIndexResponse
        XCTAssertNotNil(latestIndexResponse.record)
        if let record = latestIndexResponse.record{
            var resultJSON: JSON = [
                "netProfitCutParentComYOY": record["NETPROFITCUTPARENTCOMYOY"]!,
                "netProfitCutParentCom": record["NETPROFITCUTPARENTCOM"]!,
                "cutBasicEPS": record["CUTBASICEPS"]!,
                "annuROE": record["ANNUROE"]!,
                "netProfitParentCom": record["NETPROFITPARENTCOM"]!,
                "basicEPS": record["BASICEPS"]!,
                "totalShare": record["TOTALSHARE"]!,
                "BVPS_": record["BVPS"]!,
                "reservePS": record["RESERVEPS"]!,
                "REPTITLE_": record["REPTITLE"]!,
                "netCashFlowOperPS": record["NETCASHFLOWOPERPS"]!,
                "grossProfitMargin": record["GROSSPROFITMARGIN"]!,
                "netProfitParentComYOY": record["NETPROFITPARENTCOMYOY"]!,
                "retainedEarningPS": record["RETAINEDEARNINGPS"]!,
                "operRevenueYOY": record["OPERREVENUEYOY"]!,
                "operRevenue": record["OPERREVENUE"]!
            ]
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
    }
}

