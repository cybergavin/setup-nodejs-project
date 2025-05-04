
# Setup Node.js Project

A composite GitHub Action that:
- Sets up a specified Node.js version
- Caches `node_modules` using the lock file hash
- Installs dependencies **only if the cache is missed**

Supports `npm`, `yarn`, and `pnpm` with automatic install command detection, and optional override.

---

## Usage

```yaml
- name: Setup Node.js
  uses: cybergavin/setup-nodejs-project@v1
  with:
    node-version: '22'
    cache-path: node_modules
    lock-file: package-lock.json
    working-directory: ./frontend
````

📝 **Note**: Only `lock-file` is required. The rest have sensible defaults.

---

## Inputs

| Name                | Required | Default        | Description                                                                                                                                                                    |
| ------------------- | -------- | -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `node-version`      | ❌        | `'22'`         | Node.js version or range. Supports any valid input for `actions/setup-nodejs-project`.                                                                                                   |
| `cache-path`        | ❌        | `node_modules` | Relative path(s) to cache (newline-separated if multiple).                                                                                                                     |
| `lock-file`         | ✅        | —              | Lock file name used to infer install command and generate cache key.                                                                                                           |
| `working-directory` | ❌        | `.`            | Project directory (contains `package.json` and the lock file).                                                                                                                 |
| `install-command`   | ❌        | *(auto)*       | Optional override for the install command. If omitted, it's auto-detected based on lock file: `npm ci`, `yarn install --frozen-lockfile`, or `pnpm install --frozen-lockfile`. |

---

## 💡 Behavior

### Cache Optimization

* Caches dependencies under `cache-path`
* Cache key is based on `node-version`, OS, and the contents of the `lock-file`

### Dependency Installation

* **Skipped if cache is hit**
* Automatically detects and runs:

  * `npm ci`
  * `yarn install --frozen-lockfile`
  * `pnpm install --frozen-lockfile`
* If detection fails, the action exits with an error unless a manual `install-command` is provided.

---

## Example: Monorepo Setup

```yaml
- name: Setup Backend
  uses: cybergavin/setup-nodejs-project@v1
  with:
    lock-file: backend/package-lock.json
    working-directory: backend

- name: Setup Frontend
  uses: cybergavin/setup-nodejs-project@v1
  with:
    lock-file: frontend/yarn.lock
    working-directory: frontend
```

---

## Security

* Uses **pinned versions** of `actions/setup-node` and `actions/cache` for stability and security.