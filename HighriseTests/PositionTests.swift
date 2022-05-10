//
//  PositionTests.swift
//  HighriseTests
//
//  Created by Admin on 10.05.2022.
//

import Foundation
import XCTest
@testable import Highrise

class PositionTests: XCTestCase {
    func test_positionX0Y0_hasTwoNeighbours() {
        let sut = Position(x: 0, y: 0)
        XCTAssertEqual(sut.neighbors, [Position(x: 0, y: 1), Position(x: 1, y: 0)])
    }
    
    func test_positionX1Y1_hasFourNeighbours() {
        let sut = Position(x: 1, y: 1)
        XCTAssertEqual(sut.neighbors, [Position(x: 0, y: 1), Position(x: 1, y: 0), Position(x: 1, y: 2), Position(x: 2, y: 1)])
    }
    func test_positionX2Y2_hasFourNeighbours() {
        let sut = Position(x: 2, y: 2)
        let shouldbe = [Position(x: 2, y: 3), Position(x: 2, y: 1), Position(x: 1, y: 2), Position(x: 3, y: 2)]
        XCTAssertTrue(shouldbe.contains(sut.neighbors[0]))
        XCTAssertTrue(shouldbe.contains(sut.neighbors[1]))
        XCTAssertTrue(shouldbe.contains(sut.neighbors[2]))
        XCTAssertTrue(shouldbe.contains(sut.neighbors[3]))
    }
    func test_positionX4Y4_hasTwoNeighbours() {
        let sut = Position(x: 4, y: 4)

        let shouldbe = [Position(x: 4, y: 3), Position(x: 3, y: 4)]
        XCTAssertTrue(shouldbe.contains(sut.neighbors[0]))
        XCTAssertTrue(shouldbe.contains(sut.neighbors[1]))
    }
}
//x0 1 2 3 4
//y
//0[][][][][]
//1[][0][][][]
//2[][][][][]
//3[][][][][]
//4[][][][][]
