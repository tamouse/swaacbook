
# Table of Contents



-   date: 2017-09-19 21:43
-   last update: Time-stamp: <span class="timestamp-wrapper"><span class="timestamp">&lt;2018-09-16 Sun 13:52&gt;</span></span>
-   keywords: webdev, graphql, apollo, react, mutations
-   source: <http://dev.apollodata.com/react/api-mutations.html>

Similar to queries, the [Apollo](http://dev.apollodata.com/)  [client](http://dev.apollodata.com/react/)  [graphql](http://dev.apollodata.com/react/api-graphql.html) HOC wraps a React
component with functionality in the properties.

Different from the query side, for mutations it provides a `mutate`
function on `props` that is called to perform the mutation. The `mutate`
function returns a Promise, so using the standard `.then()` and
`.catch()` chains work well.

The *canonical* form looks like this:

    function MyComponent({ mutate }) {
      return (
        <button onClick={() => {
          mutate({
    	variables: { foo: 42 },
          });
        }}>
          Mutate
        </button>
      );
    }
    export default graphql(gql`mutation { ... }`)(MyComponent);

Dereferencing the `mutate` function out of the properties in the
arguments list seems a popular thing to do. I prefer not to do this, as
I'd like to use more props.

An example, which performs a basic Login function form, looks like:

    import React from 'react'
    import {Redirect} from 'react-router-dom'
    import {graphql, gql} from 'react-apollo'
    
    const logInMutation = gql`
    mutation LogInUser($credentials: AuthProviderCredentials) {
      loginUser(credentials: $credentials)
      {token user {name email}}
    }`
    
    class LogIn extends React.Component {
      constructor(props) {
        super(props)
        this.state = {
          email: '',
          password: '',
          mutate: props.mutate,
          loggedIn: false,
        }
    
        this.handleChange = this.handleChange.bind(this)
        this.handleSubmit = this.handleSubmit.bind(this)
      }
    
      handleChange(e) {
        const target = e.target
        const value = target.type === 'checkbox' ? target.checked : target.value
        const name = target.name
    
        this.setState({
          [name]: value
        })
      }
    
    
      handleSubmit(e) {
        e.preventDefault()
    
        const credentials = {
          email: this.state.email,
          password: this.state.password,
        }
    
        this.state.mutate({
          variables: {
    	credentials,
          },
        }).then(response => {
          let token = response.data.loginUser.token
          window.sessionStorage.setItem('token', token)
          this.setState({
    	loggedIn: true,
          })
        })
      }
    
    
      render() {
        if (this.state.loggedIn) return <Redirect to="/"/>
        return (
          <div>
    	<form onSubmit={this.handleSubmit}>
    	  <div>
    	    <label>
    	      Email: <input type="email" name="email"
    			    value={this.state.email}
    			    onChange={this.handleChange}/>
    	    </label>
    	  </div>
    	  <div>
    	    <label>
    	      Password:  <input type="text" name="password"
    				value={this.state.password}
    				onChange={this.handleChange}/>
    	    </label>
    	  </div>
    	  <div>
    	    <input type="submit"/>
    	  </div>
    	</form>
          </div>
        )
      }
    }
    
    const LogInWithMutation = graphql(logInMutation)(LogIn)
    export default LogInWithMutation

