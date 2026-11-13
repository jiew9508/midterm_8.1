#!/usr/bin/env bash
# ET-718 Rails 8.1.4.1 setup for AWS Cloud9; run from a cloned GitHub repository.
set -euo pipefail
cd "$(dirname "$0")"
RAILS_VERSION=8.1.4.1
SOURCE_DIR="rails-source"

if ! command -v ruby >/dev/null 2>&1; then
  echo 'Ruby is not installed in this Cloud9 environment.' >&2; exit 1
fi
ruby -e 'abort "Rails 8.1 needs Ruby 3.2 or newer" if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("3.2.0")'

if [[ -d blog ]]; then
  if [[ -f blog/bin/rails ]]; then
    echo 'An existing blog/ Rails application was found.' >&2
    echo 'For safety, setup will NOT overwrite it. Back up or rename it first if you need a fresh installation.' >&2
  else
    echo 'blog/ exists but is not a Rails application. Rename it before running setup.' >&2
  fi
  exit 1
fi

if ! gem list -i '^rails$' -v "${RAILS_VERSION}" >/dev/null; then
  gem install rails -v "${RAILS_VERSION}" --no-document
fi

echo "Generating Rails ${RAILS_VERSION} application..."
rails "_${RAILS_VERSION}_" new blog \
  --database=sqlite3 --skip-git --skip-test --skip-javascript --skip-hotwire \
  --skip-bundle --skip-solid --skip-kamal --skip-thruster --skip-docker

# Overlay the original ET-718 design, views, models, controllers, and migrations.
cp -R "${SOURCE_DIR}/." blog/
cd blog
bundle install

# Cloud9 preview access. These settings affect development only, not production.
ruby - config/environments/development.rb <<'RUBY'
path = ARGV.fetch(0)
source = File.read(path)
marker = /Rails\.application\.configure do\s*\n/
comment = '# ET718 Cloud9 embedded preview (development only)'
unless source.include?(comment)
  abort 'Could not find Rails development config block' unless source.match?(marker)
  insertion = <<~CONFIG
    #{comment}
    config.hosts << /[a-z0-9]+\.vfs\.cloud9\.[a-z0-9-]+\.amazonaws\.com/
    config.action_dispatch.default_headers.delete("X-Frame-Options")
  CONFIG
  source.sub!(marker) { |line| line + insertion.lines.map { |s| '  ' + s }.join }
  File.write(path, source)
end
RUBY

cd ..
# Credentials live outside the web application and are ignored by Git.
if [[ ! -e .local-admin.env ]]; then
  password="$(ruby -rsecurerandom -e 'print SecureRandom.urlsafe_base64(21)')"
  printf 'export BLOG_ADMIN_USER=%q\nexport BLOG_ADMIN_PASSWORD=%q\n' admin "$password" > .local-admin.env
  chmod 600 .local-admin.env
fi
set -a
source .local-admin.env
set +a
cd blog
bin/rails db:prepare
bin/rails db:seed
bin/rails -v
cd ..

cat <<'MSG'

SETUP COMPLETE (Rails 8.1.4.1)
1. Run: bash start-cloud9.sh
2. Cloud9: Preview > Preview Running Application
3. Your editor credentials are in .local-admin.env (DO NOT upload this file)
4. When the site works, in a second terminal run:
   git add blog setup-cloud9.sh start-cloud9.sh .gitignore README.md
   git status
   git commit -m "Build ET-718 blog with Rails 8.1"
   git push origin main

MSG
