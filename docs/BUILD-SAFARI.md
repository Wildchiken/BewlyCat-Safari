# 构建 BewlyCat Safari 扩展

## 前置条件

- **macOS** (必需，因为 Safari 只在 macOS 上运行)
- **Xcode 15+** (从 Mac App Store 安装，**不是**仅安装 Command Line Tools)
- **pnpm** (`npm install -g pnpm`)
- 本仓库代码

## 构建步骤

### 方式一：自动脚本（推荐）

```bash
# 构建并尝试转换为 Safari Xcode 项目
pnpm safari
```

如果已安装 Xcode，脚本会自动调用 `safari-web-extension-converter` 创建 Xcode 项目。

### 方式二：仅构建 Web Extension

```bash
# 只构建扩展（不含 Xcode 转换）
pnpm safari:build
```

构建产物在 `extension-safari/` 目录。

### 方式三：分步操作

```bash
# 1. 构建 Web Extension
pnpm build-safari

# 2. 转换为 Safari Xcode 项目（需要 Xcode）
xcrun safari-web-extension-converter ./extension-safari \
  --project-location ./extension-safari-macos \
  --macos-only
```

## Xcode 项目配置

1. 打开 `extension-safari-macos/BewlyCat.xcodeproj`
2. 在 **Signing & Capabilities** 中设置你的 Apple Team ID
3. 选择目标设备（Mac）
4. **Build & Run** (⌘R)

## 在 Safari 中启用扩展

1. 运行 Xcode 项目后，Safari 会自动打开
2. 进入 **Safari → 设置... → 扩展**
3. 勾选 **BewlyCat**

## Safari 兼容性说明

本项目已针对 Safari 做了以下适配：

### ✅ 已适配
- **`world: 'MAIN'` 不支持** → 改为 content script 动态注入 `<script>` 标签
- **`storage.sync` 需要 iCloud** → 添加了 `safeSyncStorageGetAll/set` 降级函数
- **`storage.session` 需 Safari 16.4+** → 已有 try-catch 降级到内存存储
- **`declarativeNetRequest`** → 静态规则 (rules.json) 在 Safari 15+ 可用；动态 UA 规则改用 `webRequest` API
- **`webRequest` + `webRequestBlocking`** → 已添加对应的权限和监听器
- **`scripting.executeScript`** → 已跳过，使用动态 `<script>` 标签注入

### ⚠️ 已知限制
- **`storage.sync` (iCloud)**：如果用户未登录 iCloud，云同步功能会自动降级，不会影响其他功能
- **图片加载**：Safari 对 WKWebView 中动态创建的 `<link>` 样式加载可能有不同的行为
- **扩展更新**：Safari 扩展更新需要通过 Xcode 重新构建分发

### 🔧 故障排除

如果扩展在 Safari 中无法正常工作：

1. 检查 Safari 控制台是否有错误信息（Develop → Show JavaScript Console）
2. 确认 `manifest.json` 中的 `browser_specific_settings` 配置正确
3. 尝试重新构建并安装

## Safari Web Extension 资源

- [Safari Web Extensions 文档](https://developer.apple.com/documentation/safariservices/safari_web_extensions)
- [将 Web Extension 迁移到 Safari](https://developer.apple.com/documentation/safariservices/safari_web_extensions/migrating_a_web_extension_to_safari)
- [safari-web-extension-converter 使用参考](https://developer.apple.com/documentation/safariservices/safari_web_extensions/converting_a_web_extension_for_safari)