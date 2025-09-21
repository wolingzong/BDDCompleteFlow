// 文件名: ShoppingCart.swift

import Foundation

class ShoppingCart {
    
    // 使用 private(set) 保护 items 数组，外部只能读取，不能直接修改
    private(set) var items: [Product] = []
    
    // 计算属性：总价格
    var totalPrice: Double {
        // 使用 reduce 计算数组中所有商品的价格总和
        return items.reduce(0) { $0 + $1.price }
    }
    
    // 计算属性：商品数量
    var itemCount: Int {
        return items.count
    }
    
    // 添加一个商品
    func add(_ product: Product) {
        items.append(product)
    }
    
    // 移除一个商品
    // 注意：这会移除第一个匹配到的商品
    func remove(_ product: Product) {
        if let index = items.firstIndex(of: product) {
            items.remove(at: index)
        }
    }
    
    // 清空购物车
    func clear() {
        items.removeAll()
    }
}
