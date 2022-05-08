//
//  HighriseTests.swift
//  HighriseTests
//
//  Created by Admin on 08.05.2022.
//

import XCTest
@testable import Highrise

class HighriseTests: XCTestCase {
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
    private func makeSUT(side: Int = 5) -> Grid {
        Grid(side: side)
    }
}

class Grid {
    private static let kInitiallyTakenCells = 3
    var takenCells: [Position: [HRColor]]
    let side: Int
    init(side: Int = 0) {
        self.side = side
        
        var cells = [Position: [HRColor]]()
        for i in 0..<Grid.kInitiallyTakenCells {
            let pos = Grid.createUniquePos(for: cells)
            if i == Grid.kInitiallyTakenCells - 1 {
                cells[pos] = HRColor.getRandomColors(1)
            } else {
                cells[pos] = HRColor.getRandomColors(2)
            }
        }
        takenCells = cells
    }
    
    private static func createUniquePos(for cells: [Position:[HRColor]]) -> Position {
        let pos = Position(x: Int.random(in: 0..<5), y: Int.random(in: 0..<5))
        if cells[pos] != nil {
            return createUniquePos(for: cells)
        }
        return pos
    }
}

struct Position: Hashable {
    let x: Int
    let y: Int
}

enum HRColor: CaseIterable {
    case yellow
    case red
    case blue
    case green
    
    static func getRandomColors(_ amount: Int) -> [HRColor] {
        return (0..<amount).map { _ -> HRColor in
            HRColor.allCases[Int.random(in: 0..<HRColor.allCases.count)]
        }
    }
}
