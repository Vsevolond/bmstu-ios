import Foundation

struct SortedArray<Element: Comparable> {
    var items = [Element]()

    init(items: [Element]? = nil) {
        guard let items else {
            return
        }

        for item in items {
            append(item)
        }
    }

    mutating func append(_ item: Element) {
        let index = lbinsearch(left: 0, right: items.count) { mid in
            return items[mid] > item
        }
        items.insert(item, at: index)
    }

    private func lbinsearch(left: Int, right: Int, check: (Int) -> Bool) -> Int {
        var l = left, r = right

        while l < r {
            let m = (l + r) / 2
            if check(m) {
                r = m
            } else {
                l = m + 1
            }
        }

        return l
    }
}
