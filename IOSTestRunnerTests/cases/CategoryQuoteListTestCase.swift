//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//版块类股票行情
import XCTest
import os.log
import SwiftyJSON

class CategoryQuoteListTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.CategoryQuoteListTestCase
    }
    
    func testCategoryQuoteList() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MCategoryQuoteListRequest()
        mRequest.categoryID = param["CATEGORYID"].stringValue
        mRequest.pageIndex = param["PAGEINDEX"].intValue
        
        let resp = self.makeSyncRequest(request: mRequest)
        let categoryQuoteListResponse = resp as! MCategoryQuoteListResponse
        XCTAssertNotNil(categoryQuoteListResponse.categoryQuoteItems)
        var resultJSON : JSON = [:]
        for item in categoryQuoteListResponse.categoryQuoteItems {
            var itemJSON: JSON = [
                "status": "\(item.status.rawValue)" + "\(item.stage.rawValue)",
                "id": item.id,
                "name": item.name,
                "datetime": item.datetime,
                "market": item.market,
                "subtype": item.subtype,
                "lastPrice": item.lastPrice,
                "highPrice": item.highPrice,
                "lowPrice": item.lowPrice,
                "openPrice": item.openPrice,
                "preClosePrice": item.preClosePrice,
                "volume": item.volume,
                "nowVolume": item.nowVolume,
                "turnoverRate": item.turnoverRate,
                
                "limitUP": item.limitUp,
                "limitDown": item.limitDown,
                "averageValue": item.averagePrice,
                "change": item.change,
                "amount": item.amount,
                "volumeRatio": item.volumeRatio,
                "buyPrice": item.buyPrice,
                "sellPrice": item.sellPrice,
                "buyVolume": item.buyVolume,
                "sellVolume": item.sellVolume,
                "totalValue": item.totalValue,
                
                "capitalization": item.capitalization,
                "circulatingShares": item.circulatingShare,
                
                "amplitudeRate": item.amplitudeRate,
                "receipts": item.receipts,
                
                "orderRatio": item.orderRatio,
                "hk_paramStatus": item.hkInfoStatus.rawValue,
                
                "sumBuy": item.totalBuyVolume,
                "sumSell": item.totalSellVolume,
                "averageBuy": item.averageBuyPrice,
                "averageSell": item.averageSellPrice,
                
                "buy_cancel_count": item.withdrawBuyCount,
                "buy_cancel_num": item.withdrawBuyVolume,
                "buy_cancel_amount": item.withdrawBuyAmount,
                "sell_cancel_count": item.withdrawSellCount,
                "sell_cancel_num": item.withdrawSellVolume,
                "sell_cancel_amount": item.withdrawSellAmount,
                
                "change2": item.change2,
                
                "limitPriceUpperLimit": item.plSubscribeLimit,
                "limitPriceLowerLimit": item.plSubscribeLowerLimit,
                "bidpx1": item.buyPrice,
                "askpx1": item.sellPrice,
                "bidvol1": item.buyVolume,
                "askvol1": item.sellVolume,
                "buyPrices": item.buyPrices,
                "buyVolumes":item.buyVolumes,
                "sellPrices":item.sellPrices,
                "sellVolumes":item.sellVolumes,
                "buySingleVolumes":item.buyCount,
                "sellSingleVolumes":item.sellCount,
                
                ]
            
            switch item.changeState{
                
            case .flat:
                itemJSON["changeRate"].string = item.changeRate
            case .rise:
                itemJSON["changeRate"].string = "+"+item.changeRate
            case .drop:
                itemJSON["changeRate"].string = "-"+item.changeRate
            }
            resultJSON["\(item.datetime!)"] = itemJSON
            
        }
        
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
        
    }
}

