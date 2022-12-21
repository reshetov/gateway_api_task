### Description

Test implementation of API gateway client. Based on SaltEdge API.

### Installation

#### Base steps

```bash
git clone git@github.com:organization/project-name.git
cp config/database.yml.example config/database.yml
cp .env.example .env
bundle install
bundle exec rake db:create db:setup
```

#### Extra steps

```bash
1. Fill .env file with required varibles or use ENV to pass them
2. Configure database.yml with yours data
```

#### Start Rails server

```bash
bundle exec rails s
```

### Tests

#### Run application tests

```bash
bundle exec rspec
```
