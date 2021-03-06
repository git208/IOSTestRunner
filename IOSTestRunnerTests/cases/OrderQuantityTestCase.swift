//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//买卖队列
import XCTest
import os.log
import SwiftyJSON

class OrderQuantityTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.OrderQuantityTestCase
    }
    
    func testOrderQuantity() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MOrderQuantityRequest()
        mRequest.code = param["CODE"].stringValue
        mRequest.subtype = param["SUBTYPE"].stringValue
        
        let resp = self.makeSyncRequest(request: mRequest)
        let orderQuantityResponse = resp as! MOrderQuantityResponse
        XCTAssertNotNil(orderQuantityResponse.buyItems)
        XCTAssertNotNil(orderQuantityResponse.sellItems)

        var jsonarr1 = [String]()
        for buyitem in orderQuantityResponse.buyItems{
            let OQitems:NSArray = buyitem as! NSArray
            for OQitem in OQitems{
                let orderQuantityBuyItem:MOrderQuantityItem = OQitem as! MOrderQuantityItem
                jsonarr1.append(orderQuantityBuyItem.volume)
            }
        }
        var jsonarr2 = [String]()
        for sellitem in orderQuantityResponse.sellItems{
            
            let OQitems:NSArray = sellitem as! NSArray
            for OQitem in OQitems{
                let orderQuantitySellItem:MOrderQuantityItem = OQitem as! MOrderQuantityItem
                jsonarr2.append(orderQuantitySellItem.volume)
            }
        }
        var jsonarr3: JSON = [
            "QUANTITY": jsonarr1
        ]
        var jsonarr4: JSON = [
            "QUANTITY": jsonarr2
        ]
        var resultJSON: JSON = [
            "buyList": jsonarr3,
            "sellList": jsonarr4
            ]
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}

