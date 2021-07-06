//
//  WinTests.swift
//  WinTests
//
//  Created by Tao, Wang on 2021/6/28.
//

import XCTest
@testable import Mahjong

class WinTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testWin1() {
        let handCards: [Card] = [.MAHJONG_BAM1,.MAHJONG_BAM2,.MAHJONG_BAM3,.MAHJONG_BAM5,.MAHJONG_BAM5,.MAHJONG_BAM5,.MAHJONG_DOT2,.MAHJONG_DOT2,.MAHJONG_DOT7,.MAHJONG_DOT8, .MAHJONG_DOT9]
        let showCards: [Card] = [.MAHJONG_DOT9,.MAHJONG_DOT9,.MAHJONG_DOT9]
        let canWin = Win.canWin(handCards, showCards)
        XCTAssertTrue(canWin)
    }
    
    func testWin12() {
        let handCards: [Card] = [.MAHJONG_BAM1,.MAHJONG_BAM2,.MAHJONG_BAM3,.MAHJONG_BAM3,.MAHJONG_BAM3,.MAHJONG_BAM4,.MAHJONG_BAM5,.MAHJONG_BAM6,.MAHJONG_DOT6,.MAHJONG_DOT7,.MAHJONG_DOT8]
        let showCards: [Card] = [.MAHJONG_DOT9,.MAHJONG_DOT9,.MAHJONG_DOT9, .MAHJONG_DOT9]
        let canWin = Win.canWin(handCards, showCards)
        XCTAssertTrue(canWin)
    }
    
    func testWin13() {
        let handCards: [Card] = [.MAHJONG_BAM1,.MAHJONG_BAM2,.MAHJONG_BAM3,.MAHJONG_BAM3,.MAHJONG_BAM3,.MAHJONG_BAM3,.MAHJONG_BAM4,.MAHJONG_BAM5,.MAHJONG_BAM6,.MAHJONG_DOT6,.MAHJONG_DOT7,.MAHJONG_DOT8]
        let showCards: [Card] = [.MAHJONG_DOT9,.MAHJONG_DOT9,.MAHJONG_DOT9, .MAHJONG_DOT9]
        let canWin = Win.canWin(handCards, showCards)
        XCTAssertFalse(canWin)
    }
    
    //7对
    func testWin4() {
        let handCards: [Card] = [.MAHJONG_BAM1,.MAHJONG_BAM1,.MAHJONG_BAM3,.MAHJONG_BAM3,.MAHJONG_BAM4,.MAHJONG_BAM4,.MAHJONG_BAM4,.MAHJONG_BAM4,.MAHJONG_BAM6,.MAHJONG_BAM6,.MAHJONG_DOT7,.MAHJONG_DOT7,.MAHJONG_CRAK1,.MAHJONG_CRAK1]
        let showCards: [Card] = []
        let canWin = Win.canWin(handCards, showCards)
        XCTAssertTrue(canWin)
    }
    
    func testWin5() {
        let handCards: [Card] = [.MAHJONG_BAM1,.MAHJONG_BAM2,.MAHJONG_BAM3,.MAHJONG_BAM3,.MAHJONG_BAM3,.MAHJONG_BAM3,.MAHJONG_BAM4,.MAHJONG_BAM5,.MAHJONG_BAM6,.MAHJONG_DOT4,.MAHJONG_DOT5,.MAHJONG_DOT7,.MAHJONG_DOT9]
        let result = Win.findSequenceOrTripletCnt(sortedCards: handCards)
        XCTAssertTrue(result.0 == 3)
        XCTAssertTrue(result.1.count == 4)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
