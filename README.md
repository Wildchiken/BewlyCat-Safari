<p align="center"><img src="assets/icon-512.png" width="112" alt="BewlyCat 图标"></p>

<h1 align="center">BewlyCat for Safari</h1>

<p align="center">把 <a href="https://github.com/keleus/BewlyCat">BewlyCat</a> 的 B 站首页和增强功能带到 Safari</p>

<p align="center">
  <a href="https://github.com/Wildchiken/BewlyCat-Safari/releases/latest"><img alt="Release" src="https://img.shields.io/github/v/release/Wildchiken/BewlyCat-Safari?label=Release&color=fb7299"></a>
  <img alt="macOS 15+" src="https://img.shields.io/badge/macOS-15%2B-555?logo=apple">
  <img alt="Safari 18.5+" src="https://img.shields.io/badge/Safari-18.5%2B-1e90ff?logo=safari&logoColor=white">
</p>

<p align="center">
  <a href="https://github.com/Wildchiken/BewlyCat-Safari/releases/latest">下载</a> ·
  <a href="#安装">安装</a> ·
  <a href="#开发">开发</a> ·
  <a href="https://github.com/keleus/BewlyCat">上游项目</a>
</p>

## 安装

> [!IMPORTANT]
> 需要 **macOS 15+** 和 **Safari 18.5+**。发布的是未签名的 Web Extension，不是双击即可安装的 App。

### 1. 下载

从 [最新 Release](https://github.com/Wildchiken/BewlyCat-Safari/releases/latest) 下载 **`extension-safari.zip`**，解压得到 `extension-safari/` 文件夹。页面底部的 Source code 压缩包是源码，不能直接安装。

### 2. 加载到 Safari

先在 **Safari → 设置 → 高级** 中勾选「显示网页开发者功能」，然后任选一种方式：

| | 临时加载 | 通过 Xcode |
| --- | --- | --- |
| **前提** | 「开发者」设置里有「添加临时扩展」 | 已安装完整版 Xcode |
| **失效** | 24 小时后或退出 Safari 时 | 退出 Safari 后需重新允许未签名扩展 |
| **适合** | 先试试看 | 日常使用 |

**临时加载**：打开 **Safari → 设置 → 开发者**，点击「添加临时扩展…」，选择 `extension-safari/` 文件夹。

<details>
<summary>通过 Xcode 加载</summary>

1. 把扩展转换为 Xcode 工程（路径按实际位置修改）：

   ```bash
   xcrun safari-web-extension-converter ~/Downloads/extension-safari --project-location ~/Downloads/BewlyCat-Xcode --macos-only
   ```

2. 打开生成的工程，在 **Signing & Capabilities** 中选择本地开发签名，按 ⌘R 运行。
3. 打开 **Safari → 设置 → 开发者**，勾选「允许未签名的扩展」。

</details>

### 3. 启用

打开 **Safari → 设置 → 扩展**，勾选 BewlyCat，并允许它访问 `bilibili.com`。

## 更新

扩展不会自动更新。下载新版附件后，临时加载需先移除旧扩展再添加；Xcode 方式需重新转换并运行。

## 已知限制

- 设置云同步依赖 iCloud。未登录 iCloud 时开启同步会失败并自动关闭，导入和导出设置不受影响。

## 开发

```bash
pnpm install
pnpm build-safari   # 产物在 extension-safari/
```

- **Xcode 工程与适配细节**：生成 Xcode 工程、Safari 兼容处理和故障排除见 [BUILD-SAFARI.md](docs/BUILD-SAFARI.md)。
- **发布**：推送 `v*` 标签后，[Release 工作流](.github/workflows/release.yml) 会构建并上传 `extension-safari.zip`。
- **同步上游**：Safari 专用代码都以 `process.env.SAFARI` 区分。把上次同步的上游提交（当前为 [`171932cb`](https://github.com/keleus/BewlyCat/commit/171932cb)）到 `HEAD` 的差异作为补丁，应用到新的上游代码上：

  ```bash
  git fetch upstream
  git diff <上次同步的上游提交> HEAD > safari.patch
  git switch -c sync-upstream upstream/main
  git apply -3 safari.patch
  ```

## 许可证

[MIT](LICENSE)。基于 [BewlyCat](https://github.com/keleus/BewlyCat)，后者基于 [BewlyBewly](https://github.com/BewlyBewly/BewlyBewly)。禁止将本项目封装为独立客户端。
