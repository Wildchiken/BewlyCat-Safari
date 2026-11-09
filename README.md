# BewlyCat for Safari

![Release](https://img.shields.io/github/v/release/Wildchiken/BewlyCat-Safari?label=Release)
![macOS](https://img.shields.io/badge/macOS-15%2B-slategray?logo=apple)
![Safari](https://img.shields.io/badge/Safari-18.5%2B-blue?logo=safari)

[BewlyCat](https://github.com/keleus/BewlyCat) 的 Safari 版本。基于 BewlyCat v1.8.3 之后的上游 main（[`171932cb`](https://github.com/keleus/BewlyCat/commit/171932cb)）。

## 安装

目标环境为 **macOS 15+、Safari 18.5+**。附件为 Web Extension 文件，不是双击安装的 macOS App。

从 [v1.0.2 Release](https://github.com/Wildchiken/BewlyCat-Safari/releases/tag/v1.0.2) 下载 [extension-safari.zip](https://github.com/Wildchiken/BewlyCat-Safari/releases/download/v1.0.2/extension-safari.zip)，解压得到 `extension-safari/` 文件夹。不要将 GitHub 自动提供的 **Source code** 压缩包当作可安装扩展。

### 方式一：通过 Xcode 加载

适用于没有“添加临时扩展”入口的 Safari，需要安装完整 Xcode（不仅是 Command Line Tools）。

1. 在终端中将解压后的扩展转换为 Xcode 工程，将下方路径替换为实际路径：

   ```bash
   xcrun safari-web-extension-converter /绝对路径/extension-safari --project-location /绝对路径/BewlyCat-Safari-Xcode --macos-only
   ```

2. 打开生成的 Xcode 工程，在 Signing & Capabilities 中配置本地开发签名，选择 Mac 后执行 **Product → Run（⌘R）**。
3. 在 Safari 的“设置 → 高级”中启用网页开发者功能，再到“设置 → 开发者”允许未签名的扩展（仅用于加载自行构建、信任的扩展）。该允许项在退出 Safari 后会重置。
4. 在 **Safari → 设置 → 扩展** 中启用 BewlyCat，并为 `bilibili.com` 授予所需的网站访问权限。

更多构建信息见 [Safari 构建文档](docs/BUILD-SAFARI.md)。

### 方式二：临时加载（仅限提供此入口的 Safari）

如果“Safari → 设置 → 开发者”中有 **Add Temporary Extension…（添加临时扩展）**：点击此项，按提示允许未签名扩展，选择解压后的 `extension-safari/` 文件夹，然后在扩展设置中启用并授予网站权限。

**临时扩展会在 24 小时后或退出 Safari 时移除**，需要重新添加。没有该入口时，请使用上方 Xcode 方式，不要寻找旧式“扩展构建器”菜单。

安装方式与限制以 [Apple 官方运行 Safari Web Extension 文档](https://developer.apple.com/documentation/safariservices/running-your-safari-web-extension) 为准。

### 更新与已知限制

- 从旧版升级时使用本次附件；Xcode 方式需重新转换、构建并运行，临时加载方式需移除旧临时扩展后添加新版。此附件不提供自动更新。
- 设置云同步依赖 iCloud；未登录 iCloud 时开启同步会失败并回滚开关，其他功能及设置导入不受此限制影响。

## 构建

```bash
pnpm install
pnpm build-safari
```

产物在 `extension-safari/`，按上方步骤加载。需要打包成 Xcode 工程时见 [BUILD-SAFARI.md](docs/BUILD-SAFARI.md)。

## 发布

推送 `v*` 标签后，[Release 工作流](.github/workflows/release.yml) 会自动构建并把 `extension-safari.zip` 附到对应的 GitHub Release。

## 同步上游

Safari 适配只改动少量文件（`src/manifest.ts`、`src/contentScripts/index.ts`、`src/inject/index.ts`、`src/background/index.ts`、`src/background/utils.ts`、`src/background/settingsStorageCoordinator.ts`、`vite.config.ts`），其余代码与上游保持一致：

```bash
git remote add upstream https://github.com/keleus/BewlyCat
git fetch upstream --tags
git diff <上次同步的上游标签> HEAD -- src vite.config.ts > safari.patch
git checkout -b sync-upstream <新上游标签>
git apply -3 safari.patch
```

## 许可证

[MIT](LICENSE)。禁止打包为独立客户端。
