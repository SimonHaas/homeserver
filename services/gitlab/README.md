# gitlab

[https://about.gitlab.com/](https://about.gitlab.com/)

## setup

docker exec -it gitlab gitlab-rake "gitlab:password:reset[root]"
mkdir -p ./data/config && cp gitlab.example.rb "$_"/gitlab.rb
