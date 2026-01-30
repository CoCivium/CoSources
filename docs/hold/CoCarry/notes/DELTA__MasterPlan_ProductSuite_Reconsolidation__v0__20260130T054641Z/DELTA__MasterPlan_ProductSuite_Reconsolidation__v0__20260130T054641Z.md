# Delta — MasterPlan + ProductSuite Reconsolidation (v0) UTC=20260130T054641Z

## Intent (pause new pack/agent expansion)
Reconsolidate ProductSuite under one observable Internal MVP gate (S3) and stop relying on manual SideNote ferry for critical workflow continuity.

## Stage model (proposed; CoPrime verifies per repo reality)
- S0: concept only (no rails)
- S1: rails exist; reproducible local workflow; receipts/hashes for key artifacts
- S2: dogfood works but still needs manual ferry / fragile glue
- S3: Internal MVP (OE-observable) — *no SideNote ferry*, persistent UX proves active, one-command bootstrap+self-test+rollback

## S3 Internal MVP acceptance tests (OE-observable)
1) **No SideNote ferry**: session-to-session/context transfer occurs via CoBus transport (local daemon/tray + logs), not copy/paste. Evidence: a single command emits/receives a note end-to-end and produces a receipt in a known path.
2) **Persistent UX proves active**: tray/extension shows “ON” state + last-heartbeat timestamp; user can prove it’s running without opening repos. Evidence: visible indicator + local log line on interval.
3) **One-command bootstrap+self-test+rollback**: ootstrap brings system to known-good; self-test runs preflight + transport + receipts; ollback reverts to last PASS. Evidence: PASS/FAIL output + artifacts (logs + receipts) + reversible state.

## Product stage + next gate (fill in “Current” as best-known; treat as provisional)
| Product | Current (S0–S2) | Next Gate (S3 target) | Evidence required (OE-observable) |
|---|---:|---|---|
| CoBus | S2 (rails+mirror exist; manual ferry still used) | S3: transport replaces ferry | tray/daemon ON; send/recv note; receipts/logs; rollback |
| CoGuard/CoGuardian | S1–S2 (hardening scripts exist; UX uneven) | S3: “guardian ON” + audit PASS | scheduled-task hygiene PASS; focus-steal mitigated; visible ON; rollback |
| CoStacks | S1–S2 (registry+packs exist; needs consolidation) | S3: single bootstrap consumes stacks | one-command pulls/verify/run stacks; receipts; rollback |
| CoPreFrame/CoPreAttach | S1 (templates/rails) | S3: attach discipline enforced by tooling | tooling enforces headers/typed sections; self-test proves |
| CoAnchor | S1–S2 (canonical pointers) | S3: bootstrap obeys FULL-URL pointers only | preflight FAIL-CLOSED on non-FULL; logs show pointers used |
| CoHalo | S1–S2 (PR hygiene/publish rails) | S3: publish gate is one-command + reversible | PASS/FAIL publish check; whitelist enforcement; rollback |
| CoAgent | S0–S1 (patterns emerging) | S3: local agent runner is constrained + observable | can run one safe workflow; logs; rollback; no silent drift |
| CoCrux/BPOE/CoVows | S2 (norms exist but scattered) | S3: acceptance tests codified + enforced | self-test includes BPOE checks; logs/receipts; rollback |

## MasterPlan delta (what changes immediately)
- Declare S3 acceptance tests as *the* internal MVP definition across ProductSuite.
- Make CoBus transport the primary continuity mechanism; SideNotes become optional human-readable summaries only.
- Consolidate one-command bootstrap/self-test/rollback entrypoint (stack-driven via CoStacks).
- Require OE-observable “ON + heartbeat” UX (tray/extension) as non-negotiable for S3.
- Standardize receipts/hashes everywhere (sha256 first-token compare; commit-SHA RAW pickup pointers).

## Next action (CoPrime-owned)
CoPrime selects “Current stage” truth for each product, assigns owners, and updates MasterPlan tables accordingly.