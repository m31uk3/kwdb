

# Pii<T> Type Documentation

Type-level security for Personally Identifiable Information in the Latent Patterns codebase.

## What is Pi<T>?

`Pii<T>` is an **opaque wrapper type** for Personally Identifiable Information. It uses TypeScript's type system to make PII leaks a **compile-time error** — not a runtime surprise.

### Core Idea

| Without Pii&lt;T&gt; | With Pii&lt;T&gt; |
|---------------------|-------------------|
| `string` flows everywhere; easy to accidentally log, serialize, or send to telemetry | `Pii<string>` flows through code; raw value only via explicit `.expose()` |
| No compile-time guard against passing raw email to logging | TypeScript rejects `log.info({ email: rawEmail })` if the function expects `PiiString` |
| Audit trail requires manual discipline | `rg '\.expose\(\)'` produces a complete audit trail of PII access points |

### Key Properties

1. **Private `#inner` field** — The wrapped value is stored in a private class field. It cannot be accessed except through the explicit `.expose()` method.

2. **Safe-by-default serialization** — `toJSON()`, `toString()`, and `[Symbol.toPrimitive]` all produce HMAC-SHA256 pseudonyms (e.g., `pii_a3f7c2e1b9d4f8a0`) or the fallback `[PII]` when the key is not configured. So:
   - `console.log(email)` → pseudonym
   - `JSON.stringify({ email })` → pseudonym
   - `` `user: ${email}` `` → pseudonym

3. **Greppable access points** — Every call to `.expose()` is a deliberate PII unwrapping. Code review can scan for `.expose()` in diffs.

4. **Deterministic pseudonyms** — Same input + same key → same output. Enables user-level correlation in Honeycomb (BubbleUp) without exposing raw PII.

## Module Structure

```
src/lib/pii.ts
├── Pii<T>              # Opaque wrapper class
├── pii(value)          # Factory: pii('user@example.com') → Pii<string>
├── PiiString           # Type alias: Pii<string>
├── exposePii(value)     # Unwrap at serialization boundaries (handles Pii | plain T)
├── pseudonymizePii(s)   # HMAC-SHA256 for values NOT wrapped in Pii (e.g. IPs)
├── configurePiiKey(k)   # Called at startup from hooks.server.ts
├── isPiiKeyConfigured() # Check if key is set
├── PII_MARKER           # '[PII]' — fallback when key not configured
└── PII_PREFIX           # 'pii_' — prefix for pseudonyms
```