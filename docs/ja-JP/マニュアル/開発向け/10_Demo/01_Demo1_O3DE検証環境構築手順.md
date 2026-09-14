<!--
HLDocS:LLM-MANAGED
doc_id: doc-20260914-SXRD1-O3DE-SETUP
lang: ja-JP
canonical_title: Demo 1 O3DE検証環境構築手順
document_type: usage
canonical_document: true
-->

[目次](../../../目次.md) > マニュアル > 開発向け > Demo > Demo 1 O3DE検証環境構築手順

# Demo 1 O3DE検証環境構築手順

## Purpose（存在理由）

本手順は、SansaXR Demo 1のO3DE版をWindows 11上で再現可能な形で構築し、Godot版との比較条件を揃えるための検証環境構築手順を定義する。

対象baselineは `O3DE 26.05.0` とする。

## Non-goals（対象外）

- O3DEをSansaXRの正式Engineとして採用決定すること
- Linux/macOS環境の成立確認
- Meta Quest等へのstandalone deployment
- Phase B common wire/serverの構築
- 本番用performance tuning

## 1. 前提条件

### 1.1 OS

- Windows 11 x64
- Windows Updateを適用済みであること

O3DE公式要件ではWindows 10 20H2以降が対象であるが、Demo 1比較baselineはWindows 11とする。

### 1.2 Hardware

実機比較ではO3DE版とGodot版に同一PCを使用する。

最低限、以下を記録する。

- CPU
- GPU
- GPU driver version
- RAM
- Windows version/build
- Storage種別

O3DE公式要件を満たすことを事前に確認する。

### 1.3 PCVR環境

- OpenXR対応HMD
- 対応Controller
- SteamVR

最初のPCVR baselineではSteamVRをOpenXR Runtimeとして使用する。

## 2. 開発toolchainの準備

### 2.1 Visual Studio

Visual Studio 2022を推奨baselineとする。

インストーラーで少なくとも以下を有効化する。

- Desktop development with C++
- Windows 10/11 SDK
- MSVC C++ toolset

O3DE 26.05の公式System Requirementsに適合するversionを使用する。

### 2.2 CMake

O3DE Windows installerに付属するCMakeを使用する場合、別途CMakeを導入しなくてよい。

source build等で外部CMakeを使用する場合はO3DE 26.05要件に従い `3.30.0` 以上を使用する。

## 3. O3DE 26.05.0の導入

1. O3DE公式Download pageからWindows版 `26.05` installerを取得する。
2. installerを実行する。
3. O3DE Project Managerが起動できることを確認する。
4. Project Managerまたはinstall directoryからEngine versionが `26.05.0` であることを確認する。

### 成功条件

- Project Managerが正常起動する。
- O3DE 26.05.0が認識される。
- 新規project作成画面まで遷移できる。

## 4. SteamVRをOpenXR Runtimeに設定

1. HMDをPCへ接続する。
2. SteamVRを起動する。
3. SteamVR SettingsからOpenXR設定を開く。
4. SteamVRをcurrent OpenXR Runtimeとして設定する。
5. HMDおよび左右ControllerがSteamVR上でtrackingされることを確認する。

### 記録

- SteamVR version
- OpenXR Runtime表示
- HMD model
- Controller model

## 5. O3DE Demo 1 project作成

Project Managerを起動する。

1. `Create a New Project` を選択する。
2. 標準のgame向けtemplateを基準に新規projectを作成する。
3. project名は `SansaXRDemo1O3DE` とする。
4. projectの保存場所はSansaXR repository配下に固定せず、一度ローカルbuild可能な場所で生成してよい。
5. 生成後、SansaXR repositoryへ格納するsource範囲を確認してから取り込む。

### 注意

O3DEは生成物、build cache、Asset Processor cache等が大きいため、生成物を無条件にGit管理へ入れない。

## 6. OpenXR関連Gemの確認

O3DEのOpenXR integrationはGemとして扱われるため、Project Managerの `Configure Gems` でXR/OpenXR関連Gemを確認する。

確認対象:

- XR基盤Gem
- OpenXR / OpenXRVk相当Gem

