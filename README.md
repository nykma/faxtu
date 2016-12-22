# ファッ？！

```ruby
class FaxtuReadMe
  def self.description
    "My RoR scaffold with only JSON API stuff.\n使って、どうぞ。"
  end

  def self.based_on
    based_on_list = {
      ruby: File.read('.ruby_version')
    }

    if docker_compose_installed?
      based_on_list.merge(
        docker_compose: ">= 1.6.0"
      )
    else
      based_on_list.merge(
        postgres: ">= 9.5",
      )
    end
  end

  def self.main_components
    %w(
      rack-cors
      figaro
      devise
      grape
      grape-entity
    )
  end

  def self.preparation
    `git clone https://github.com/nykma/faxtu.git && cd faxtu`
    `cp config/application.sample.yml config/application.yml`
    `ag NEED_MODIFY # and modify them`
    `bundle`
    `bin/rails setup`
    `bin/rake spec`
    true
  end
end
```
