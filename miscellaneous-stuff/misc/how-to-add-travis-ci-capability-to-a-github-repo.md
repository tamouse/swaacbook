
# Table of Contents

1.  [How To: Add Travis CI Capability to a Github Repo](#how-to-add-travis-ci-capability-to-a-github-repo)
    1.  [Configuring `.travis.yml`](#configuring-.travis.yml)
        1.  [Setting the language](#setting-the-language)
        2.  [Environment Variables](#environment-variables)
        3.  [Additional Software](#additional-software)
        4.  [Prerequisite Steps](#prerequisite-steps)
    2.  [Travis Operations](#travis-operations)
        1.  [Bundler Caching](#bundler-caching)
        2.  [Bundler Options](#bundler-options)
    3.  [Final `.travis.yml` Contents](#final-.travis.yml-contents)
    4.  [Triggering a Travis Run](#triggering-a-travis-run)
    5.  [Acknowledgements](#acknowledgements)


<a id="how-to-add-travis-ci-capability-to-a-github-repo"></a>

# How To: Add Travis CI Capability to a Github Repo

-   published date: 2013-12-23 16:39
-   keywords: ["continuous-integration", "programming", "swaac", "testing"]
-   source:
-   redirect<sub>from</sub>: ["*blog/2013/12/23/how-to-add-travis-ci-capability-to-a-github-repo*"]

A&D has a private [Travis-CI](http://travis-ci.com) [server](https://magnum.travis-ci.com/) that is used to verify changes to our private repos. Initially, this repo did not use travis, since it didn't really have any automated tests to run.

As [I (Tamara)](https://github.com/tamouse) started adding RSpec tests, my colleague [Jason](https://github.com/dabootski) recommended including the repo in the travis CI environment as well. This wasn't quite as straight-forward as initially thought, so this attempts to document the pieces in pulling this together.

<div class="HTML">
<!&#x2013;more&#x2013;>

</div>


<a id="configuring-.travis.yml"></a>

## Configuring `.travis.yml`

The first part of getting a repository ready to run under Travis is to create a `.travis.yml` file to tell Travis how to build and test your repository.

The Travis documentation is fairly easy to understand, but no set of documentation is going to understand your specific repository's needs. There aren't enough examples for every possibly scenario, thus you need to really understand the environment needs of your application.

There are various elements that you need to set up:

1.  The language and language version
2.  Environment variables
3.  Other applications, libraries, servers, and so on that your application needs in order to run (e.g. Postgresql)
4.  Travis behavioural elements, such as caching, building, and so on

`.travis.yml` is (obviously) a YAML file, which is the standard for ruby applications.


<a id="setting-the-language"></a>

### Setting the language

Since we're testing a Rails application here, ruby is our language. The version we're using is 2.0.0 (with no particular build set at this point). The two sections we need in the `.travis.yml` file are:

    language: ruby
    rvm:
      - 2.0.0

You can set multiple values in the `rvm` section, to tell travis to run a build on each version. This can explode into a large build matrix, though, so be circumspect. This repo contains a `.ruby-version` file so it was easy to limit the versions to build with.

This would be the minimum required to get any Rails app running, but ours has a few more requirements.


<a id="environment-variables"></a>

### Environment Variables

*$repo* has some values it needs to pick up from the environment to run correctly. With the current set of tests, the Devise configuration parameter `secret_key_base` must be set. The `env_vars-sample.rb` file is used as a template for the `env_vars.rb` file that is used to set defaults if the values aren't set explicitly in the environment.

For the current set of tests, the only env<sub>var</sub> needed is `SECRET_KEY_BASE` to make the Devise gem happy. Environment variables are set in the `env` section of the `.travis.yml` file:

    env:
      SECRET_KEY_BASE="$(bundle exec rake secret)"

There is some secret sauce going on here. The `rake secret` task is one provided by the standard Rails installation that will re-generate a secret token, which is just a hashed string, and is quite suitable for the secret key base. The above setting results in travis running the following at the start of the build:

    export SECRET_KEY_BASE="$(bundle exec rake secret)"

which gives us exactly what we need for the run.

Although it is a travis default, I've also set the `RAILS_ENV` envar to `'test'` to ensure we're running in a test situation.


<a id="additional-software"></a>

### Additional Software

The database used in *$repo* is Postgresql version 9.2, because it makes use of the JSON variable type that was introduced at that version. Travis by default uses Postgresql v. 9.1, so we need to tell it what to use. The `addons` section lets us specify the version:

    addons:
      postgresql: 9.2


<a id="prerequisite-steps"></a>

### Prerequisite Steps

Travis has hooks that will run before and after certain events in the build. We need to make sure we have the right configuration files created and the database created that will work for our repo.

The `before_script` section lets us give bash commands that will run just before the test script starts.

1.  Configuration Files

    Every Rails app needs a `config/database.yml` file which must be modified by the user when starting up the application. However, a good rails practice is to make a sample configuration file which can be included in the repository, but not the specific configuration file which might contain passwords or other credentials that you don't want to put out in public or even semi-public.
    
    In addition, *$repo* has an environment variable initialization file, that has similar credential secrets that we don't want explicitly in the repository, so there is a `config/env_vars.sample.rb` file that is copied and modified if necessary.
    
    Since the sample defaults will work for our needs in the Travis CI environment, we can just copy them over directly. If the specific values in the non-sample files need to be set, you could run the sample file through sed, awk, perl, ruby or whatever to make the appropriate edits.
    
    We want to make sure we're putting our work in the proper directory. Travis provides a few environment variables to us, one of which is the `TRAVIS_BUILD_DIR` envar, that points to the directory of the current build.
    
    (Note these might be done quite differently when creating the production environment.)
    
        before_script:
          - /bin/cp $TRAVIS_BUILD_DIR/config/database.sample.yml $TRAVIS_BUILD_DIR/config/database.yml
          - /bin/cp $TRAVIS_BUILD_DIR/config/env_vars.sample.rb $TRAVIS_BUILD_DIR/config/env_vars.rb

2.  Creating The Testing Database

    For each travis run, we must create the testing database anew (travis does not persist databases across runs). Since we're using Postgresql, we simply run the client and create the database with the default user, `postgres` as specified by travis.
    
        before_script:
          - psql -c 'create database howto_repo_test;' -U postgres

3.  The `before_script` Section

    Combining the previous two subsections, the resultant `before_script` section that runs all these is:
    
        before_script:
          - /bin/cp $TRAVIS_BUILD_DIR/config/database.sample.yml $TRAVIS_BUILD_DIR/config/database.yml
          - /bin/cp $TRAVIS_BUILD_DIR/config/env_vars.sample.rb $TRAVIS_BUILD_DIR/config/env_vars.rb
          - psql -c 'create database howto_repo_test;' -U postgres


<a id="travis-operations"></a>

## Travis Operations


<a id="bundler-caching"></a>

### Bundler Caching

One thing that Travis can do for is cache our bundle operations, thus saving considerable time each build in creating the bundle environment. For this repo, there is a huge time savings from having to recompile local versions of native code (Nokogiri in particular takes a long time to build the native version).

We can tell Travis to cache the bundle within the `cache` section:

    cache: bundler


<a id="bundler-options"></a>

### Bundler Options

Normally, Travis runs bundler with just the `--deployment` option, but I've added `guard` and `pry` to the Gemfile to enable me to run continuous testing and debugging locally. We don't want these in the CI run, however, so I've put all the local stuff inside a `guard` group within the Gemfile. We need to tell Travis not to include it:

    bundler_args: --without guard --deployment

which tells bundler to omit the `guard` section, and install things as if this were a deployment.


<a id="final-.travis.yml-contents"></a>

## Final `.travis.yml` Contents

Putting the whole thing together:

    language: ruby
    cache: bundler
    bundler_args: --without guard --deployment
    rvm:
      - 2.0.0
    before_script:
      - /bin/cp $TRAVIS_BUILD_DIR/config/database.sample.yml $TRAVIS_BUILD_DIR/config/database.yml
      - /bin/cp $TRAVIS_BUILD_DIR/config/env_vars.sample.rb $TRAVIS_BUILD_DIR/config/env_vars.rb
      - psql -c 'create database howto_repo_test;' -U postgres
    env:
      RAILS_ENV=test
      SECRET_KEY_BASE="$(bundle exec rake secret)"
    addons:
      postgresql: 9.2


<a id="triggering-a-travis-run"></a>

## Triggering a Travis Run

Normally, Travis will begin a build whenever code is pushed to the repository if the repository contains a `.travis.yml` file. The thing you also need to do is turn on the service hooks for the repository to interact with TravisCI. To do this, you need to be able to change the settings of the repo on Github. Since I didn't have such permissions, Jason did this, but then it wasn't clear why builds were not starting.

The *other* issue with this is that if you've already created a pull request for a given branch, adding to that branch does *not* seem to trigger Travis builds. Once that PR was merged, then Travis builds began as expected.

At present, Travis will happily build anytime there is a push to *any* branch on Github, including new feature, bugfix, and chore branches. This includes any new or existing branches, so we don't have the first-time issue any more.


<a id="acknowledgements"></a>

## Acknowledgements

My thanks in particular to [Jason Bucki](https://github.com/dabootski) for his help on pushing me to do this and getting this up and running. Also thanks to [Kyle Kestell](https://github.com/kkestell) for his help on understanding the application and getting me up to speed.

