import Foundation

class StockMaximize {

    private var currentProfit = 0

    func countProfit(prices: [Int]) -> Int {
        currentProfit = 0
        var prices = prices
        calculateGrowth(of: &prices, startIndex: 0)
        return currentProfit
    }

    private func calculateGrowth(of array: inout Array<Int>, startIndex: Int) {
        let currentSlice = array[startIndex...]
        guard let vertex = currentSlice.max(),
              let endIndex = currentSlice.firstIndex(of: vertex) else { return }

        currentProfit += array[startIndex..<endIndex].reduce(0) { $0 + (vertex - $1) }
        guard array.count > endIndex + 1 else { return }
        calculateGrowth(of: &array, startIndex: endIndex + 1)
    }
}
