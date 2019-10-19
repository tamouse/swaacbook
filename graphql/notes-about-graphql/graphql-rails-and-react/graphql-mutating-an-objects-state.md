# GraphQL: Mutating an Object’s State

* Time-stamp: &lt;2018-09-16 14:23:52 tamara.temple&gt;
* original date: 2017-08-20 11:08
* keywords: webdev, graphql, ruby, rails

### Intro

In our project, we have a class, Job, that includes a state machine to handle the different states the job can be in, such as `:unscheduled`, `:scheduled`, `:in_progress`, `:completed` , etc.

The various state transitions can include some extra logic, such as setting or clearing dates, recording the transition step, and a few other things. This means I can’t really use a typical mutation of just sending up attributes that change.

In addition, using the `graphql-ruby` gem with a root mutation that breaks out into other mutations via the fields, I didn’t want to populate that root mutation with a slew of entries.

### Approach

My approach was to create a `transitionJob` field in the root mutation:

```text
module Types
  class MutationType < Types::BaseObject
    field :transitionJob, mutation: Mutations::JobTransitionMutation
  end
end

```

Then write the mutation itself:

```text
module Mutations
  class JobTransitionMutation < BaseMutation
    
    argument :id, Integer, required: true, description: 'Job ID, NOT the job_number'
    argument :action, String, required: true, description: 'Action to perform: start, stop, restart, cancel, hold, unhold, complete'

    field :job, Types::JobGraphType, null: true
    field :errors, [String], null: true

    def resolve(id:, action:)
      super
      raise "User does not have rights to modify job" unless current_employee.has_rights_to?(:jobs, :modify)
      job = current_account.jobs.find(id)
      crank = ::JobEventCrank.new(
        job: job,
        current_employee: current_employee
      )
      crank.public_send(action)
      job.reload
      return { job: job }
    rescue StandardError => ex
      errors = [
        "Exception: #{ex} (#{ex.class})",
        "id: #{id}",
        "action: #{action}",
        "account_id: #{current_account.id}",
        "employee_id: #{current_employee.id}"
      ]

      Rails.logger.error errors.join(", ")
      return { errors: errors }
    end
  end
end

```

Down in the React client, the graphql to invoke that mutation looks like:

```text
mutation JobTransitionMutation($id: Int!, $action: String!) {
  transitionJob(id: $id, action: $action) {
    errors
    job {
      id
      status
      completed_on
    }
  }
}

```

A few React components create buttons that the user can press to change the various job states that are wrapped with the query above.

The `JobEventCrank` class is a simple PORO \("Plain Old Ruby Object"\) that pushes the Job state machine around \(i.e. "cranks it"\). It's not included here.

This took me a while to figure out, bouncing back and forth between the ruby side and the javascript side, and digging through a lot of documentation. I want to give a shoutout to the great folks at [Apollo Data](https://www.apollodata.com/) for their excellent documentation and to [Robert Mosolgo](https://github.com/rmosolgo) and the GitHub team for the [graphql-ruby](https://github.com/rmosolgo/graphql-ruby) gem.

Future plans include converting the action into an Enum type.