### 6.1 Gem Catalogに存在する場合

1. XR関連Gemを有効化する。
2. OpenXR/OpenXRVk関連Gemを有効化する。
3. Saveする。
4. rebuildが要求された場合はProject Managerからbuildする。

### 6.2 Gem Catalogに存在しない場合

O3DE Extras側のOpenXR Gemが必要な可能性がある。

この場合は、O3DE 26.05.0と互換性が確認できるO3DE Extras revisionを使用し、Gemを登録してから有効化する。

互換revisionを推測で固定しない。実際の26.05環境でGem metadata/version compatibilityを確認し、その結果をWorklogへ記録する。

### CLI確認例

Engine rootから以下のCLIで登録状態を確認できる。

```powershell
scripts\o3de.bat get-registered
```

Gemを名前で有効化できる構成の場合は以下の形式を使用する。

```powershell
scripts\o3de.bat enable-gem --gem-name <GemName> --project-path <ProjectPath>
```

正確なGem nameはインストール済みGem Catalogまたは `gem.json` を正本とする。

## 7. 初回build

Project Managerから対象projectを選択し、`Build Project` を実行する。

初回buildではthird-party packageの取得等により時間がかかる場合がある。

### 成功条件

- configure/buildがerror終了しない。
- O3DE Editorを起動できる。
- Asset Processorが致命errorなく起動する。

## 8. 最小XR level作成

Demo 1の最初の成立確認では、以下のみを配置する。

- Floor
- Directional Light
- HMD/XR Camera相当
- Left Controller表示用primitive
- Right Controller表示用primitive

高度なavatar、physics、networking、UGCはこの時点では追加しない。

## 9. SXR-D1-FUNC-XR-001成立確認

以下を満たすことを確認する。

1. SteamVRがOpenXR Runtimeとして起動している。
2. O3DE projectを実行する。
3. HMDへ映像が出力される。
4. 頭部移動/回転がviewへ反映される。
5. 左右Controller poseを取得できる。
6. Controller poseに追従してprimitiveが移動する。

### FAIL扱い

以下はいずれもFAILまたは要調査として記録する。

- OpenXR sessionを開始できない
- HMD出力がない
- 左右Controllerの一方または両方が追跡できない
- Editorでは動くがLauncherでは成立しない
- 特定のEditor常駐処理がないとruntime成立しない

## 10. 検証記録

最低限、以下をWorklogまたはtest resultへ記録する。

```text
Engine: O3DE 26.05.0
OS:
CPU:
GPU:
GPU Driver:
RAM:
Visual Studio:
CMake:
OpenXR Runtime:
SteamVR Version:
HMD:
Controllers:
XR/OpenXR Gem names and versions:
Project template:
Build result:
Editor launch result:
OpenXR result:
HMD tracking result:
Left controller result:
Right controller result:
Notes:
```

## 11. Git管理へ取り込む前の確認

以下をrepositoryへ含めないことを基本とする。

- build output
- Asset Processor cache
- temporary logs
- user-local configuration
- downloaded third-party cache

実際のO3DE 26.05 project生成後に `.gitignore` を再確認し、必要なsource/configurationのみcommitする。

## 12. 次工程

O3DE側で `SXR-D1-FUNC-XR-001` が成立した後、以下へ進む。

1. simple world固定
2. Controller input確認
3. Phase A native networking
4. remote head/hand synchronization
5. disconnect/reconnect
6. Runtime UGC trial

## 参照情報

- O3DE Download: https://o3de.org/download/
- O3DE Windows Installation: https://docs.o3de.org/docs/welcome-guide/setup/installing-windows/
- O3DE System Requirements: https://docs.o3de.org/docs/welcome-guide/requirements/
- O3DE Project Manager: https://docs.o3de.org/docs/user-guide/project-config/project-manager/
- O3DE Adding/Removing Gems: https://docs.o3de.org/docs/user-guide/project-config/add-remove-gems/
- O3DE CLI Reference: https://docs.o3de.org/docs/user-guide/project-config/cli-reference/

---

[目次](../../../目次.md) > マニュアル > 開発向け > Demo > Demo 1 O3DE検証環境構築手順
