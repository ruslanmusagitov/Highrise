//
//  HighriseTests.swift
//  HighriseTests
//
//  Created by Admin on 08.05.2022.
//

import XCTest
@testable import Highrise

class GridTests: XCTestCase {
    func test_grid_hasSide() {
        let sut = makeSUT(side: 5)
        
        XCTAssertEqual(sut.side, 5)
    }
    
    func test_grid_initializesWith3TakenCells() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.takenCells.count, 3)
    }

    func test_grid_takenCellsItemKeyIsPosition() {
        let sut = makeSUT()
        
        XCTAssert(sut.takenCells.keys.first != nil)
    }
    func test_grid_takenCellsItemIsHRColorsArray() {
        let sut = makeSUT()
        
        XCTAssert(sut.takenCells.values.first != nil)
    }
    func test_grid_takenCellsWillHaveTwoCellWithSizeOfTwoAndOneSizeOfOne() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.takenCells.values.filter { $0.count == 2 }.count, 2)
        XCTAssertEqual(sut.takenCells.values.filter { $0.count == 1 }.count, 1)
    }
    func test_gridTwoSameColorOneBlockCells_willMergeInTwoCells() {
        let sut = makeSUT()

        sut.takenCells = [Position(x: 0, y: 0): [.yellow],
                          Position(x: 0, y: 1): [.yellow]]
        sut.iterate()

        XCTAssertEqual(sut.takenCells, [Position(x: 0, y: 0): [.yellow, .yellow]])
    }
    
    private func makeSUT(side: Int = 5) -> Grid {
        Grid(side: side)
    }
}

