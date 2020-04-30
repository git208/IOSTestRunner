//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//分级基金
import XCTest
import os.log
import SwiftyJSON

class F10_STRUCTUREDFUND_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_STRUCTUREDFUND_1
    }
    
    func testGradeFund() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MGradeFundRequest()
        mRequest.code = param["CODE"].stringValue
//        mRequest.gradeFundType = param["GRADEFUNDTYPE"].stringValue
        var TYPE = param["GRADEFUNDTYPE"].stringValue.replacingOccurrences(of: "/", with: "")
        mRequest.gradeFundType = TYPE
        let typeVal = param["SRC"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }

        
        let resp = try self.makeSyncRequest(request: mRequest)
        let gradeFundResponse = resp as! MGradeFundResponse
//        XCTAssertNotNil(gradeFundResponse.jsonObject)
        if (gradeFundResponse.jsonObject == nil){
            throw BaseTestError.assertFailedError(message: "gradeFundResponse jsonObject is nil")
        }
        if mRequest.gradeFundType == "fndclassinfo"{
            if let info:NSDictionary = gradeFundResponse.jsonObject as! NSDictionary{
                
                var resultJSON: JSON = [
                    "MASTERCODEA": info["MASTERCODEA"]!,
                    "SNAMECOMPA": info["SNAMECOMPA"]!,
                    "ATOTSHARE": info["ATOTSHARE"]!,
                    "MASTERCODE": info["MASTERCODE"]!,
                    "SNAMECOMP": info["SNAMECOMP"]!,
                    "MASTERCODEB": info["MASTERCODEB"]!,
                    "SNAMECOMPB": info["SNAMECOMPB"]!,
                    "BTOTSHARE": info["BTOTSHARE"]!,
                    
                ]
                let update1: JSON = [
                    "MAPCODE": info["MAPCODE"]!,
                    "MAPNAME": info["MAPNAME"]!,
                    "LISTDATE": info["LISTDATE"]!,
                    "ENDDATE": info["ENDDATE"]!,
                    "KEEPERNAME": info["KEEPERNAME"]!
                ]
                do {
                    try resultJSON.merge(with: update1)
                } catch {
                    // ignore
                }
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        if mRequest.gradeFundType == "fndclassstockpre"{
            if let infos:NSArray = gradeFundResponse.jsonObject as! NSArray{
                var resultJSON : JSON = [:]
                for info in infos{
                    if let infodic:NSDictionary = info as!NSDictionary{
                        var jsonarr2: JSON = [
                            "SKCODE": infodic["SKCODE"]!,
                            "SKNAME": infodic["SKNAME"]!,
                            "NAVRTO": infodic["NAVRTO"]!,
                            "ACCSTKRTO": infodic["ACCSTKRTO"]!,
                            "ACCCIRCRTO": infodic["ACCCIRCRTO"]!
                        ]
                        resultJSON["\(infodic["SKNAME"]!)"] = jsonarr2
                    }
                }
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        if mRequest.gradeFundType == "fndclassforcast"{
            if let info:NSDictionary = gradeFundResponse.jsonObject as! NSDictionary{
                var resultJSON: JSON = [
                    "FSYMBOL": info["FSYMBOL"]!,
                    "PRIXLEVERAGE": info["PRIXLEVERAGE"]!,
                    "NAVLEVERAGE": info["NAVLEVERAGE"]!,
                    "THRESHOLD": info["THRESHOLD"]!
                ]
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        if mRequest.gradeFundType == "fndclasssubredinfo"{
            if let info:NSDictionary = gradeFundResponse.jsonObject as! NSDictionary{
                var resultJSON: JSON = [
                    "INVESTSTYLE": info["INVESTSTYLE"]!,
                    "SUBREDSTATUS": info["SUBREDSTATUS"]!,
                    "ACCUNITNAV": info["ACCUNITNAV"]!,
                    "RATEMAXCOST": info["RATEMAXCOST"]!,
                    "APPMINAMT": info["APPMINAMT"]!
                ]
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        if mRequest.gradeFundType == "fndclassmergesplit"{
            if let info:NSDictionary = gradeFundResponse.jsonObject as! NSDictionary{
                var resultJSON: JSON = [
                    "MASTERCODEA": info["MASTERCODEA"]!,
                    "SNAMECOMPA": info["SNAMECOMPA"]!,
                    "ATOTSHARE": info["ATOTSHARE"]!,
                    "MASTERCODE": info["MASTERCODE"]!,
                    "SNAMECOMP": info["SNAMECOMP"]!,
                    "MASTERCODEB": info["MASTERCODEB"]!,
                    "SNAMECOMPB": info["SNAMECOMPB"]!,
                    "BTOTSHARE": info["BTOTSHARE"]!,
                    "ACCUNITNAV": info["ACCUNITNAV"]!
                ]
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        if mRequest.gradeFundType == "fndclassconverted"{
            if let info:NSDictionary = gradeFundResponse.jsonObject as! NSDictionary{
                var resultJSON: JSON = [
                    "BENCHMARK": info["BENCHMARK"]!,
                    "ELDMEMO": info["ELDMEMO"]!
                ]
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        if mRequest.gradeFundType == "fndclassmasterrate"{
            if let info:NSDictionary = gradeFundResponse.jsonObject as! NSDictionary{
                var resultJSON: JSON = [
                    "subamt": info["subamt"]!
                    
                ]
                if let subcosts:NSArray = info["subcost"] as! NSArray{
                    var jsonarr1 : JSON = [:]
                    var i = 1
                    for subcost in subcosts{
                        if let dic1:NSDictionary = subcost as! NSDictionary{
                            var jsonarr2: JSON = [
                                "RATEMAXCOST": dic1["RATEMAXCOST"]!,
                                "APPMINAMT": dic1["APPAMTRESH"]!,
                                "APPMAXAMT": dic1["APPMAXAMT"]!,
                                "APPAMTRESH": dic1["APPAMTRESH"]!,
                                "SUBMIXAMT": dic1["SUBMIXAMT"]!
                            ]
                            jsonarr1["\(i)"] = jsonarr2
                            i = i + 1
                        }
                    }
                    resultJSON["subcost"] = jsonarr1
                }
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
    }
}
