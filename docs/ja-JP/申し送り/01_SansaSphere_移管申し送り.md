[目次](../README.md) > docs/ja-JP > 申し送り > SansaSphere 移管

# SansaSphere 移管申し送り

## 1. 概要

SansaXR は XR runtime / networking / OpenXR を主責務とする repository として整理を進める。

そのため、ecosystem-level infrastructure に属する account / audit / logging / provenance 系統は、SansaSphere へ責務移管する。

---

## 2. 移管対象

以下は SansaSphere 側へ移管対象とする。

### account / identity

- user account
- authentication
- federation identity
- profile
- session metadata

### audit / logging

- audit
- access log
- activity log
- moderation log
- operation trace
- distributed trace

### provenance / governance

- provenance
- ownership trace
- asset usage history
- creator history
- conversion history
- AI generation trace

### analytics / visibility

- dashboard
- usage visibility
- activity analytics
- creator analytics
- economy analytics

---

## 3. SansaXR に残す対象

SansaXR には以下を残す。

- XR runtime
- OpenXR
- networking
- multiplayer
- synchronization
- runtime session
- runtime plugin
- controller input
- runtime-side rendering integration

---

## 4. dependency direction

```text
SansaXR
 └─ depends on SansaSphere
```

SansaXR は user / audit / provenance infrastructure を直接保持せず、SansaSphere を利用する。

---

## 5. 移管理由

以下の理由により、SansaSphere へ責務分離する。

- XR runtime 固有責務ではないため
- SansaVRM / Studio AI からも共通利用されるため
- ecosystem-level infrastructure として扱うため
- provenance / governance を統合するため
- implementation monorepo 化を避けるため

---

## 6. 今後の整理

### Phase 1

- responsibility 分離
- repository federation 更新
- handover document 作成

### Phase 2

- auth / logging / audit 再配置
- provenance 再配置
- dashboard / analytics 分離

### Phase 3

- SansaXR runtime 軽量化
- ecosystem infrastructure 統合

---

[目次](../README.md) > docs/ja-JP > 申し送り > SansaSphere 移管