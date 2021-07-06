//
//  WallTest.swift
//  MahjongTests
//
//  Created by Tao, Wang on 2021/7/6.
//

import XCTest
@testable import Mahjong

class WallTest: XCTestCase {

    var MahjongCards108TEST: [Card] = [
        // 万
        .MAHJONG_DOT1, .MAHJONG_CRAK1, .MAHJONG_DOT3, .MAHJONG_CRAK1,
        .MAHJONG_CRAK2, .MAHJONG_CRAK2, .MAHJONG_CRAK2, .MAHJONG_CRAK2,
        .MAHJONG_CRAK3, .MAHJONG_CRAK3, .MAHJONG_CRAK3, .MAHJONG_CRAK3,
        .MAHJONG_CRAK4, .MAHJONG_CRAK4, .MAHJONG_CRAK4, .MAHJONG_CRAK4,
        .MAHJONG_CRAK5, .MAHJONG_CRAK5, .MAHJONG_CRAK5, .MAHJONG_CRAK5,
        .MAHJONG_CRAK6, .MAHJONG_CRAK6, .MAHJONG_CRAK6, .MAHJONG_CRAK6,
        .MAHJONG_CRAK7, .MAHJONG_CRAK7, .MAHJONG_CRAK7, .MAHJONG_CRAK7,
        .MAHJONG_CRAK8, .MAHJONG_CRAK8, .MAHJONG_CRAK8, .MAHJONG_CRAK8,
        .MAHJONG_CRAK9, .MAHJONG_CRAK9, .MAHJONG_CRAK9, .MAHJONG_CRAK9,

        // 筒
        .MAHJONG_CRAK1, .MAHJONG_DOT1, .MAHJONG_DOT1, .MAHJONG_DOT1,
        .MAHJONG_DOT2, .MAHJONG_DOT2, .MAHJONG_DOT2, .MAHJONG_DOT2,
        .MAHJONG_DOT3, .MAHJONG_DOT3, .MAHJONG_CRAK1, .MAHJONG_DOT3,
        .MAHJONG_DOT4, .MAHJONG_DOT4, .MAHJONG_DOT4, .MAHJONG_DOT4,
        .MAHJONG_DOT5, .MAHJONG_DOT5, .MAHJONG_DOT5, .MAHJONG_DOT5,
        .MAHJONG_DOT6, .MAHJONG_DOT6, .MAHJONG_DOT6, .MAHJONG_DOT6,
        .MAHJONG_DOT7, .MAHJONG_DOT7, .MAHJONG_DOT7, .MAHJONG_DOT7,
        .MAHJONG_DOT8, .MAHJONG_DOT8, .MAHJONG_DOT8, .MAHJONG_DOT8,
        .MAHJONG_DOT9, .MAHJONG_DOT9, .MAHJONG_DOT9, .MAHJONG_BAM9,

        // 条
        .MAHJONG_BAM1, .MAHJONG_BAM1, .MAHJONG_BAM1, .MAHJONG_BAM1,
        .MAHJONG_BAM2, .MAHJONG_BAM2, .MAHJONG_BAM2, .MAHJONG_BAM2,
        .MAHJONG_BAM3, .MAHJONG_BAM3, .MAHJONG_BAM3, .MAHJONG_BAM3,
        .MAHJONG_BAM4, .MAHJONG_BAM4, .MAHJONG_BAM4, .MAHJONG_BAM4,
        .MAHJONG_BAM5, .MAHJONG_BAM5, .MAHJONG_BAM5, .MAHJONG_BAM5,
        .MAHJONG_BAM6, .MAHJONG_BAM6, .MAHJONG_BAM6, .MAHJONG_BAM6,
        .MAHJONG_BAM7, .MAHJONG_BAM7, .MAHJONG_BAM7, .MAHJONG_BAM7,
        .MAHJONG_BAM8, .MAHJONG_BAM8, .MAHJONG_BAM8, .MAHJONG_BAM8,
        .MAHJONG_BAM9, .MAHJONG_DOT8, .MAHJONG_BAM9, .MAHJONG_DOT9,
    ]
    var drawer: Draw = Draw()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWall() throws {
        drawer.wall.setTiles(tiles: MahjongCards108TEST)
        XCTAssertTrue(drawer.wall.forward == 0)
        XCTAssertTrue(drawer.wall.backward == 0)
        
        let forwardDrawCard = drawer.forwardDraw()
        XCTAssertTrue(forwardDrawCard == .MAHJONG_DOT1)
        XCTAssertTrue(drawer.wall.forward == 1)
        
        let forwardDrawCard2 = drawer.forwardDraw()
        XCTAssertTrue(forwardDrawCard2 == .MAHJONG_CRAK1)
        XCTAssertTrue(drawer.wall.forward == 2)
        
        let backDrawCard = drawer.backwardDraw()
        XCTAssertTrue(backDrawCard == .MAHJONG_BAM9)
        XCTAssertTrue(drawer.wall.backward == 1)
        
        let backDrawCard2 = drawer.backwardDraw()
        XCTAssertTrue(backDrawCard2 == .MAHJONG_DOT9)
        XCTAssertTrue(drawer.wall.backward == 2)
    }
    
    func testWall2() throws {
        drawer.wall.setTiles(tiles: MahjongCards108TEST)
        XCTAssertTrue(drawer.wall.forward == 0)
        XCTAssertTrue(drawer.wall.backward == 0)
        
        let forwardDrawCards = drawer.forwardDrawMulti(n: 12)
        XCTAssertTrue(forwardDrawCards.count == 12)
        XCTAssertTrue(drawer.wall.forward == 12)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
