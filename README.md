# hello-github

公羽先生的第一个 GitHub 仓库，用于验证「本机改文件 → Git 记录 → 推送到云端」这条完整链路。

- 网页地址：https://github.com/sbetzybweng/hello-github
- 分支：`main`（公开仓库）

## 一、最省事的日常用法

**双击本仓库里的 `save.bat`**，它会自动完成：收集所有改动 → 生成一条带时间戳的提交 → 推送到 GitHub → 显示结果。

也可以直接对我说「保存一下」「上传到 GitHub」，由我执行并验证。

如果想自定义提交说明，在命令行里运行：

```
save.bat "修复了示例脚本的输出"
```

不写说明时，默认用 `Auto save 日期 时间`。

## 二、Git 到底在做什么（三个动作）

| 步骤 | 发生了什么 | 命令 |
|---|---|---|
| 1. 改 | 在本机新增或修改文件 | 直接编辑、保存 |
| 2. 记 | 把这次改动打包成一条可追溯的记录（提交） | `git add -A` + `git commit -m "说明"` |
| 3. 传 | 把记录同步到 GitHub 云端 | `git push origin main` |

GitHub 就是第 3 步之后的那个云端副本：可回溯、可分享、换电脑也能取回。

## 三、命令速查

| 想做什么 | 命令 |
|---|---|
| 看当前状态 | `git status` |
| 看历史记录 | `git log --oneline -5` |
| 保存并上传（一键） | 双击 `save.bat` |
| 取回云端的新改动 | `git pull --rebase origin main` |
| 把云端仓库复制到本机 | `git clone https://github.com/sbetzybweng/hello-github.git` |
| 查看远程地址 | `git remote -v` |
| 用 GitHub CLI 查仓库 | 需设置 `GH_TOKEN`，见下方注意事项 |

## 四、本机环境（已配置完成，无需再动）

| 项目 | 值 |
|---|---|
| Git | 2.55.0.windows.3 |
| GitHub CLI | gh 2.103.3（`C:\Program Files\GitHub CLI\gh.exe`） |
| 提交身份 | `sbetzybweng <355779414+sbetzybweng@users.noreply.github.com>` |
| 凭据 | Windows 凭据管理器（无明文文件，推送免输密码） |
| 默认分支 | `main` |
| 网络 | `github.com` / `api.github.com` 按域名免代理；已开启低速容忍 |

`noreply` 邮箱是 GitHub 提供的隐私地址，避免个人邮箱出现在每一次公开提交记录里。

## 五、注意事项

1. **不要提交敏感信息**：令牌、密码、`.env`、`*.key` 等。`.gitignore` 已排除 `.env` 与常见缓存目录，但新增机密文件前请再确认一次。
2. **网页偶尔打不开**：本机 DNS 有时把 `github.com` 指向不可用的 IP。双击 `C:\Users\sbetz\GitHubSetup\open-github-edge.bat` 可打开走固定可用 IP 的专用浏览器窗口；`fix-github-dns.bat` 以管理员身份运行可永久修复。
3. **多设备协作**：在别的电脑改过并推送后，本机先运行 `git pull --rebase origin main` 再改文件，避免冲突。
4. **`gh` 正式登录尚缺**：现有令牌只有 `repo` / `read:user` / `user:email` 三项，`gh auth login` 还要求 `read:org` + `gist`。生成含五项权限的新令牌后即可一键补齐；在此之前 Git 的提交与推送完全不受影响，`gh` 通过 `GH_TOKEN` 环境变量也能调用。
5. **旧令牌安全收尾**：先前那张令牌曾出现在对话记录中，建议在 https://github.com/settings/tokens 撤销并重建，重建后无需改动本仓库的推送配置（凭据管理器会自动更新）。
