# STREAK

A shared workout / steps / meals tracker for two people, built as a single
static page — no build step, no framework.

## Why there's a backend involved

This started as a Claude.ai artifact, which has its own built-in storage
(`window.storage`). That API only exists inside Claude.ai's artifact
sandbox — a plain page on GitHub Pages can't use it. To keep the "shared
board" behavior (both people see the same data, from any device), the app
now talks to a small free [Supabase](https://supabase.com) project instead.

GitHub Pages itself stays 100% free and static — Supabase is just the
free database sitting behind it.

## 1. Create the backend (~2 minutes, no credit card)

1. Go to [supabase.com](https://supabase.com) → sign up → **New project**.
2. Once it's created, open **SQL Editor** → **New query**, paste in the
   contents of [`supabase-setup.sql`](./supabase-setup.sql), and run it.
   This creates the one table the app needs.
3. Go to **Settings → API**. Copy the **Project URL** and the
   **anon public** key.
4. Open `index.html`, find these two lines near the top of the `<script>`
   block, and paste your values in:
   ```js
   const SUPABASE_URL = 'YOUR_SUPABASE_URL';
   const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';
   ```

## 2. Get it on GitHub + hosted

If you're doing this by hand:
```bash
git init
git add .
git commit -m "Initial commit"
gh repo create streak-tracker --public --source=. --push
```
Then in the repo on GitHub: **Settings → Pages → Deploy from a branch →
main → / (root) → Save**. GitHub gives you a `https://<you>.github.io/streak-tracker/`
URL a minute or two later.

### If you're handing this to Claude Code instead

Open this folder in Claude Code and give it something like:

> Check that `index.html` is a working static site, then initialize git,
> create a public GitHub repo called `streak-tracker` from this folder,
> push it, and enable GitHub Pages on the `main` branch root. Give me the
> live URL when it's done.

Claude Code will walk you through `gh auth login` the first time if
you're not already signed in.

## Notes

- `supabase-setup.sql` — run once, in Supabase, before first use.
- The anon key is meant to be public/client-side, but the table's write
  policy is wide open (see the SQL file's comments) — fine for a private
  project between two people, not something to reuse for sensitive data.
- Next planned feature: calorie tracking, either manual entry or a
  photo-based estimate via a vision model — will likely need a small
  serverless function once it's built, which Supabase also supports for
  free (Edge Functions).
