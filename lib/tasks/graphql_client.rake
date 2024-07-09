# https://github.com/github-community-projects/graphql-client
require "graphql/client"
require "graphql/client/http"

namespace(:graphql_client) do
  desc 'get all artist items'
  task all_artists: :environment do
    module SWAPI
      HTTP = GraphQL::Client::HTTP.new("http://localhost:3000/graphql")
      SCHEMA = GraphQL::Client.load_schema(HTTP)
      CLIENT = GraphQL::Client.new(schema: SCHEMA, execute: HTTP)
      QUERY = CLIENT.parse <<-'GRAPHQL'
      query {
        items {
          id
          title
          description
          artist {
            firstName
            lastName
            email
            createdAt
          }
        }
      }
    GRAPHQL
    end

    result = SWAPI::CLIENT.query(SWAPI::QUERY)
    puts result.data.items.inspect
  end
end
