<!--
HLDocS:LLM-MANAGED
doc_id: doc-20260914-SXRD1-ENV1
lang: ja-JP
canonical_title: Demo 1検証環境仕様
document_type: spec
canonical_document: true
-->

[目次](../../目次.md) > 仕様 > Demo > Demo 1検証環境仕様

# Demo 1検証環境仕様

## Purpose（存在理由）

本仕様は、O3DE版およびGodot版のDemo 1を可能な限り同一条件で比較し、Engine差と検証環境差を混同しないための基準環境を定義する。

本仕様に記載するEngine versionはDemo 1比較の固定baselineであり、SansaXR製品版の恒久採用versionを意味しない。

## Non-goals（対象外）

- 全対応OSの確定
- 製品版の最低/推奨ハードウェア確定
- 特定HMD vendorへの正式対応宣言
- O3DEまたはGodotの正式採用決定
- Phase B common wire/serverの最終技術選定

## 定義・制約

### SXR-D1-ENV-001 対象OS

Demo 1の実動作比較baselineはWindows 11 x64とする。

LinuxおよびmacOSはDemo 1の必須成功条件としない。

### SXR-D1-ENV-002 O3DE version

O3DE版は `26.05.0` をbaselineとする。

選定根拠は、2026-09-14時点でO3DE公式Release Notesが示すcurrent versionであることによる。

検証中にpatchまたは後継stable releaseへ変更する場合、変更前後をWorklogへ記録し、比較条件差として扱う。

### SXR-D1-ENV-003 Godot version

Godot版は `4.7.2-stable` をbaselineとする。

`4.8-dev` 系はDemo 1のbaselineに使用しない。

検証中に後継stable releaseへ変更する場合、変更前後をWorklogへ記録し、比較条件差として扱う。

### SXR-D1-ENV-004 OpenXR runtime

最初のPCVR検証runtimeはSteamVRのOpenXR Runtimeをbaseline候補とする。

実検証開始時に使用runtime名およびversionを記録する。

別OpenXR Runtimeを使用した場合は同一テスト結果へ混在させず、runtime別結果として記録する。

### SXR-D1-ENV-005 HMD / Controller

HMDおよびControllerの具体的modelは、実機検証開始時にWorklogおよび検証結果へ記録する。

O3DE版とGodot版の直接比較では、原則として同一HMD、同一Controller、同一OpenXR Runtimeを使用する。

### SXR-D1-ENV-006 比較PC

性能比較は原則として同一PCで実施する。

最低限以下を記録する。

- CPU
- GPU
- GPU driver version
- Memory
- Windows version/build
- Storage種別
- OpenXR Runtime/version
- HMD/Controller

異なるPC間で取得した値をEngine優劣の直接比較値として扱わない。

### SXR-D1-ENV-007 Network

Phase AおよびPhase Bの比較では、可能な限り同一LAN条件を使用する。

最低限以下を記録する。

- Wired / Wi-Fi
- Link speed
- Client/Server配置
- 同一PC / 同一LAN別PC / WAN の別
- 意図的なlatency/loss付加の有無

最初の成立確認はLANで行う。

### SXR-D1-ENV-008 Phase A networking

Phase Aでは各Engineの標準または公式推奨networking機能を優先して使用する。

O3DE側とGodot側でwire compatibilityを要求しない。

Phase Aの目的は、各Engineをnativeに利用した場合の成立性、性能、開発性、server構成を評価することである。

### SXR-D1-ENV-009 Phase B networking

Phase BではO3DE版とGodot版から同一のSansaXR意味論で通信できるcommon wire/server trialを用いる。

Transport、encoding、server実装言語はPhase A結果を確認した後に決定する。

Phase Aの成立前にPhase B共通化を実装しない。

### SXR-D1-ENV-010 UGC比較asset

Runtime UGCの最初の比較assetはGLBを第一候補とする。

比較assetは以下を満たす単純なものを用意する。

- 単一または少数mesh
- textureを含めてもよい
- animation必須ではない
- script/behaviorを含めない
- 複雑なphysicsを必須としない

同一source assetをO3DE版とGodot版で使用する。

### SXR-D1-ENV-011 UGC比較条件

UGC検証では、事前にEngine projectへimport済みのassetだけで成立した場合と、実行中に外部sourceから取得・変換・loadできた場合を区別して記録する。

Editorまたはbuild-time Asset Processorへの依存が必要な場合、その依存を明示する。

### SXR-D1-ENV-012 計測条件

Performance比較では以下を一致させるよう努める。

- HMD refresh rate
- Render resolutionまたはscale
- World content
- Remote player数
- Network update rate
- UGC asset
- 実行時間

一致できない条件は差分として記録する。

### SXR-D1-ENV-013 比較結果の有効性

直接比較値は、比較条件が一致または差分が明示されている場合のみ有効とする。

Engine固有制約により条件を一致させられないこと自体も比較結果として記録する。

### SXR-D1-ENV-014 実装開始条件

各Engineの実装開始前に最低限以下を記録する。

- Engine version
- OS
- OpenXR Runtime
- HMD/Controller
- 開発toolchain

実機情報が未確定の場合、project skeleton作成までは進めてよいが、XR成功判定は行わない。

## 参照情報

- O3DE 26.05.0 Release Notes: https://www.docs.o3de.org/docs/release-notes/2605-0-release-notes/
- Godot 4.7.2 stable: https://godotengine.org/download/archive/4.7.2-stable/

---

[目次](../../目次.md) > 仕様 > Demo > Demo 1検証環境仕様
