<!--
HLDocS:LLM-MANAGED
doc_id: doc-20260914-SXRD1-GODOT-SETUP
lang: ja-JP
canonical_title: Demo 1 Godot検証環境構築手順
document_type: usage
canonical_document: true
-->

[目次](../../../目次.md) > マニュアル > 開発向け > Demo > Demo 1 Godot検証環境構築手順

# Demo 1 Godot検証環境構築手順

## Purpose（存在理由）

本手順は、SansaXR Demo 1のGodot版をWindows 11上で再現可能な形で構築し、O3DE版との比較条件を揃えるための検証環境構築手順を定義する。

対象baselineは `Godot 4.7.2-stable` とする。

## Non-goals（対象外）

- GodotをSansaXRの正式Engineとして採用決定すること
- Linux/macOS環境の成立確認
- standalone HMD向けAndroid export
- Phase B common wire/serverの構築
- XR Toolsを必須依存とすること

## 1. 前提条件

### 1.1 OS

- Windows 11 x64

Godot 4.7の推奨desktop OSにWindows 11が含まれるため、Demo 1比較baselineと一致する。

### 1.2 Hardware

O3DE版とGodot版は同一比較PCで実施する。

最低限以下を記録する。

- CPU
- GPU
- GPU driver version
- RAM
- Windows version/build
- Storage種別

Godot公式System Requirementsでは、Forward+/Mobile rendererにVulkan対応GPUが必要である。Demo 1ではXR向け推奨に従いMobile rendererを使用する。

### 1.3 PCVR環境

- OpenXR対応HMD
- 対応Controller
- SteamVR

最初のPCVR baselineではSteamVRをOpenXR Runtimeとして使用する。

## 2. Godot 4.7.2-stableの導入

1. Godot公式archive/download pageから `4.7.2-stable` のWindows x86_64版を取得する。
2. 任意の固定directoryへ展開する。
3. Godot Editorを起動する。
4. About等でversionが `4.7.2.stable` 系であることを確認する。

### 成功条件

- Project Managerが正常起動する。
- 4.7.2-stableとして認識できる。
- 新規project作成画面まで遷移できる。

## 3. SteamVRをOpenXR Runtimeに設定

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

## 4. Godot Demo 1 project作成

1. Godot Project Managerで `Create` を選択する。
2. project名を `SansaXRDemo1Godot` とする。
3. Rendererは `Mobile` を選択する。
4. Version Control MetadataはGitを選択してよい。
5. projectを作成してEditorを起動する。

### Renderer選択理由

Godot 4.7公式XR documentationでは、desktop VRおよびstandalone headsetのXR projectにMobile rendererを推奨している。

Forward+でもXRは動作可能だが、XR向け最適化ではMobile rendererが推奨されているため、Demo 1比較baselineはMobileとする。

## 5. OpenXR設定

Godot Editorで以下を設定する。

1. `Project` > `Project Settings` を開く。
2. `XR > OpenXR > Enabled` を有効化する。
3. `XR > Shaders > Enabled` を有効化する。
4. `Save & Restart` を実行する。

OpenXRはGodot起動時に必要なgraphics初期化へ関与するため、runtime中に後付けで有効化する前提にしない。

## 6. 最小XR scene作成

新規3D sceneを作成し、以下の構造を基準とする。

```text
Demo1Root (Node3D)
└─ XROrigin3D
   ├─ XRCamera3D
   ├─ LeftHand (XRController3D)
   │  └─ MeshInstance3D
   └─ RightHand (XRController3D)
      └─ MeshInstance3D
```

さらにworld確認用として以下を追加する。

- DirectionalLight3D
- WorldEnvironment
- floor用MeshInstance3DまたはStaticBody3D

左右Controllerには識別可能な単純primitive meshを設定する。

## 7. Controller設定

`LeftHand` と `RightHand` のXRController3DへそれぞれOpenXRの左右hand tracker/actionに対応する設定を行う。

最低限、pose追跡が取得できることを確認する。

