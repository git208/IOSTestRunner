//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//期权-标的行情
import XCTest
import os.log
import SwiftyJSON

class UnderlyingStockTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.UnderlyingStockTestCase
    }
    
    func testUnderlyingStock() {
    let param = self.testCaseRoundConfig.getParam()
    let mRequest = MUnderlyingStockRequest()
    let resp = self.makeSyncRequest(request: mRequest)
    let underlyingStockResponse = resp as! MUnderlyingStockResponse
    XCTAssertNotNil(underlyingStockResponse.stockItems)
        for item in underlyingStockResponse.stockItems{
            var resultJSON: JSON = [
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
 
                
            ]
            var jsonBuyPrices = [JSON]()
            for i in 0 ..< item.buyPrices.count{
                let jsonBuyPrice : JSON = [
                    "buyPrice\(i+1)": item.buyPrices[i]
                ]
                jsonBuyPrices.append(jsonBuyPrice)
            }
            resultJSON["buyPrices"].arrayObject = jsonBuyPrices

            var jsonBuyVolumes = [JSON]()
            for i in 0 ..< item.buyVolumes.count{
                let jsonBuyVolume : JSON = [
                    "buyVolume\(i+1)": item.buyVolumes[i]
                ]
                jsonBuyVolumes.append(jsonBuyVolume)
            }
            resultJSON["buyVolumes"].arrayObject = jsonBuyVolumes
            var jsonsellPrices = [JSON]()
            for i in 0 ..< item.sellPrices.count{
                let jsonsellPrice : JSON = [
                    "sellPrice\(i+1)": item.sellPrices[i]
                ]
                jsonsellPrices.append(jsonsellPrice)
            }
            resultJSON["sellPrices"].arrayObject = jsonsellPrices

            var jsonsellVolumes = [JSON]()
            for i in 0 ..< item.sellVolumes.count{
                let jsonsellVolume : JSON = [
                    "sellVolume\(i+1)": item.sellVolumes[i]
                ]
                jsonsellVolumes.append(jsonsellVolume)
            }
            resultJSON["sellVolumes"].arrayObject = jsonsellVolumes

            
            switch item.changeState{
                
            case .flat:
                resultJSON["changeRate"].string = item.changeRate
            case .rise:
                resultJSON["changeRate"].string = "+"+item.changeRate
            case .drop:
                resultJSON["changeRate"].string = "-"+item.changeRate
            }

            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
    
    }
}
