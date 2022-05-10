//
//  Grid.swift
//  Highrise
//
//  Created by Admin on 10.05.2022.
//

import Foundation

class Grid {
    private static let kInitiallyTakenCells = 3
    var takenCells: [Position: [HRColor]]
    let side: Int
    init(side: Int = 0) {
        self.side = side
        
        var cells = [Position: [HRColor]]()
        for i in 0..<Grid.kInitiallyTakenCells {
            let pos = Grid.createUniquePos(for: cells, size: side)
            if i == Grid.kInitiallyTakenCells - 1 {
                cells[pos] = HRColor.getRandomColors(1)
            } else {
                cells[pos] = HRColor.getRandomColors(2)
            }
        }
        takenCells = cells
    }

    func iterate() {
        let copy = takenCells
        for pos in copy {
            for neighbor in pos.key.neighbors {
                guard takenCells.keys.contains(neighbor) else { continue }
                if pos.value[0] == takenCells[neighbor]![0] {
                    takenCells[pos.key] = [pos.value[0], pos.value[0]]
                    takenCells.removeValue(forKey: neighbor)
                }
            }
        }
    }

    private static func createUniquePos(for cells: [Position:[HRColor]], size: Int) -> Position {
        let pos = Position(x: Int.random(in: 0..<size), y: Int.random(in: 0..<size))
        if cells[pos] != nil {
            return createUniquePos(for: cells, size: size)
        }
        return pos
    }
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

struct Position: Hashable {
    let x: Int
    let y: Int

    var neighbors: [Position] {
        (max(0, x-1)...(x+1)).flatMap { _x in
            (max(0, y-1)...(y+1)).compactMap { _y in
                if _x == x && _y == y {
                    return nil
                } else if _x == x {
                    return Position(x: _x, y: _y)
                } else if _y == y {
                    return Position(x: _x, y: _y)
                } else {
                    return nil
                }
            }
        }
//        [.init(x: 0, y: 1), .init(x: 1, y: 0)]
    }
}
