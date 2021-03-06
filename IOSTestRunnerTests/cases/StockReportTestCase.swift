//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//个股研报明细
import XCTest
import os.log
import SwiftyJSON

class StockReportTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.StockReportTestCase
    }
    
    func testStockReport() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MStockReportRequest()
        mRequest.stockReportID = param["STOCKREPORTID"].stringValue
        
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
         mRequest.sourceType = typeVal
         }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let stockReportListResponse = resp as! MStockReportResponse
        XCTAssertNotNil(stockReportListResponse.stockReportDetailItem)
        var resultJSON : JSON = [:]
          if let item = stockReportListResponse.stockReportDetailItem{
                var itemJSON: JSON = [
         
                    "PUBDATE_":item.datetime,
                    "ID_":item.id,
                    "reportTitle":item.title,
                    "dataSource":item.source,
                    "ABSTRACT_":item.content,
                    "ABSTRACTFORMAT_":item.format,
                    "PURL":item.url,
                ]
            resultJSON["\(item.datetime!)"] = itemJSON
            }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
        }
    }
