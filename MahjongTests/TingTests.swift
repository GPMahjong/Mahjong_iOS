//
//  TingTests.swift
//  MahjongTests
//
//  Created by Tao, Wang on 2021/7/6.
//

import XCTest
@testable import Mahjong

class TingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTing1() throws {
        let handCards: [Card] = [.MAHJONG_BAM1,.MAHJONG_BAM2,.MAHJONG_BAM3,.MAHJONG_BAM5,.MAHJONG_BAM5,.MAHJONG_BAM5,.MAHJONG_DOT2,.MAHJONG_DOT2,.MAHJONG_DOT7,.MAHJONG_DOT8]
        let showCards: [Card] = [.MAHJONG_DOT9,.MAHJONG_DOT9,.MAHJONG_DOT9]
        let canTing = Ting.CanTing(handCards: handCards, showCards: showCards)
        XCTAssertTrue(canTing.0)
        for (index, card) in canTing.1.enumerated() {
            if index == 0 {
                XCTAssertTrue(card == .MAHJONG_DOT6)
            } else {
                XCTAssertTrue(card == .MAHJONG_DOT9)
            }
        }
    }
    
    func testTing2() throws {
        let handCards: [Card] = [.MAHJONG_BAM1,.MAHJONG_BAM2,.MAHJONG_BAM3,.MAHJONG_BAM5,.MAHJONG_BAM5,.MAHJONG_BAM5,.MAHJONG_DOT2,.MAHJONG_DOT2,.MAHJONG_DOT5,.MAHJONG_DOT7,.MAHJONG_DOT8]
        let showCards: [Card] = [.MAHJONG_DOT9,.MAHJONG_DOT9,.MAHJONG_DOT9]
        let canTingMap = Ting.GetTingMap(handCards: handCards, showCards: showCards)
        
        let dot5TingCards = canTingMap[.MAHJONG_DOT5]
        XCTAssertTrue(dot5TingCards?.count == 2)
        XCTAssertTrue(dot5TingCards?.first == .MAHJONG_DOT6)
        XCTAssertTrue(dot5TingCards?.last == .MAHJONG_DOT9)
        
        let dot8TingCards = canTingMap[.MAHJONG_DOT8]
        XCTAssertTrue(dot8TingCards?.count == 1)
        XCTAssertTrue(dot8TingCards?.first == .MAHJONG_DOT6)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