複雑なinput action mappingは後続のController input testで定義する。

## 8. XR起動script

最初の成立確認ではrootまたはXROrigin3Dに以下の役割を持つscriptを設定する。

- `XRServer.find_interface("OpenXR")` でOpenXR interfaceを取得する
- interfaceが初期化済みであることを確認する
- main viewportの `use_xr` をtrueにする
- 初期化失敗時はログへ明示する

例:

```gdscript
extends Node3D

var xr_interface: XRInterface

func _ready() -> void:
    xr_interface = XRServer.find_interface("OpenXR")
    if xr_interface and xr_interface.is_initialized():
        print("OpenXR initialized successfully")
        get_viewport().use_xr = true
    else:
        push_error("OpenXR not initialized")
```

本scriptはGodot公式4.7 XR setupの最小構成に基づく。

## 9. Physics update rate

Godotのdefault physics tickは60 Hzであり、HMD refresh rateと一致しない場合がある。

Demo 1の最初のOpenXR成立確認ではdefaultのままでもよいが、performance比較前にHMD refresh rateとの整合を確認する。

測定条件としてphysics tickを変更した場合は必ず記録する。

## 10. SXR-D1-FUNC-XR-001成立確認

以下を満たすことを確認する。

1. SteamVRがOpenXR Runtimeとして起動している。
2. Godot projectを実行する。
3. Outputへ `OpenXR initialized successfully` 相当が出る。
4. HMDへ映像が出力される。
5. 頭部移動/回転がXRCamera3Dへ反映される。
6. 左右Controller poseが取得される。
7. Controller childのprimitiveが実機controllerへ追従する。

### FAIL扱い

- `OpenXR` interfaceが取得できない
- interfaceがinitializedにならない
- HMDへ映像が出ない
- 左右Controllerの一方または両方を追跡できない
- Editor実行とexported projectで成立条件が異なる

## 11. XR Toolsの扱い

Godot XR Toolsはlocomotion、interaction、hand representation等を提供するが、Demo 1の最小OpenXR成立確認では必須としない。

理由:

- Engine本体のOpenXR能力を先に確認する
- O3DEとの比較でtoolkit依存を混入させない
- 必要になった機能だけ後から追加できる

XR Toolsを導入した場合はversionを記録し、その機能がEngine本体かtoolkit由来かを区別する。

## 12. 検証記録

最低限、以下をWorklogまたはtest resultへ記録する。

```text
Engine: Godot 4.7.2-stable
OS:
CPU:
GPU:
GPU Driver:
RAM:
Renderer: Mobile
OpenXR Enabled:
XR Shaders Enabled:
OpenXR Runtime:
SteamVR Version:
HMD:
Controllers:
XR Tools Version: not installed / <version>
Editor launch result:
OpenXR result:
HMD tracking result:
Left controller result:
Right controller result:
Notes:
```

## 13. Git管理へ取り込む前の確認

以下をrepositoryへ含めないことを基本とする。

- `.godot/`
- editor cache
- temporary logs
- export output
- user-local configuration

`project.godot`、scene、script、必要なsource asset等は管理対象とする。

## 14. 次工程

Godot側で `SXR-D1-FUNC-XR-001` が成立した後、以下へ進む。

1. simple world固定
2. Controller input確認
3. Phase A native networking
4. remote head/hand synchronization
5. disconnect/reconnect
6. Runtime UGC trial

## 参照情報

- Godot 4.7 System Requirements: https://docs.godotengine.org/en/4.7/about/system_requirements.html
- Godot 4.7 Setting up XR: https://docs.godotengine.org/en/4.7/tutorials/xr/setting_up_xr.html
- Godot 4.7 OpenXRInterface: https://docs.godotengine.org/en/4.7/classes/class_openxrinterface.html
- Godot 4.7 XR Tools: https://docs.godotengine.org/en/4.7/tutorials/xr/introducing_xr_tools.html

---

[目次](../../../目次.md) > マニュアル > 開発向け > Demo > Demo 1 Godot検証環境構築手順
