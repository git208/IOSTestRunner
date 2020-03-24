//
//  ChartTestCase.swift
//  IOSTestRunnerTests
//
//  Created by HW1-MM01 on 2019/9/10.
//  Copyright © 2019 liao xiangsen. All rights reserved.
//

import XCTest
import os.log
import SwiftyJSON

class CHARTV2TEST_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.CHARTV2TEST_1
    }
    
    func testChart() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MChartRequest()
        mRequest.code = param["CODE"].stringValue
        mRequest.subtype = param["SUBTYPE"].stringValue
        if param["TYPE"] == "ChartTypeOneDay"{
            mRequest.chartType = MChartType(rawValue: 0)!
        }else if param["TYPE"] == "ChartTypeFiveDay"{
            mRequest.chartType = MChartType(rawValue: 1)!
        }

        let resp = self.makeSyncRequest(request: mRequest)
        let chartResponse = resp as! MChartResponse
        XCTAssertNotNil(chartResponse.ohlcItems)
        var resultJSON : JSON = [:]
        for item in chartResponse.ohlcItems{
            
            var itemJSON:JSON = [
                "datetime" : item.datetime,
                "closePrice": item.closePrice,
                "tradeVolume": item.tradeVolume,
                "averagePrice": item.averagePrice,
                "md": item.rgbar,
                "openInterest": item.openInterest,
                "volRatio": item.volumeRatio,
                "iopv": item.iopv,
                "iopvPre": item.referenceIOPVPrice,
                
            ]
            var itemJSON2 : JSON = [:]
            var itemDic : Dictionary = [String:String]()
                            for itemKey in itemJSON.dictionaryValue.keys{
                                
                                itemDic[itemKey] = itemJSON[itemKey].stringValue
                                if itemDic[itemKey] != ""{
                                    itemJSON2[itemKey].stringValue = itemDic[itemKey]!
                                }else{
                                    itemJSON2[itemKey].stringValue = "-"
                                }
                                
                            }

            resultJSON["\(item.datetime!)"] = itemJSON2
            
        }
        if mRequest.returnAFData == true {
            
            for item in chartResponse.afItems{
                var itemJSON:JSON = [
                    "datetime": item.datetime,
                    "closePrice": item.closePrice,
                    "tradeVolume": item.tradeVolume,
                    "reference_price": item.referencePrice
                ]
                var itemJSON2 : JSON = [:]
                var itemDic : Dictionary = [String:String]()
                for itemKey in itemJSON.dictionaryValue.keys{
                    
                    itemDic[itemKey] = itemJSON[itemKey].stringValue
                    if itemDic[itemKey] != ""{
                        itemJSON2[itemKey].stringValue = itemDic[itemKey]!
                    }else{
                        itemJSON2[itemKey].stringValue = "-"
                    }
                    
                }
                resultJSON["\(item.datetime!)"] = itemJSON2
            }
            
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
    
}
