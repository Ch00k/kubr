Kubr
=====

Ruby client for [Kubrnetes](https://github.com/GoogleCloudPlatform/Kubrnetes) 
[REST API](http://cdn.rawgit.com/GoogleCloudPlatform/kubernetes/31a0daae3627c91bc96e1f02a6344cd76e294791/api/kubernetes.html)

Installation
------------

```
gem install Kubr
```

Usage
-----

```
require 'Kubr'

Kubr.configure do |config|
  config.url = 'https://130.211.56.93/api/v1beta1'
  config.username = 'admin'
  config.password = 'hv9tgLhKdej3HAHE'
end

cl = Kubr::Client.new
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