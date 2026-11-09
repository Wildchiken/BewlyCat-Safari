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
- **`world: 'MAIN'` 不支持** → 构建时把 `inject.global.js` 嵌入内容脚本（`scripts/safariInject.ts`），在 `document_start` 同步以内联 `<script>` 注入页面上下文，时机与其他浏览器一致
- **`scripting` 权限** → Safari 构建不申请，也不依赖 `scripting.executeScript`
- **后台请求 Cookie** → 按目标接口地址读取 Cookie 并随请求附带（Safari 无容器）
- **移动端跳转拦截** → 同时使用 `declarativeNetRequest` 动态规则与 `webRequest` 监听，任一生效即可
- **评论区等 B 站组件的深色模式** → Shadow DOM 内拿不到插件主题变量；深色模式下把 `<html>` 上已解析的变量写成字面值，挂到所有 `bili-*` 组件的 `:host`
- **`storage.sync` 需要 iCloud** → 未登录 iCloud 时开启云同步会失败并自动回滚开关，导入设置不受影响

### ⚠️ 已知限制
- **`storage.sync` (iCloud)**：未登录 iCloud 时无法使用设置云同步，其他功能不受影响
- **扩展更新**：未签名扩展需要手动替换文件夹；Xcode 打包的版本需要重新构建分发

### 🔧 故障排除

如果扩展在 Safari 中无法正常工作：

1. 检查 Safari 控制台是否有错误信息（Develop → Show JavaScript Console）
2. 确认已在 Safari 设置 → 扩展中为 bilibili.com 授予网站访问权限
3. 尝试重新构建并安装

## Safari Web Extension 资源

- [Safari Web Extensions 文档](https://developer.apple.com/documentation/safariservices/safari_web_extensions)
- [将 Web Extension 迁移到 Safari](https://developer.apple.com/documentation/safariservices/safari_web_extensions/migrating_a_web_extension_to_safari)
- [safari-web-extension-converter 使用参考](https://developer.apple.com/documentation/safariservices/safari_web_extensions/converting_a_web_extension_for_safari)
