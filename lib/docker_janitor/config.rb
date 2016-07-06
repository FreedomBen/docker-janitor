require 'yaml'

module DockerJanitor
  class Config
    def self.filename
      "#{Dir.home}/.docker-janitor.yml"
    end

    def self.default_yaml
      %q(---
        :docker-janitor:
          # safe-containers is an array of regular expressions
          # against which container names will be checked to see if
          # they are protected.  This can help to make sure that
          # data-only containers for example are not
          # unintentionally deleted.  These are ruby flavored
          # regular expressions, check with the ruby operator =~
          # rubular.com is a helpful site for testing your regex
          :safe_containers:
            - db$
            - postgres
            - mongo
            - dynamo
            - mysql
          :safe_images:
            - a-sha-of-some-sort
          :safe_volumes:
            - a-sha-of-some-sort
      ).split("\n").map{|s| s.sub(' ' * 8, '')}.join("\n")
    end

    def self.default_settings
      YAML.load(self.default_yaml)
    end

    def self.settings(filename = self.filename)
      if File.exist?(filename)
        self.default_settings.merge(YAML.load_file(filename))
      else
        self.default_settings
      end
    end

    def self.write_settings(settings, filename = self.filename)
      File.write(filename, settings)
    end

    def self.write_default_settings_file(filename = self.filename)
      self.write_settings(self.default_yaml, filename)
    end
  end
end
