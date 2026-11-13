# Jason — Devlog — ET-718 Rails 8.1

**Student:** Jason  
**Framework:** Ruby on Rails **8.1.4.1** (Ruby 3.2+)  
**Database:** SQLite 2.x · **Assets:** Propshaft · **Environment:** AWS Cloud9

This keeps the original dark navy and neon-accent technical journal project design and its article/comment features. It has been updated from the previous Rails 7.2 source package.

## Important: what is in this ZIP?

This is a **Rails 8.1 source-overlay starter**, not a generated Rails application. The folder `rails-source/` contains Rails 8.1-compatible project source files. Running `setup-cloud9.sh` creates the standard Rails 8.1 application in `blog/`, copies these files, resolves dependencies, runs migrations, and loads demo posts. The generated `blog/` directory, including `Gemfile.lock`, needs to be committed to GitHub for submission.

Do **not** upload this ZIP as a single GitHub file. Extract it and upload the individual files and folders into a repository.

## Getting started in Cloud9

1. Create a new GitHub repository, then upload the **contents** of the extracted ZIP (include the `rails-source/` folder and scripts).
2. In AWS Cloud9, open **Window → New Terminal**.
3. Run these commands, replacing `YOUR-USERNAME/YOUR-REPO` with your actual GitHub repository:

```bash
cd ~/environment
git clone https://github.com/YOUR-USERNAME/YOUR-REPO.git
cd YOUR-REPO
bash setup-cloud9.sh
bash start-cloud9.sh
```

4. Keep the server terminal open. Choose **Preview → Preview Running Application**.
5. To see your randomly generated editor username/password, use a *second* terminal:

```bash
cd ~/environment/YOUR-REPO
cat .local-admin.env
```

Keep `.local-admin.env` private. It is gitignored. A unique password is generated on setup.

## Test the site

- Load the home page and verify the styling.
- Create, view, edit and delete articles (editor login required).
- Add a comment; verify it appears and can be removed by the editor.
- Check the project-specific features: technology topics, keyword search and topic filters.
- Verify Rails version: `cd blog && bin/rails -v` should show `Rails 8.1.4.1`.

## Submit the **complete Rails 8.1 app** to GitHub

After testing, open a second terminal, from the repository root:

```bash
git status
git add blog setup-cloud9.sh start-cloud9.sh .gitignore README.md
git status
# Inspect the changes: NEVER push passwords, credentials, keys, .env files, or *.sqlite3

git commit -m "Complete ET-718 midterm with Rails 8.1"
git push origin main
```

Your GitHub repo should now show `blog/app/`, `blog/config/`, `blog/db/`, `blog/bin/`, `blog/Gemfile`, **`blog/Gemfile.lock`**, `blog/config.ru`, and `blog/Rakefile`.

If you already have a repository with Rails 7 source files, you may use the same repo but avoid submitting outdated ZIPs as your main application. The finished `blog/` directory and its Rails 8.1 Gemfile are what matter.

## Troubleshooting

| Error | Fix |
|---|---|
| `rails: command not found` | `gem install rails -v 8.1.4.1 --no-document`, then run setup again if it did not generate `blog/`. |
| `bootsnap/setup` | Run `cd blog && bundle install` and retry. |
| `Blocked hosts` | `setup-cloud9.sh` adds a development-only Cloud9 host allowlist. Restart the server. |
| `refused to connect` | Keep `bash start-cloud9.sh` running; use `curl -I http://127.0.0.1:8080/` in a second terminal. |
| `blog/ exists` | Setup intentionally stops instead of overwriting work. Back it up before starting fresh; do not delete a working application. |
| `ruby version too old` | Rails 8.1 needs Ruby 3.2+. Check `ruby -v`. |

**Verification:** Source syntax, scripts, and ZIP files were checked. Full Rails boot/install and interactive testing must be done in an environment with Rails gems installed, such as your Cloud9 account. The ZIP itself is not a deployed or already-running website.
