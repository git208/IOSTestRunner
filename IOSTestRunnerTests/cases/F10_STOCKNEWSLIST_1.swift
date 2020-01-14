//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//个股新闻列表
import XCTest
import os.log
import SwiftyJSON

class F10_STOCKNEWSLIST_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_STOCKNEWSLIST_1
    }
    
    func testStockNewsList() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MStockNewsListRequest()
        let typeVal = param["SOURCETYPE"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        
        mRequest.code = param["CODE"].stringValue
        mRequest.newsID = param["NEWSID"].stringValue
        
        if param["TYPE"] == "-1"{
            mRequest.type = F10NewsRequestType(rawValue: -1)!
        }else if param["TYPE"] == "5"{
            mRequest.type = F10NewsRequestType(rawValue: 1)!
        }else if param["TYPE"] == "6"{
            mRequest.type = F10NewsRequestType(rawValue: 2)!
        }
        
        mRequest.pageSize = 10
        
        let resp = self.makeSyncRequest(request: mRequest)
        let stockNewsListResponse = resp as! MStockNewsListResponse
        XCTAssertNotNil(stockNewsListResponse.stockNewsItems)
        var resultJSON : JSON = [:]
        for items in stockNewsListResponse.stockNewsItems{
            if let item: MStockNewsItem = items as! MStockNewsItem{
                var itemJSON: JSON = [
                    "INIPUBDATE_":item.datetime,
                    "ID_":item.id,
                    "REPORTTITLE_":item.title,
                    "MEDIANAME_":item.source,
                    "REPORTLEVEL_":item.level,
                    "STOCKNAME_":item.stockName,
                    "ISPDF":item.isPDF,
                    "ENTRYDATE":item.entryDate,
                    "ENTRYTIME":item.entryTime,
                ]
                var itemJSON2 : JSON = [:]
                var itemDic : Dictionary = [String:String]()
                                for itemKey in itemJSON.dictionaryValue.keys{
                                    
                                    itemDic[itemKey] = itemJSON[itemKey].stringValue
                                    if itemDic[itemKey] != ""{
                                        itemJSON2[itemKey].stringValue = itemDic[itemKey]!
                                    }
                //                    print(itemDic[itemKey]!)
                                    
                                }
                var itemID: String = item.id.replacingOccurrences(of: ".", with: "_")
                
                resultJSON["\(itemID)"] = itemJSON2
            }
        }
        
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}

