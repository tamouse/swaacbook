
# Table of Contents

1.  [Mocking GraphQL Mutations in Jest Tests](#org7b68ea6)
    1.  [Introduction](#orge0e93a4)
    2.  [A recent example](#orga9f50b3)
    3.  [Creating the mock implementation](#org3e759d1)


<a id="org7b68ea6"></a>

# Mocking GraphQL Mutations in Jest Tests

-   Time-stamp: <span class="timestamp-wrapper"><span class="timestamp">&lt;2018-11-04 Sun 08:17&gt;</span></span>
-   original date: <span class="timestamp-wrapper"><span class="timestamp">[2018-09-16 Sun]</span></span>
-   keywords: graphql, mutation, testing, mocking, jest, javascript, react


<a id="orge0e93a4"></a>

## Introduction

In creating react components that receive mutations from either the `graphql` HOC *Higher-order component* or from the `Mutation` component as a child function, I've been writing them as their own component class or function and exporting them, so they can be used in tests without the apollo client provider.

This still leaves open the issue of testing the component code that calls the mutation. Since a mutation returns a promise, the mock mutation passed in should return a promise that resolves to the same form.


<a id="orga9f50b3"></a>

## A recent example

I had a recent example where I am updating a job in our system, and the update mutation returns the updated job. Here's the graphql query:

    mutation JobUpdateMutation ($id: Int!, $job_update_input: JobUpdateInput!) {
      updateJob(id: $id, job_update_input: $job_update_input) {
        id job_number
      }
    }

The code under test would recieve that in a `mutate` property, and execute the mutation in an instance function:

    mutate(payload)
        .then(response => {
    	const {
    	    loading,
    	    error,
    	    data: { updateJob }
    	} = response
    	if (!loading && !error && updateJob) {
    	    self.props.onUpdate(updateJob)
    	}
        })
    }


<a id="org3e759d1"></a>

## Creating the mock implementation

Jest provides a rather nice mocking feature where you can implement how you want the mock to act when called. See <https://jestjs.io/docs/en/mock-functions#mock-implementations> for more info.

Implementing a promise-based mock is pretty easy:

    let MockMutate = jest.fn().mockImplementation(args => {
      return new Promise((resolve, reject) => {
        return resolve({
          loading: false,
          error: null,
          data: {
    	updateJob: args
          }
        })
      })
    })

Note that I'm just passing back the payload given the mutate function in the promise resolution. Since in this specific case I am not using the return from the mutation within the component, merely passing it along via a callback to the consumer of this component, I wasn't really worried about what got passed back beyond it being the structure assumed by the code.

