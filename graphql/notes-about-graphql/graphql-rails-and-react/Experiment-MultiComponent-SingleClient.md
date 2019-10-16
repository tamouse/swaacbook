# Multiple React components with Single Apollo client on a Rails view

An experiment to see if it's possible to have a global apollo client on the page with multiple react rails components.


## Create rails app:

    rails new my_app --skip-spring --skip-turbolinks --skip-coffee --skip-test --webpack=react --database=postgresql

## Add graphql ruby:

```
pushd my_app/
echo >> Gemfile
echo 'gem "graphql"' >> Gemfile
bundle
rails g graphql:install
bundle
```

# abandon Rails 6, back to Rails 5

## Create rails app:

    rails _5.2.3_ new my_app --no-rc --skip-spring --skip-turbolinks --skip-test --webpack=react --database=postgresql
    pushd my_app/
    bin/rails db:drop db:create db:migrate

## Add graphql:

```
gcob add-graphql
echo >> Gemfile
echo 'gem "graphql"' >> Gemfile
bundle
bin/rails g graphql:install
bundle
```

*NOW*, running the graphiql service works fine:

    bin/rails s

Open `http://localhost:3000/graphiql` brings up the IDE

## Add react-rails

Not just webpacker:react, we're also going to want the react-rails stuff for React Rails Components

```
echo >> Gemfile
echo 'gem "react-rails"' >> Gemfile
bundle
bin/rails g react:install
```

## Add some React Rails components

```
bin/rails g react:component HelloWorld
bin/rails g react:component GoodbyeWorld
bin/rails g controller Static welcome
```

Edit `app/views/static/welcome.html.erb` to include the two components:

```ruby
  <h3>Hello world react component</h3>
  <%= react_component('HelloWorld') %>

  <h3>Goodbye world react component</h3>
  <%= react_component('GoodbyeWorld') %>
```

## Add Apollo React Client

```
yarn add apollo-boost @apollo/react-hooks graphql
```

### Create the client

For this example, I'm building the client so it will be on the global context. In `app/javascript/apolloClient.js`:

```javascript
import ApolloClient from "apollo-boost"

window.GraphqlClient = new ApolloClient({
  uri: "/graphql",
})
```

### Update the React Rails components to use the client

The react components become:

```javascript
import React from "react"
import { ApolloProvider } from "@apollo/react-hooks"
import { gql } from "apollo-boost"
import { useQuery } from "@apollo/react-hooks"

function HelloWorld(props) {
  return (
    <ApolloProvider client={window.GraphqlClient}>
      <HelloWorldContent />
    </ApolloProvider>
  )
}

export default HelloWorld

const QUERY = gql`
  query TestFieldOnly {
    testField
  }
`

const HelloWorldContent = props => {
  const { loading, error, data } = useQuery(QUERY)
  if (loading) {
    return <p>Loading...</p>
  }

  if (error) {
    return <p>Error: {error}</p>
  }

  return (
    <div>
      <pre>
        <code>{JSON.stringify(data, null, 2)}</code>
      </pre>
    </div>
  )
}
```

(GoodbyeWorld is nearly identical)
