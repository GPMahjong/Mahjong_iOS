//
//  MahjongTests.swift
//  MahjongTests
//
//  Created by Tao, Wang on 2021/6/28.
//

import XCTest
@testable import Mahjong

class MahjongTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWin() throws {
        let handCards: [Card] = [.MAHJONG_BAM1,.MAHJONG_BAM2,.MAHJONG_BAM3,.MAHJONG_BAM5,.MAHJONG_BAM5,.MAHJONG_BAM5,.MAHJONG_DOT2,.MAHJONG_DOT2,.MAHJONG_DOT7,.MAHJONG_DOT8, .MAHJONG_DOT9]
        let showCards: [Card] = [.MAHJONG_DOT9,.MAHJONG_DOT9,.MAHJONG_DOT9]
        let canWin = Win.canWin(handCards, showCards)
        XCTAssertTrue(canWin)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
