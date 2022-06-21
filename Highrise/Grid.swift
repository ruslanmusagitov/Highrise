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
    var _new: [Position: [HRColor]] = [:]
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
        let copy = takenCells.keys.sorted(by: { ($0.x + $0.y) < ($1.x + $1.y) })
        for pos in copy {
            guard takenCells.keys.contains(pos) else { continue }
            guard let value = takenCells[pos] else { continue }
            for neighbor in pos.neighbors {
                guard let neighborValue = takenCells[neighbor] else { continue }
                guard value == neighborValue else { continue }

                let neighborValues = takenCells.activeValues(for: pos)
                let neighborPositions = takenCells.activePositions(for: pos)

                if neighborValues.count == 1 && takenCells.activeValues(for: neighbor).count == 1 {
                    let nonEmptyPos: Position = value == _new[pos] ? neighbor : pos
                    let emptyPos: Position = value == _new[pos] ? pos : neighbor
                    takenCells[emptyPos] = []
                    let valuesCount = (takenCells[nonEmptyPos]?.count ?? 0)
                    takenCells[nonEmptyPos] = Array(repeating: value[0], count: valuesCount + 1)
                } else if neighborValues.count == 2 {
                    takenCells[pos] = Array(repeating: value[0], count: neighborValues.count + 1)
                    for neighborPos in neighborPositions {
                        takenCells[neighborPos] = []
                    }
                }
            }
        }
        _new.removeAll()
        print(takenCells)
    }
    
    func put(_ value: [HRColor], in position: Position) {
        guard takenCells[position] == [] else { return }
        takenCells[position] = value
        _new[position] = value
        iterate()
    }

    private static func createUniquePos(for cells: [Position:[HRColor]], size: Int) -> Position {
        let pos = Position(x: Int.random(in: 0..<size), y: Int.random(in: 0..<size))
        if cells[pos] != nil {
            return createUniquePos(for: cells, size: size)
        }
        return pos
    }
}

enum HRColor: CaseIterable, CustomStringConvertible {
    case yellow
    case red
    case blue
    case green
    
    static func getRandomColors(_ amount: Int) -> [HRColor] {
        return (0..<amount).map { _ -> HRColor in
            HRColor.allCases[Int.random(in: 0..<HRColor.allCases.count)]
        }
    }
    var description: String {
        switch self {
        case .yellow:
            return "🟨"
        case .red:
            return "🟥"
        case .blue:
            return "🟦"
        case .green:
            return "🟩"
        }
    }
}

struct Position: Hashable, CustomStringConvertible {
    
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
    
    var description: String {
        "[\(x), \(y)]"
    }
}

extension Dictionary where Key == Position, Value == [HRColor] {
    func activePositions(for pos: Position) -> [Position] {
        filter {
            pos.neighbors.contains($0.key)
        }.filter {
            $0.value == self[pos]
        }.map {
            $0.key
        }
    
    }

    func activeValues(for pos: Position) -> [[HRColor]] {
        filter {
            pos.neighbors.contains($0.key)
        }.filter {
            $0.value == self[pos]
        }.map {
            $0.value
        }
    }
}
