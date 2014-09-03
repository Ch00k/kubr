kuber
=====

[Kubernetes](https://github.com/GoogleCloudPlatform/kubernetes) Ruby client

Installation
------------

```
gem install kuber
```

Usage
-----

```
require 'kuber'

Kuber.configure do |config|
  config.url = 'https://130.211.56.93/api/v1beta1'
  config.username = 'admin'
  config.password = 'hv9tgLhKdej3HAHE'
end

cl = Kuber::Client.new
pods = cl.list_pods

pod = {
    :desiredState => {
        :manifest => {
            :version => 'v1beta1',
            :containers => [
                {
                    :name => 'aytest2',
                    :image => 'dockerfile/nginx',
                }
            ]
        }
    }
}

cl.create_pod pod
```