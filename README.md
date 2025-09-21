# 使用 Quick & Nimble 在 Swift 中进行 BDD 测试示例

这是一个简单的 Swift 示例项目，旨在演示如何在 iOS/macOS 开发中实践**行为驱动开发 (Behavior-Driven Development, BDD)**。

项目核心是测试一个基础的 `ShoppingCart` 模型，通过 BDD 的方式来描述和验证其各种行为，例如添加商品、移除商品、清空购物车等。

## 核心理念

本项目着重展示：

*   **BDD 的思想**: 将测试用例写成易于理解的、描述行为的“规格说明书”。
*   **使用 Quick**: 一个 RSpec 风格的 BDD 框架，它提供了 `describe`, `context`, `it` 等 DSL，让测试结构清晰、可读性强。
*   **使用 Nimble**: 一个表现力丰富的断言库，它让 `expect(value).to(equal(10))` 这样的断言语句读起来更像自然语言。
*   **单元测试**: 针对 `ShoppingCart` 这个独立的业务逻辑单元进行完整的功能覆盖。

## 🛠️ 技术栈

*   **Swift**: 项目的主要开发语言。
*   **Xcode**: 用于开发和运行测试。
*   **Quick**: 用于构建 BDD 测试结构。
*   **Nimble**: 用于编写可读性强的断言。
*   **Swift Package Manager (SPM)**: 用于管理 Quick 和 Nimble 这两个第三方依赖。

## 🚀 如何开始

### 准备工作

*   确保您已安装最新版本的 Xcode。
*   本项目使用 Swift Package Manager，依赖项会在 Xcode 中自动下载和链接。

### 运行项目

1.  克隆本仓库到您的本地电脑：
    ```bash
    git clone [您的仓库HTTPS链接]
    ```
2.  使用 Xcode 打开项目根目录下的 `.xcodeproj` 文件。
3.  Xcode 会自动解析并下载 `Quick` 和 `Nimble` 依赖包。您可以在左侧的文件导航器中看到 `Package Dependencies` 目录。

## ✅ 运行测试

这是本项目的核心部分。

1.  在 Xcode 中，打开测试导航器 (左侧面板的菱形图标)。
2.  您可以通过以下任一方式运行所有测试：
    *   使用快捷键 **`Cmd + U` (⌘U)**。
    *   点击顶部菜单栏 `Product` -> `Test`。
3.  您也可以在代码编辑器中，点击 `ShoppingCartSpec.swift` 文件里 `describe` 或 `it` 旁边的菱形播放按钮，来单独运行某个测试套件或单个测试用例。

当所有测试通过时，您会在 Xcode 中看到绿色的对勾标记，以及 "Test Succeeded" 的提示。

## 📄 代码示例

以下是 `ShoppingCartSpec.swift` 中的一个片段，展示了 Quick 和 Nimble 如何让测试变得清晰易读：

```swift
import Quick
import Nimble
@testable import BDDCompleteFlow // 替换为您的项目名称

class ShoppingCartSpec: QuickSpec {
    override class func spec() {
        describe("购物车") {
            var cart: ShoppingCart!
            let apple = Product(name: "苹果", price: 5.0)
            let orange = Product(name: "橙子", price: 7.0)

            beforeEach {
                cart = ShoppingCart()
                cart.add(apple)
                cart.add(orange)
            }

            context("当从购物车移除商品时") {
                beforeEach {
                    cart.remove(apple)
                }

                it("不应再包含被移除的商品") {
                    expect(cart.items.contains(where: { $0.name == apple.name })).to(beFalse())
                }

                it("商品数量应该减少") {
                    expect(cart.itemCount).to(equal(1))
                }

                it("应该仍然包含其他商品") {
                    expect(cart.items.contains(where: { $0.name == orange.name })).to(beTrue())
                }

                it("总价格应该更新") {
                    expect(cart.totalPrice).to(equal(orange.price))
                }
            }
        }
    }
}
```

## 📄 许可证

本项目采用 [MIT 许可证](https://opensource.org/licenses/MIT)。
