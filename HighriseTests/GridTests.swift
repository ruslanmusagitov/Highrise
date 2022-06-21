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
    func test_gridTwoSameColorOneBlockCellsAfterIteration_willMergeInTwoCells() {
        let sut = makeSUT()

        sut.takenCells = [Position(x: 0, y: 0): [.yellow],
                          Position(x: 0, y: 1): [.yellow]]
        sut.iterate()
        
        XCTAssertEqual(
            sut.takenCells, [
                Position(x: 0, y: 0): [.yellow, .yellow],
                Position(x: 0, y: 1): []
            ]
        )
    }
    
    func test_gridNewlyPlacedBlockNearSameBlock_willMergeNewBlockInExistingBlock() {
        let sut = makeSUT()
        
        sut.takenCells = [Position(x: 0, y: 0): [],
                          Position(x: 0, y: 1): [.yellow]]
        sut.put([.yellow], in: Position(x: 0, y: 0))
        
        XCTAssertEqual(
            sut.takenCells, [
                Position(x: 0, y: 0): [],
                Position(x: 0, y: 1): [.yellow, .yellow]
            ]
        )
    }
    
    func test_gridNewlyPlacedBlockNearDifferentBlock_willNotMergeNewBlockInExistingBlock() {
        let sut = makeSUT()
        
        sut.takenCells = [Position(x: 0, y: 0): [],
                          Position(x: 0, y: 1): [.yellow]]
        sut.put([.red], in: Position(x: 0, y: 0))
        
        XCTAssertEqual(sut.takenCells, [Position(x: 0, y: 0): [.red], Position(x: 0, y: 1): [.yellow]])
    }
    
    func test_gridNewlyPlacesTwoHeightBlockNearSameBlock_willMergeItInExistingBlockAndHeightWillBeThree() {
        let sut = makeSUT()
        
        sut.takenCells = [Position(x: 0, y: 0): [],
                          Position(x: 0, y: 1): [.yellow, .yellow]]
        sut.put([.yellow, .yellow], in: Position(x: 0, y: 0))
        
        XCTAssertEqual(
            sut.takenCells, [
                Position(x: 0, y: 0): [],
                Position(x: 0, y: 1): [.yellow, .yellow, .yellow]
            ]
        )
    }
    
    func test_gridNewBlockPlacedBetweenTwoSameBlocks_willCreateThreeHeightBlockOnThatPosition() {
        let sut = makeSUT()
        
        sut.takenCells = [Position(x: 0, y: 0): [.yellow],
                          Position(x: 0, y: 1): [],
                          Position(x: 0, y: 2): [.yellow]]
        sut.put([.yellow], in: Position(x: 0, y: 1))
        
        XCTAssertEqual(
            sut.takenCells, [
                Position(x: 0, y: 0): [],
                Position(x: 0, y: 1): [.yellow, .yellow, .yellow],
                Position(x: 0, y: 2): []
            ]
        )
    }
    
    func test_gridNewBlockPlacedWithOneSameNeighborAndOneDifferentNeighbor_willBeMergedInSameBlock() {
        let sut = makeSUT()
        
        sut.takenCells = [Position(x: 0, y: 0): [.yellow],
                          Position(x: 0, y: 1): [],
                          Position(x: 0, y: 2): [.red]]
        sut.put([.yellow], in: Position(x: 0, y: 1))
        
        XCTAssertEqual(
            sut.takenCells, [
                Position(x: 0, y: 0): [.yellow, .yellow],
                Position(x: 0, y: 1): [],
                Position(x: 0, y: 2): [.red]
            ]
        )
    }

    private func makeSUT(side: Int = 5) -> Grid {
        Grid(side: side)
    }
}

