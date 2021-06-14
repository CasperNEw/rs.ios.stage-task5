import Foundation

public typealias Supply = (weight: Int, value: Int)

public final class Knapsack {

    let maxWeight: Int
    let drinks: [Supply]
    let foods: [Supply]
    var maxKilometers: Int {
        findMaxKilometres()
    }

    init(_ maxWeight: Int, _ foods: [Supply], _ drinks: [Supply]) {
        self.maxWeight = maxWeight
        self.drinks = drinks
        self.foods = foods
    }

    func findMaxKilometres() -> Int {
        let drinkDistance = getDistanceArray(for: drinks, with: maxWeight)
        let foodDistance = getDistanceArray(for: foods, with: maxWeight)

        var maxDistance = 0
        for i in 0...maxWeight {
            let distance = min(drinkDistance[i], foodDistance[maxWeight - i])
            if distance > maxDistance {
                maxDistance = distance
            }
        }
        return maxDistance
    }

    private func getDistanceArray(for items: [Supply], with weight: Int) -> [Int] {
        let count = items.count
        var matrix = Array(repeating: Array(repeating: 0,count: weight + 1), count: count + 1)

        for i in 0..<(count + 1) {
            for j in 0..<(weight + 1) {
                if i == 0 || j == 0 {
                    matrix[i][j] = 0
                } else if items[i - 1].weight <= j {
                    matrix[i][j] = max(items[i - 1].value + matrix[i - 1][j - items[i - 1].weight],
                                       matrix[i - 1][j])
                } else {
                    matrix[i][j] = matrix[i - 1][j]
                }
            }
        }
        return matrix[count]
    }
}
