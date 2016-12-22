# ファッ？！

![Built with GH60](https://img.shields.io/badge/built%20with-GH60-yellow.svg)
[![Built with Spacemacs](https://cdn.rawgit.com/syl20bnr/spacemacs/442d025779da2f62fc86c2082703697714db6514/assets/spacemacs-badge.svg)](http://spacemacs.org)

- - - -

```ruby
class FaxtuReadMe
  def self.description
    "My RoR scaffold with only JSON API stuff.\n使って、どうぞ。"
  end

  def self.based_on
    based_on_list = {
      ruby: File.read('.ruby-version')
    }

    unless DockerCompose::VERSION > '1.6.0'
      based_on_list.merge!(
        postgres: '>= 9.6',
        redis: '>= 3.2'
      )
    end

    based_on_list
  end

  def self.components
    {
      main: %w(
        rack-cors
        figaro
        devise
        grape
        grape-entity
      ),
      development: %w(
        rubocop
      ),
      test: %w(
        rspec-rails
        factory_girl
        faker
      )
    }
  end

  def self.preparation
    `git clone https://github.com/nykma/faxtu.git && cd faxtu`
    `cp config/application.sample.yml config/application.yml`
    `ag NEED_MODIFY # and modify them`
    `bundle`
    `docker-compose up -d` if docker_compose.installed?
    `bin/rails db:create db:migrate`
    `bin/rails spec`

    true
  end

  def self.license
    File.read(Rails.root.join('MIT-LICENSE').to_s)
  end
end
```
