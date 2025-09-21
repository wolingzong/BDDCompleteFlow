// 文件名: ShoppingCartSpec.swift

import Quick
import Nimble
@testable import BDDCompleteFlow // 导入主应用模块，以便访问 ShoppingCart 和 Product

class ShoppingCartSpec: QuickSpec {
    override class func spec() {
        
        // 1. 描述顶级对象：我们要测试的是 "购物车"
        describe("购物车") {
            
            var cart: ShoppingCart! // 声明一个购物车变量
            
            // beforeEach 会在当前 describe/context 块中的每一个 "it" 运行之前执行
            // 这确保了每个测试用例都在一个干净、独立的环境中运行
            beforeEach {
                cart = ShoppingCart() // 创建一个新的、空的购物车实例
            }
            
            // 2. 描述一个特定场景/上下文 (Context)
            context("当购物车刚被创建时") {
                
                // 3. 描述一个具体行为和预期结果 (It)
                it("商品数量应该为 0") {
                    expect(cart.itemCount).to(equal(0))
                }
                
                it("总价格应该为 0.0") {
                    expect(cart.totalPrice).to(equal(0.0))
                }
                
                it("应该是空的") {
                    expect(cart.items).to(beEmpty())
                }
            }
            
            context("当向购物车中添加商品时") {
                
                let apple = Product(name: "苹果", price: 5.0)
                let orange = Product(name: "橙子", price: 7.5)
                
                context("添加一个商品后") {
                    beforeEach {
                        cart.add(apple)
                    }
                    
                    it("商品数量应该为 1") {
                        expect(cart.itemCount).to(equal(1))
                    }
                    
                    it("总价格应该等于该商品的价格") {
                        expect(cart.totalPrice).to(equal(5.0))
                    }
                    
                    it("应该包含刚刚添加的商品") {
                        expect(cart.items).to(contain(apple))
                    }
                }
                
                context("添加多个商品后") {
                    beforeEach {
                        cart.add(apple)
                        cart.add(orange)
                    }
                    
                    it("商品数量应该是所有商品的总数") {
                        expect(cart.itemCount).to(equal(2))
                    }
                    
                    it("总价格应该是所有商品价格的总和") {
                        expect(cart.totalPrice).to(equal(12.5))
                    }
                }
            }
            
            context("当从购物车移除商品时") {
                let apple = Product(name: "苹果", price: 5.0)
                let orange = Product(name: "橙子", price: 7.5)
                
                beforeEach {
                    cart.add(apple)
                    cart.add(orange)
                    
                    cart.remove(apple) // 从包含2个商品的购物车中移除苹果
                }
                
                it("商品数量应该减少") {
                    expect(cart.itemCount).to(equal(1))
                }
                
                it("总价格应该更新") {
                    expect(cart.totalPrice).to(equal(orange.price))
                }
                
                it("不应再包含被移除的商品") {
                    expect(cart.items).toNot(contain(apple))
                }
                
                it("应该仍然包含其他商品") {
                    expect(cart.items).to(contain(orange))
                }
            }
            
            context("当清空购物车时") {
                beforeEach {
                    cart.add(Product(name: "苹果", price: 5.0))
                    cart.add(Product(name: "橙子", price: 7.5))
                    
                    cart.clear() // 清空操作
                }
                
                it("所有指标应该重置为初始状态") {
                    expect(cart.itemCount).to(equal(0))
                    expect(cart.totalPrice).to(equal(0.0))
                    expect(cart.items).to(beEmpty())
                }
            }
        }
    }
}
