//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//财经资讯明细
import XCTest
import os.log
import SwiftyJSON

class F10_NEWS_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_NEWS_1
    }
    
    func testNews() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MNewsRequest()
        if param["NEWSID"].stringValue == "null"{
            mRequest.newsID = "nil"
        }else{
            mRequest.newsID = param["NEWSID"].stringValue
        }
        let typeVal = param["SRC"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let newsResponse = resp as! MNewsResponse
//        XCTAssertNotNil(newsResponse.newsDetailItem)
        if (newsResponse.newsDetailItem == nil){
            throw BaseTestError.assertFailedError(message: "newsResponse newsDetailItem is nil")
        }
        if let item = newsResponse.newsDetailItem{
            var resultJSON: JSON = [
                "ABSTRACT_":item.content,
                "INIPUBDATE_":item.datetime,
                "MEDIANAME_":item.source,
                "ABSTRACTFORMAT_":item.format,
                ]
           print(resultJSON)
           onTestResult(param: param, result: resultJSON)
            }
        }
    }

        

