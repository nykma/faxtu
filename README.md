# ファッ？！

![Built with GH60](https://img.shields.io/badge/built%20with-GH60-yellow.svg)
[![Built with Spacemacs](https://cdn.rawgit.com/syl20bnr/spacemacs/442d025779da2f62fc86c2082703697714db6514/assets/spacemacs-badge.svg)](http://spacemacs.org)

- - - -

```ruby
class FaxtuReadMe
  AUTHOR = "Nyk Ma <moe@nayuki.info>"
  DOCKER_COMPOSE_AVAILABLE = (`which docker-compose` != '') &&
                             (`docker-compose -v` > 'docker-compose version 1.6.0')

  def self.description
    "My RoR scaffold with only JSON API stuff.\n使って、どうぞ。"
  end

  def self.based_on
    based_on_list = {
      ruby: File.read(Rails.root.join('.ruby-version'))
    }

    unless DOCKER_COMPOSE_AVAILABLE
      based_on_list.merge!(
        postgres: '>= 9.6',
        redis: '>= 3.2'
      )
    end

    based_on_list
  end

  def self.highlight
    [
      'Multi-login',
      'Authorization',
      'Version-friendly API',
      'Sentry intergrated',
      'API-blueprint based document',
      'Reasonable Rubocop config'
    ].join("\n")
  end

  def self.preparation
    `git clone https://github.com/nykma/faxtu.git && cd faxtu`
    `cp config/application.sample.yml config/application.yml`
    `ag --nocolor -l NEED_MODIFY | xargs emacsclient -t`
    `bundle i`
    `docker-compose up -d` if DOCKER_COMPOSE_AVAILABLE
    `bin/rails db:create db:schema:load`
    `bin/rails spec`

    true
  end


  def self.main_components
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

  def self.license
    File.read(Rails.root.join('MIT-LICENSE').to_s)
  end
end
```
